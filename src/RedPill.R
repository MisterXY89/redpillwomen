#Pre-Processing
library(spacyr)
library(dplyr)
library(quanteda.textstats)
library(psych)
library(ggplot2)
library(udpipe)

#Daten einlesen
reddit <- RedPillWomen_submissions_neu
colnames(reddit) <- c("score", "date", "title", 'author_flair_text',
                      'link_flair_text','locked','over_18', "author","link", 
                      "body")
reddit <- subset(reddit, !is.na(body) & body != "")

#IDs erstellen
numbers <- c(1:21596)
reddit$id <- numbers

#Leere und gelöschte Texte weglassen
reddit$ntok <- ntoken(reddit$body)
reddit <- subset(reddit, ntok > 3)

#Text mit Title zusammenpacken
reddit$text <- paste(reddit$title, reddit$body)
reddit$ntok <- ntoken(reddit$text)

save(reddit, file = paste0("reddit_full.RData"))

#Daten filtern
reddit <- subset(reddit, reddit$ntok > 49 & reddit$ntok < 1001)
summary(reddit$ntok)

save(reddit, file = paste0("reddit_ber.RData"))

#Dependency parsing
corpus_reddit <- corpus(reddit, text_field = "text")
i <- 1 
data_parsed <- data.frame()
for (text in corpus_reddit) {
  frame_1 <- text %>%
    #change format for udpipe package
    as_tibble() %>%
    mutate(doc_id = paste0("text", i)) %>%
    rename(text = value) %>%
    #for simplicity, run for fewer documents
    slice_head %>%
    #dependency parsing, include only related variables
    udpipe("english") %>% 
    select(doc_id, sentence_id, token_id, token, head_token_id, dep_rel)
  data_parsed <- rbind(data_parsed, frame_1)
  i <- i+1
}


save(data_parsed, file = paste0("data_parsed.RData"))


words <- data.frame()
# Arbeiten mit amod
for (i in 1:9999) {
  frame <- filter(data_parsed, doc_id == paste("text", i, sep = ""))
  max_sent <- as.numeric(max(frame$sentence_id))
  
  for (a in 1:max_sent) {
    sent <- filter(frame, sentence_id == a)
    
    for (row in 1:nrow(sent)) {
      if (sent$token[row] == "male") {
        womenid <- sent$token_id[row]
        subset_words <- filter(sent, head_token_id == womenid)
        words <- rbind(words, subset_words)
      }
    }
  }
}
words_amod <- filter(words, dep_rel == "amod")

save(words, file = paste0("words_male.RData"))
save(words_amod, file = paste0("words_male_amod.RData"))

#MEHR DATAFRAMES GENERIEREN
words <- data.frame()
# Arbeiten mit amod
for (i in 1:9999) {
  frame <- filter(data_parsed, doc_id == paste("text", i, sep = ""))
  max_sent <- as.numeric(max(frame$sentence_id))
  
  for (a in 1:max_sent) {
    sent <- filter(frame, sentence_id == a)
    
    for (row in 1:nrow(sent)) {
      if (sent$token[row] == "girl") {
        womenid <- sent$token_id[row]
        subset_words <- filter(sent, head_token_id == womenid)
        words <- rbind(words, subset_words)
      }
    }
  }
}
words_amod <- filter(words, dep_rel == "amod")

save(words, file = paste0("words_girl.RData"))
save(words_amod, file = paste0("words_girl_amod.RData"))

words <- data.frame()
# Arbeiten mit amod
for (i in 1:9999) {
  frame <- filter(data_parsed, doc_id == paste("text", i, sep = ""))
  max_sent <- as.numeric(max(frame$sentence_id))
  
  for (a in 1:max_sent) {
    sent <- filter(frame, sentence_id == a)
    
    for (row in 1:nrow(sent)) {
      if (sent$token[row] == "boy") {
        womenid <- sent$token_id[row]
        subset_words <- filter(sent, head_token_id == womenid)
        words <- rbind(words, subset_words)
      }
    }
  }
}
words_amod <- filter(words, dep_rel == "amod")

save(words, file = paste0("words_boy.RData"))
save(words_amod, file = paste0("words_boy_amod.RData"))

