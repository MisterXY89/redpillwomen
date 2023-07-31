
import os
from dotenv import load_dotenv

load_dotenv(verbose=True)

class Config:
    def __init__(self):
        self.client_id = os.getenv("client_id")
        self.client_secret = os.getenv("client_secret")
        self.user_agent = int(os.getenv("user_agent"))

cf = Config()