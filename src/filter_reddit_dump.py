"""
taken from: https://github.com/Watchful1/PushshiftDumps/blob/master/scripts/filter_file.py
and adopted to our needs
"""

import argparse
import zstandard

import numpy as np

import logging.handlers

import re
import os
import json
from datetime import datetime

import zstandard as zstd
import csv

# sets up logging to the console as well as a file
log = logging.getLogger("bot")
log.setLevel(logging.INFO)
log_formatter = logging.Formatter('%(asctime)s - %(levelname)s: %(message)s')
log_str_handler = logging.StreamHandler()
log_str_handler.setFormatter(log_formatter)
log.addHandler(log_str_handler)
if not os.path.exists("logs"):
	os.makedirs("logs")
log_file_handler = logging.handlers.RotatingFileHandler(os.path.join("logs", "bot.log"), maxBytes=1024*1024*16, backupCount=5)
log_file_handler.setFormatter(log_formatter)
log.addHandler(log_file_handler)


def get_json(line):
	try:
		obj = json.loads(line)
	except Exception as jsonE:
		# Clean the JSON data before parsing
		try:
			line_cleaned = line.replace("\\", "\\\\")
			line_cleaned = remove_control_characters(line_cleaned)
			obj = json.loads(line)
		
		except Exception as e:
			obj = None

	return obj

# Function to remove control characters from the selftext field
def remove_control_characters(text):
    return re.sub(r'[\x00-\x1F\x7F-\x9F]', '', text)

def read_and_decode(reader, chunk_size, max_window_size, previous_chunk=None, bytes_read=0):
	chunk = reader.read(chunk_size)
	bytes_read += chunk_size
	if previous_chunk is not None:
		chunk = previous_chunk + chunk
	try:
		return chunk.decode()
	except UnicodeDecodeError:
		if bytes_read > max_window_size:
			raise UnicodeError(f"Unable to decode frame after reading {bytes_read:,} bytes")
		log.info(f"Decoding error with {bytes_read:,} bytes, reading another chunk")
		return read_and_decode(reader, chunk_size, max_window_size, chunk, bytes_read)


def read_lines_zst(file_name):
	with open(file_name, 'rb') as file_handle:
		buffer = ''
		reader = zstandard.ZstdDecompressor(max_window_size=2**31).stream_reader(file_handle)
		while True:
			chunk = read_and_decode(reader, 2**27, (2**29) * 2)

			if not chunk:
				break
			lines = (buffer + chunk).split("\n")

			for line in lines[:-1]:
				yield line.strip(), file_handle.tell()

			buffer = lines[-1]

		reader.close()


def write_line_csv(writer, obj, is_submission):
	output_list = []
	output_list.append(str(obj['score']))	
	output_list.append(datetime.fromtimestamp(int(obj['created_utc'])).strftime("%Y-%m-%d"))
	if is_submission:
		output_list.append(obj['title'])
		output_list.append(str(obj['author_flair_text']))
		output_list.append(str(obj['link_flair_text']))
		output_list.append(
			str(obj['locked']) if 'locked' in obj else "False"
		)
		output_list.append(str(obj['over_18']))
	else:
		output_list.append(obj['is_submitter'])
	output_list.append(f"u/{obj['author']}")
	output_list.append(f"https://www.reddit.com{obj['permalink']}")
	if is_submission:
		if obj['is_self']:
			if 'selftext' in obj:
				output_list.append(obj['selftext'])
			else:
				output_list.append("")
		else:
			output_list.append(obj['url'])
	else:
		output_list.append(obj['body'])
	writer.writerow(output_list)

def parse_data(input_file, output_file, is_submission, from_date, to_date, max_lines):

	file_size = os.stat(input_file).st_size
	file_bytes_processed = 0
	created = None
	matched_lines = 0
	bad_lines = 0
	total_lines = 0

	# names=["idx", "date", "title","author","link", "body"])

	handle = open(output_file, 'w', encoding='UTF-8', newline='')
	writer = csv.writer(handle)
	
	for line, file_bytes_processed in read_lines_zst(input_file):
		if total_lines >= max_lines:
			print("MAX LINES REACHED")
			break
		total_lines += 1
		if total_lines % 1000 == 0:
			log.info(f"{created.strftime('%Y-%m-%d %H:%M:%S')} : {total_lines:,} : {bad_lines:,} : {(file_bytes_processed / file_size) * 100:.0f}%")
		try:

			obj = get_json(line)

			# dict_keys(['archived', 'author', 'author_flair_css_class', 'author_flair_text', 'brand_safe', 'contest_mode', 'created_utc', 'distinguished', 'domain', 'edited', 'gilded', 'hidden', 'hide_score', 'id', 'is_crosspostable', 'is_reddit_media_domain', 'is_self', 'is_video', 'link_flair_css_class', 'link_flair_text', 'locked', 'media', 'media_embed', 'no_follow', 'num_comments', 'num_crossposts', 'over_18', 'parent_whitelist_status', 'permalink', 'pinned', 'retrieved_on', 'score', 'secure_media', 'secure_media_embed', 'selftext', 'send_replies', 'spoiler', 'stickied', 'subreddit', 'subreddit_id', 'subreddit_type', 'suggested_sort', 'thumbnail', 'thumbnail_height', 'thumbnail_width', 'title', 'url', 'whitelist_status'])
						
			created = datetime.utcfromtimestamp(int(obj['created_utc']))

			if created < from_date:
				continue
			if created > to_date:
				continue

			write_line_csv(writer, obj, is_submission)
		
		except Exception as e:
			log.error(f"Error processing line: {e}")
			bad_lines += 1
			break
			# continue

if __name__ == "__main__":

	import argparse

	parser = argparse.ArgumentParser(description='Filter a zstandard compressed ndjson reddit dump file')
	# input file 
	parser.add_argument('--input_file', type=str, help='The input file to filter')
	# output file
	parser.add_argument('--output_file', type=str, help='The output file to write to', default="default")

	# filter by date
	parser.add_argument('--from_date', type=str, help='The date to start filtering from, in YYYY-MM-DD format', default="2000-01-01")
	parser.add_argument('--to_date', type=str, help='The date to stop filtering at, in YYYY-MM-DD format', default="2024-01-01")

	# max lines
	parser.add_argument('--max_lines', type=int, help='The maximum number of lines to output', default=np.inf)

	args = parser.parse_args()

	input_file = args.input_file
	output_file = args.output_file

	if output_file == "default":
		output_file = f"../data/output/{input_file.split('/')[-1].split('.')[0]}.csv"

	from_date = datetime.strptime(args.from_date, "%Y-%m-%d")
	print(from_date)
	to_date = datetime.strptime(args.to_date, "%Y-%m-%d")

	max_lines = args.max_lines

	is_submission = "submission" in input_file
	
	parse_data(input_file, output_file, is_submission, from_date, to_date, max_lines)	