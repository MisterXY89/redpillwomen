"""
data-adclicklocation="title"
class="_1poyrkZ7g36PawDueRza-J _11R7M_VOgKO1RJyRSRErT3 _1Qs6zz6oqdrQbR7yE_ntfY"

"""

import time
import requests
import datetime as dt

import numpy as np
import pandas as pd


import praw
from pmaw import PushshiftAPI
from tqdm import tqdm

from selenium import webdriver
from selenium.webdriver.common.by import By

from config import cf


class Scrape(object):

    def __init__(self, subreddit_name):
        self.submission_cols = ["author","author_flair_text","link_flair_text","comments","created_utc","edited","id","locked","num_comments","over_18","permalink","score","selftext","title","upvote_ratio"]
        self.comment_cols = ["author","body","created_utc","edited","id","is_submitter","link_id","parent_id","permalink","score","subreddit_id"]        

        self.reddit = praw.Reddit(
            client_id = cf.client_id,
            client_secret = cf.client_secret,
            user_agent = cf.user_agent
            # username = cf.username
        )        
        self.subreddit_name = subreddit_name
        self.subreddit = self.reddit.subreddit(self.subreddit_name)        

        self.scroll_pause = 0.5
        self.post_urls = []

    def get_post_urls(self, n=10):
        # use selenium to get the urls of the n latest posts from a subreddit:
        start_url = f"https://www.reddit.com/r/{self.subreddit_name}/new/"
        self.driver = webdriver.Chrome()
        self.driver.get(start_url)
        self.desired_num_posts = n

        time.sleep(3)
        # reject cookies
        # find button by text: Reject non-essential
        all_buttons = self.driver.find_elements(By.TAG_NAME, "button")
        print(all_buttons)
        try:
            reject_button = [button for button in all_buttons if button.text == "Reject non-essential"][0]
        except Exception as e:
            print(e)            
            reject_button = [button.text for button in all_buttons]
            print(reject_button)
        reject_button.click()
        time.sleep(1)

        self._scroll_and_collect()
        self.driver.close()
        return self.post_urls[:n]

    def _extract_post_urls(self):
        # get all urls in the current page that include /comments/
        # if "/comments/" in a.get_attribute("href")
        scroller_item_divs = self.driver.find_elements(By.CLASS_NAME, "scrollerItem")
        # print(scroller_item_divs)
        # print(len(scroller_item_divs))

        # for every scrollerItem click on the div and get the url and add it to the list, then close the div (press escape)
        for scroller_item_div in scroller_item_divs:
            print(scroller_item_div)
            try:
                scroller_item_div.click()
            except Exception as e:
                # print(e)
                continue
            time.sleep(self.scroll_pause)
            self.post_urls.append(self.driver.current_url)            
            self.driver.find_element(By.TAG_NAME, "body").send_keys("Escape")

        # remove duplicates
        self.post_urls = list(set(self.post_urls)) 

        if len(self.post_urls) > self.desired_num_posts:
            self.driver.close()
            return False

    def _scroll_and_collect(self):        
        # Get scroll height
        # last_height = self.driver.execute_script("return document.body.scrollHeight")

        time.sleep(20)

        while True:
            # # Scroll down to bottom
            # self.driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")

            # Wait to load page
            time.sleep(self.scroll_pause)

            # # Calculate new scroll height and compare with last scroll height
            # new_height = self.driver.execute_script("return document.body.scrollHeight")
            # if new_height == last_height:
            #     break
            # last_height = new_height


            self._extract_post_urls()

if __name__ == "__main__":
    advice_scraper = Scrape("RedPillWomen")
    # advice_scraper.get_submissions_PS(limit=5000)

    urls = advice_scraper.get_post_urls()
    print(urls)
