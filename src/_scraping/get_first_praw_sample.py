import os
import requests

import numpy as np
import pandas as pd

import praw
from pmaw import PushshiftAPI

import datetime as dt
from tqdm import tqdm

from config import cf


class Scrape(object):

    def __init__(self, subreddit_name):
        self.submission_cols = ["author","author_flair_text","link_flair_text","comments","created_utc","edited","id","locked","num_comments","over_18","permalink","score","selftext","title","upvote_ratio"]
        self.comment_cols = ["author","body","created_utc","edited","id","is_submitter","link_id","parent_id","permalink","score","subreddit_id"]        
    
        self.reddit = praw.Reddit(
            client_id = cf.client_id,
            client_secret = cf.client_secret,
            user_agent = cf.user_agent
        )

        self.subreddit = self.reddit.subreddit(subreddit_name)
        self.subreddit_name = subreddit_name


        # get absolute path to the data folder:
        
        self.output_file_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "data", f"reddit_submissions_praw_samples.csv")

    def _extract_attr(self, obj, attr):
        try:
            return getattr(obj, attr)
        except Exception as e:
            return ""
    
    def _extract_comments(self, comments):
        comments_list = []
        for comment in comments:

            comments_list.append({
                "author": self._extract_attr(comment, "author"),
                "body": self._extract_attr(comment, "body"),
                "created_utc": self._extract_attr(comment, "created_utc"),
                "edited": self._extract_attr(comment, "edited"),
                "id": self._extract_attr(comment, "id"),
                "is_submitter": self._extract_attr(comment, "is_submitter"),
                "link_id": self._extract_attr(comment, "link_id"),
                "parent_id": self._extract_attr(comment, "parent_id"),
                "permalink": self._extract_attr(comment, "permalink"),
                "score": self._extract_attr(comment, "score"),
                "subreddit_id": self._extract_attr(comment, "subreddit_id")
            })
            if self._extract_attr(comment, "replies"):
                comments_list.extend(self._extract_comments(comment.replies))

        return comments_list


    def get_submissions(self, limit=1000):
        latest_posts = []
        for post in tqdm(self.subreddit.new(limit=limit), total=limit, desc="Downloading submissions"):
            extracted_comments = self._extract_comments(post.comments)
            latest_posts.append({
                "author": post.author,
                "author_flair_text": post.author_flair_text,
                "link_flair_text": post.link_flair_text,
                "comments": extracted_comments,
                "created_utc": post.created_utc,
                "edited": post.edited,
                "id": post.id,
                "locked": post.locked,
                "num_comments": post.num_comments,
                "over_18": post.over_18,
                "permalink": post.permalink,
                "score": post.score,
                "selftext": post.selftext,
                "title": post.title,
                "upvote_ratio": post.upvote_ratio
            })

        print("Number of submissions: ", len(latest_posts))

        # create a dataframe from the list of dictionaries:
        df = pd.DataFrame(latest_posts)

        # convert the created_utc column to datetime:
        df["created_utc"] = pd.to_datetime(df["created_utc"], unit="s")

        # save the dataframe as a csv file:
        df.to_csv(self.output_file_path, index=False)

    

if __name__ == "__main__":
    advice_scraper = Scrape("RedPillWomen")
    # advice_scraper.get_submissions_PS(limit=5000)

    advice_scraper.get_submissions(limit=50)
