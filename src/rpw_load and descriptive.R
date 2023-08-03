library(readr)
RedPillWomen_submissions <- read_csv("~/Documents/SICSS2023/RPW/Data/RedPillWomen_submissions.csv", col_names = c("score", "date", "title", 'author_flair_text','link_flair_text','locked','over_18', "author","link", "body"))
View(RedPillWomen_submissions)

library(tidyverse)
library(quanteda)
library("dplyr")
library("quanteda")
library("text2vec")
library("irlba")
library("purrr")
library("ggplot2")

df_rpw <- RedPillWomen_submissions
head(df_rpw)

########descriptive overview

#how many NAs in body text
table(is.na(df_rpw$body))

#number of unique authors
length(unique(df_rpw$author))

#check if all posts are unique
length(unique(df_rpw$link))

f#histogram per time
df_rpw$date <- as.Date(df_rpw$date)
hist(table(df_rpw$date), xlab = "Date", main = "Amount of 'posts' per date")
str(df_rpw$date)
ggplot(df_rpw, aes(x = date)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "red") +
  scale_x_date(date_breaks = "year", date_labels = "%Y") +
  xlab("Date") +
  ylab("Amount of posts") +
  ggtitle("Amount of posts per day")

#bar chart of posts per year:
# Extract the year from the date
df_rpw$year <- format(df_rpw$date, "%Y")
# Calculate the count of posts per year
count_per_year <- table(df_rpw$year)
# Create the bar chart
barplot(count_per_year, xlab = "Year", ylab = "Amount of posts", main = "Amount of posts per Year")

#merge text of title and body into one string variable
df_rpw$text <- paste(df_rpw$title, df_rpw$body)


##look at deletions over time
df_deleted <- filter(df_rpw, body == c("[deleted]", "[removed]"))

ggplot(df_deleted, aes(x = date)) +
  geom_histogram(binwidth = 1, fill = "steelblue", color = "red") +
  labs(title = "Frequency of [deleted] or [removed] posts over time", x = "Date", y = "Frequency") +
  theme_minimal()

#deleted/removed per year
df_summary <- df_rpw %>%
  filter(!is.na(body)) %>%
  mutate(year = lubridate::year(date)) %>%
  group_by(year) %>%
  summarize(deleted_count = sum(body == c("[deleted]", "[removed]")))
print(df_summary)



##look at authors over time
df_authors <- df_rpw %>%
  mutate(author = ifelse(author == "u/[deleted]", "u/[deleted]", "Others")) %>%
  group_by(date, author) %>%
  summarise(author_count = n())

ggplot(df_authors, aes(x = date, y = author_count, fill = author)) +
  geom_col() +
  scale_fill_manual(values = c("Others" = "steelblue", "u/[deleted]" = "red")) +
  labs(title = "Frequency of authors over time",
       x = "Date",
       y = "Number of authors",
       fill = "Author") +
  theme(legend.position = "right") +
  theme_minimal()