words <- data.frame()
# Arbeiten mit amod
for (i in 1:9999) {
  frame <- filter(data_parsed, doc_id == paste("text", i, sep = ""))
  max_sent <- as.numeric(max(frame$sentence_id))
  
  for (a in 1:max_sent) {
    sent <- filter(frame, sentence_id == a)
    
    for (row in 1:nrow(sent)) {
      if (sent$token[row] == "girlfriend") {
        womenid <- sent$token_id[row]
        subset_words <- filter(sent, head_token_id == womenid)
        words <- rbind(words, subset_words)
      }
    }
  }
}
words_amod <- filter(words, dep_rel == "amod")

save(words, file = paste0("words_girlfriend.RData"))
save(words_amod, file = paste0("words_girlfriend_amod.RData"))

words <- data.frame()
# Arbeiten mit amod
for (i in 1:9999) {
  frame <- filter(data_parsed, doc_id == paste("text", i, sep = ""))
  max_sent <- as.numeric(max(frame$sentence_id))
  
  for (a in 1:max_sent) {
    sent <- filter(frame, sentence_id == a)
    
    for (row in 1:nrow(sent)) {
      if (sent$token[row] == "boyfriend") {
        womenid <- sent$token_id[row]
        subset_words <- filter(sent, head_token_id == womenid)
        words <- rbind(words, subset_words)
      }
    }
  }
}
words_amod <- filter(words, dep_rel == "amod")

save(words, file = paste0("words_boyfriend.RData"))
save(words_amod, file = paste0("words_boyfriend_amod.RData"))


words <- data.frame()
# Arbeiten mit amod
for (i in 1:9999) {
  frame <- filter(data_parsed, doc_id == paste("text", i, sep = ""))
  max_sent <- as.numeric(max(frame$sentence_id))
  
  for (a in 1:max_sent) {
    sent <- filter(frame, sentence_id == a)
    
    for (row in 1:nrow(sent)) {
      if (sent$token[row] == "husband") {
        womenid <- sent$token_id[row]
        subset_words <- filter(sent, head_token_id == womenid)
        words <- rbind(words, subset_words)
      }
    }
  }
}
words_amod <- filter(words, dep_rel == "amod")

save(words, file = paste0("words_husband.RData"))
save(words_amod, file = paste0("words_husband_amod.RData"))

words <- data.frame()
# Arbeiten mit amod
for (i in 1:9999) {
  frame <- filter(data_parsed, doc_id == paste("text", i, sep = ""))
  max_sent <- as.numeric(max(frame$sentence_id))
  
  for (a in 1:max_sent) {
    sent <- filter(frame, sentence_id == a)
    
    for (row in 1:nrow(sent)) {
      if (sent$token[row] == "wife") {
        womenid <- sent$token_id[row]
        subset_words <- filter(sent, head_token_id == womenid)
        words <- rbind(words, subset_words)
      }
    }
  }
}
words_amod <- filter(words, dep_rel == "amod")

save(words, file = paste0("words_wife.RData"))
save(words_amod, file = paste0("words_wife_amod.RData"))

#Ergebnisse zusammenfassen und analysieren

load("/Users/nozornina/Downloads/full_export/words_woman_amod.RData")
words_woman <- words_amod
load("/Users/nozornina/Downloads/full_export/words_women_amod.RData")
words_women <- words_amod
load("/Users/nozornina/Downloads/full_export/words_man_amod.RData")
words_man <- words_amod
load("/Users/nozornina/Downloads/full_export/words_men_amod.RData")
words_men <- words_amod

adj_woman <- bind_rows(words_woman, words_women)
adj_woman$gender <- "woman"
adj_woman$token <- tolower(adj_woman$token)
adj_man <- bind_rows(words_man, words_men)
adj_man$gender <- "man"
adj_man$token <- tolower(adj_man$token)

#Frequenz berechnen
freq_table <- table(adj_woman$token)
freq_df <- as.data.frame(freq_table)
colnames(freq_df) <- c("token", "freq")
adj_woman_freq <- merge(adj_woman, freq_df, by = "token", all.x = TRUE)

