# r/redpillwomen

## Data collection

We first tried multiple approaches to obtain the most recent data from the subreddit. However, we were not able to get the desired amount of posts (limit of 1000 posts for every (non-paid) approach.

1. We tried to collect data from the subreddit using PRAW, but it was not possible to get all the data (limit of 1000 posts).
2. Trying to scrape the data from the website, we found that the website is dynamic and the data is loaded using JavaScript, therefore we used selenium. But they used a lot of shadow DOMS, which made it difficult to get the data.
3. We used JS, employed directly in the browser, to get the data. The code can be found here: `src/_scrapeing/scroll_and_link_extract.js`. However, we were not able to get all the data, as the website itself also has a limit of 1000 posts.

As our approach to collect the data ourselfs and use the most recent data did not work, we decided to use the data from [pushshift](https://academictorrents.com/details/c398a571976c78d346c325bd75c47b82edf6124e).
Here we used the most recent data dump which is from Feb, 28 2023.

```

## Overview
- [Concept](https://docs.google.com/document/d/1rZtfiXTJh3QH4LyoYMtVKNVjwW7fsVMTI70lqLdHBT4/edit?usp=sharing)
- [Google Drive folder](https://drive.google.com/drive/folders/18A3VU6Mtl2IXaB1RfSJhaJISUAlMB0Y8?usp=sharing)