freq_table <- table(adj_man$token)
freq_df <- as.data.frame(freq_table)
colnames(freq_df) <- c("token", "freq")
adj_man_freq <- merge(adj_man, freq_df, by = "token", all.x = TRUE)

#Frequent words plotten
words_wordcounts <- adj_woman %>% count(token, sort = TRUE)
words_wordcounts %>% 
  filter(n > 5) %>% 
  mutate(word = reorder(token, n)) %>% 
  ggplot(aes(word, n)) + 
  geom_col() +
  coord_flip() +
  labs(x = "Word \n", y = "\n Count ", title = "Frequent Words") +
  geom_text(aes(label = n), hjust = 1.2, colour = "white", fontface = "bold") +
  theme(plot.title = element_text(hjust = 0.5), 
        axis.title.x = element_text(face="bold", colour="darkblue", size = 12),
        axis.title.y = element_text(face="bold", colour="darkblue", size = 12))

#Duplikate weglassen
adj_man_freq <- adj_man_freq %>%
  filter(!duplicated(token))
adj_woman_freq <- adj_woman_freq %>%
  filter(!duplicated(token))

#Einzelne Wörter löschen
adj_woman_freq_set <- adj_woman_freq %>%
  filter(!(token %in% c("other", "many", "most", "much", "more", "few", "only", "average", "several", "multiple", "first", "red", "blue", "such", "redpill")))
adj_man_freq_set <- adj_man_freq %>%
  filter(!(token %in% c("other", "many", "most", "much", "more", "few", "only", "average", "several", "multiple", "first", "red", "blue", "such", "redpill")))

#adj_woman_freq_set <- adj_woman_freq_set %>% arrange(desc(freq))
#adj_man_freq_set <- adj_man_freq_set %>% arrange(desc(freq))
#adj_woman_freq_set <- head(adj_woman_freq_set, 50)
#adj_man_freq_set <- head(adj_man_freq_set, 50)

adj_all <- bind_rows(adj_woman_freq_set, adj_man_freq_set)

#Adjektive filtern
adj_diff <- data.frame(wort = unique(adj_all$token))
for (row in 1:nrow(adj_diff)) {
  word <- adj_diff$wort[row]
  occur <- filter(adj_all, token == word)
  
  occur_man <- filter(occur, gender == "man")
  if (nrow(occur_man) > 0) {
    adj_diff$man[row] <- occur_man$freq[1]
  }
  else {
    adj_diff$man[row] <- 0
  }
  
  occur_woman <- filter(occur, gender == "woman")
  if (nrow(occur_woman) > 0) {
    adj_diff$woman[row] <- occur_woman$freq[1]
  }
  else {
    adj_diff$woman[row] <- 0
  }
}

#Differenz und Summe berechnen
adj_diff$diff <- adj_diff$woman - adj_diff$man
adj_diff$sum <- adj_diff$man + adj_diff$woman

#Nach Summe filtern und Differenz standartisieren
adj_diff_set <- adj_diff %>% arrange(desc(sum))
adj_diff_set <- head(adj_diff_set, 40)
adj_diff_stand <- adj_diff_set %>% 
  mutate(diff_stand = as.vector(scale(diff, center = 0))) %>% 
  arrange(diff_stand)

#Ergebnisse plotten
library(unikn)
p2 <- usecol(pal = c(rev(pal_seegruen), "white", pal_bordeaux), n = 40, alpha = .60) 
p2

plot <- ggplot(adj_diff_stand, aes(reorder(wort, diff_stand), diff_stand, fill = diff_stand)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 12), 
        axis.text.y = element_text(size = 12),
        plot.title = element_text(size = 14),
        legend.position = "none") +
  xlab("") +
  ggtitle("Adjectives men vs. women") +
  ylab("Men                                                               Women") +
  coord_flip() +
  scale_fill_gradient(low = p2[1], high = p2[length(p2)])
plot

#Beispiel von dependency parsing plotten
library("rsyntax")
library(udpipe)
sentence <- udpipe("Starting dating the most wonderful man", "english") %>%
  as_tokenindex() %>%
  plot_tree(., token, lemma, upos)