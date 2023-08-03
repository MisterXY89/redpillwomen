######dictionary
library(quanteda)
library(dplyr)

#load cleaned dataset (no NAs in body)
df_clean <- read_csv("~/Documents/SICSS2023/RPW/Data/df_clean.csv")
View(df_clean)

df <- df_clean


#create dicitionary from glossary

glossary <- ("Alpha – Socially dominant. Somebody who displays high value, or traits that are sexually attractive to women. Alpha can refer to a man who exhibits alpha behaviors (more alpha tendencies than beta), but usually used to describe individual behaviors themselves.

Alpha Widow - A woman (typically but not necessarily post-wall) who has been abandoned by an Alpha male. No matter how great her new man is, she will perceive him as failing to meet the standard of the alpha she was previously associated with. Due to hypergamy, a woman cannot date backwards, once she gets say, a male 8, she cannot date below a male 8 and be happy with him. If she does, she is just using said man for resources (BB) and doesn't really love him. Essentially, a damaged woman accustomed to a tier of man she can no longer attract. See  Post-wall  and  Hypergamy. 

AMOG – Alpha Male Of Group.

AF/BB - Alpha Fucks/Beta Bucks.

ASD - Anti-Slut Defense.

AWALT - All Women Are Like That. Often expressed after an example of hypergamy.

Beta – Traits of provision: either providing resources or validation to others, women (and perhaps men). Beta traits display low value to women if they are are put on too strong or too early in meeting- giving without equity. Beta can be used to describe individual behaviors, as well as people who have an overwhelming amount of beta properties (opposed to alpha).

Blue Pill – From The Matrix and its sequels. The path of conformity with Society’s expectations; the state of being unaware of the problems engendered by society. Compare with “Red Pill,” below.

CC, or Cock Carousel – The period of time in a woman's life where she successfully exploits her sexual value and maximizes her hypergamous tendencies by having sex with as many alphas as possible. Usually happens between ages 18 - 27. Often ends when the woman hits the wall.

Close - The apex of an interaction. Often preceded by an indication of the type of close, eg. f-close (full close or fuck close, the interaction led to sex), k-close (kiss), #close (receiving phone #).

Comfort Test - Similar to a Shit Test, but meant to gauge your level of Beta traits. Typically only encountered in LTRs. While not discussed as often as shit tests, a successful LTR requires that you pass these as well.

Covert Contract - An unspoken deal with terms the other party would never agree to. Most typically seen by orbiters trying to negotiate desire:  If I do a favor for her, she'll go out with me. 

DT, or Dark Triad - A combination of three personality traits: Narcissism, Machiavellianism, and Psychopathy. An effective short-term sexual strategy.

DHV – Display of Higher Value, the accomplishment, anything that improves your sexual market value in the eyes of another.

DLV- Display of lower value.

DQ - Disqualification. Used by women as an IOD. Used by PUAs as a method of disarming ASD by appearing to be disinterested.

Dread Game - Purposefully inciting jealousy in an LTR by openly getting attention from other women. Soft Dread is similar, but less open. With Soft Dread, the attention doesn't even need to be real. Creating the possibilty for female attention is enough to get the hamster going. (If you develop a great body, she knows that other women will find that attractive without having to actually see other women displaying interest.) The purpose of using Dread is to get the target (wife, girlfriend, plate) to step up their game to compete with other interested women.

Feminism – ”A doctrine built on the pre-supposition of victimhood of women by men as a foundation of female identity. In its goals is always the utilization of the state to forcibly redress this claimed victimization. In other words, the proxy use of violence and wealth appropriation. In whatever flavor, and variation, these two basic features are common to every doctrine using the label feminism. Feminism is therefore, a doctrine of class hatred, and violence.” (John The Other, “Why not date a feminist?” A Voice For Men, 4 June 2012.)
             
FR - Field Report.
             
Frame - The context in which something is perceived. Maintaining frame is often cited as the most important aspect of Alpha behavior.
             
Friendzone - See Orbiter.
             
Game – A loosely based set of behaviors specifically designed to increase attraction.
             
Gaslighting - A form of mental abuse in which false information is presented with the intent of making victims doubt their own memory, perception, and sanity.
             
Hamster - Used to describe the way that women use rationalization to resolve mental conflict and avoid cognitive dissonance. The core mechanism that allows women to say one thing and do a different thing.
             
HB - Hot Babe (often followed by a number as an indication of ranking on a 1-10 scale).
             
Hypergamy – The instinctual urge for women to seek out the best alpha available. This is marked by maximizing rejection (therefore women are the selective gender). A woman will vet her alpha through various shit tests to ensure his  health  on the alpha scale. She is conditioned to recognize a declining alpha, as hypergamy also tends to continue seeking out higher status males even while with an alpha male. Shit tests allow her to prepare herself for eventually leaving when a new higher status male is found. If the male fails shit tests to a great enough degree, it will effect her feelings for him. He will effectively lower his sexual market value in her eyes. This will enable her to jump to the next male with ease and little remorse.
             
Incel - Involuntarily Celibate. A man who wants to get laid, but can't.

IOD - Indication of Disinterest.

IOI - Indication of Interest.

Kino (Kino Escalation) -  Kino  means touching. Kino escalation is the process of ramping up the touching from light touching to heavy (though still not entirely sexual).

LJBF - Let's Just Be Friends (See Orbiter)
             
LMR- Last Minute Resistance. A display of ASD immediately prior to closing
             
LTR - Long Term Relationship.
             
Manosphere - The loose collection of blogs, message boards, and other sites run by and/or read by MRAs, MGTOW, PUAs etc and any red pill associated people/groups.
             
MGTOW – Men Going Their Own Way; the growing contingent of the male population who are saying “Fuck It All” to the Mating Dance. See r/MGTOW
             
MMSL - The Married Man Sex Life Primer. A book written by Athol Kay specifically focused on marriage game.
             
Monk Mode - Mitigating distractions and focusing on introspection, reflection and self-improvement for a given period of time. Working on the body and mind.
             
MR - Men's Rights Group.

MRA - Men's Rights activist. See r/MensRights
             
MRM - Men's Rights Movement.

Oneitis - When a guy has fallen in love with a woman in the same way a boy loves his mother. He obsesses about her, but she does not reciprocate.

ONS - One Night Stand

Orbiter - Also known as Beta Orbiter. A beta guy who accepted the proposal to  just be friends  from a girl he has oneitis for. He will stick around her and constantly validate her whenever she requests it. Also known as  friendzone.  She will keep him around because he will do anything for her and provide validation, giving small hints that he might eventually win her love- but he never will. Typical signs of orbiter status: likes and comments on new facebook photos. Go-to guy when girl has problem with boyfriend. Also known as emotional tampon.

Plate - Woman with whom you are in a non-exclusive sexual relationship with. Spinning plates is the act of having multiple plates simultaneously. Again, Rollo has a great article found here.

Post-wall - A woman past her peak beauty/fertility. Depending on genetics, this can be a woman as young as 25 or as old as 40. Generally speaking, it is agreed most women hit the wall around 30. Women tend to become desperate to settle down around age 28/29, realizing they have limited time to secure a quality mate as their beauty diminishes. See  The Wall. 

Preselection - The idea that women are more attracted to men who already have the interest of other women. This saves the woman time in judging a man by using the idea that other women have already judged him favorably.

PUA – Pick-Up Artist.

Pussy Pass - Letting a woman off without actual consequences for illegal behavior. See r/PussyPass for examples.

Red Pill – The recognition and awareness of the way that feminism, feminists and their white-knight enablers affect society. An awareness of the dark truths surrounding human sexuality; hypergamy, women's AF/BB strategies, society's Feminine Imperative, sexual differences in emotional attachment, women's attraction to DT traits and sexual dominance/violence; Extremely politically incorrect, expect reflexive social ostracism for even mentioning the red pill in polite society.
             
RMV - Relationship Market Value. A shorthand statement for “what you bring to the table,” includes the notion of SMV, but more geared towards value as a long relationship partner.
             
Set - A group of people that you are interacting with.
             
Shit Test, or Fitness Test - A statement or question meant to gauge your level of Alpha traits.
             
SJW - Social Justice Warrior.
             
SMV – Sexual Market Value. A shorthand statement for “what you bring to the table,” whether for an one-night stand or for a longer sexual/emotional relationship.
             
SMP - Sexual Market Place. A description of the free market that is mating.
             
Snowflake - A woman who tries to persuade a man that she’s somehow unique, different, or special by playing up her good girl resume and downplaying her bad girl resume. When used as a verb, snowflaking refers to the argument she puts forth to justify her claim.
             
Solipsism - In Red Pill, solipsism (e.g. female solipsism) refers to the female's tendency to frame everything she experiences or witnesses in terms of herself and her own needs - personalizing it **- even when such personalization would not make contextual sense.

The Wall - The point in a woman's life where her ego and self-assessed view of her sexual market value exceed her actual sexual market value; the beginning of the decline. Usually occurs as a wake-up shock to women when they realize that their power over men was temporary and that their looks are fading. This usually results with first denial and then a sudden change in priority towards looking for a husband. Even after hitting the wall, many women will squander a few more precious years testing her SMV with alphas to double-check, hoping her perceived decline was a fluke, this will make her even more bitter when she finally has to settle for a worse-beta than she could've gotten before because of squandering her youth.

Trickle Truth - A method of coming clean about bad behavior by only disclosing small pieces of truth at a time.  All we did was talk,  leads to  Well we just cuddled,  leads to  I didn't mean to fuck him, it just happened.  It's a hamsters way of saving face when bad behavior is discovered.

Unicorn - Mystical creature that doesn't fucking exist, aka The Girl of Your Dreams.

White Knight – A man who “comes to the rescue” of a woman, or of women, reflexively, emotionally-driven, without thought or even looking at the situation; (2) a man in authority who enables Team Women in his legislative actions, judgments, or rulings, reflexively, emotionally-driven, without thought or even looking at what’s right. Also known as  Mangina")



install.packages("stringr")
library(stringr)

# Define the regular expression pattern

# Extract the relevant expressions using the regex pattern
matches <- str_extract_all(glossary, "(?<=\\n|^)(.+?)(?: –|-)(?=[ –-])")
matches <- unlist(matches)
print(matches)

cleaned_vector <- gsub("[-–]\\s*$", "", matches)
cleaned_vector <- gsub("[ \f\t\v]$", "", cleaned_vector)
# Print the cleaned vector
cleaned_vector

split_strings <- strsplit(cleaned_vector, ", or ")
split_strings <- strsplit(split_strings, "\\s+(?=\\()")
combined_strings <- unlist(split_strings)
print(combined_strings[32])

simple_strings <- gsub("\\s*\\(.*\\)", "", combined_strings)
print(simple_strings)

new_strings <- unlist(strsplit(simple_strings, "/"))
print(new_strings)

###save in dictionary vector
dictionary <- new_strings

dictionary <- append(new_strings, c("captain", "first_mate", "first-mate"))
print(dictionary)

##make all lowercase
dict_low <- tolower(dictionary)
print(dict_low)

dict_gloss <- dictionary(list(
  alpha="alpha", alpha_widow="alpha widow", amog="amog", af="af", bb="bb", asd="asd", awalt="awalt", beta="beta", blue_pill ="blue pill", cc=c("cc","cock carousel"),
  close="close", comfort_test="comfort test", covert_contract="covert contract", dt=c("dt", "dark triad"),
  dhv="dhv", dlv="dlv", dq="dq", dread_game = "dread game", 
feminism="feminism", fr="fr", frame="frame", friendzone="friendzone",
game="game", gaslighting="gaslighting", hamster="hamster", hb="hb",            
hypergamy="hypergamy", incel="incel", iod="iod", ioi="ioi", kino=c("kino", "kino escalation"),
ljbf="ljbf", lmr="lmr", ltr="ltr",            
manosphere="manosphere", mgtow="mgtow", mmsl="mmsl", monk_mode="monk mode",      
mr="mr", mra="mra", mrm="mrm", oneitis="oneitis",        
ons="ons", orbiter="orbiter", plate="plate", post_wall="post-wall",     
preselection="preselection", pua="pua", pussy_pass="pussy pass", red_pill=c("red pill", "rp"),       
rmv="rmv", set="set", shit_test=c("shit test", "fitness test"),   
sjw="sjw", smv="smv", smp="smp", snowflake="snowflake",
solipsism="solipsism", the_wall="the wall", trickle_truth="trickle truth", unicorn="unicorn",        
white_knight="white knight", captain="captain", first_mate=c("first_mate", "first mate")))




#turn into dictionary
dict <- dictionary(dict_list)
dict_list <- as.list(dict_low)

####prepare dataset 
install.packages(c( 'quarto', 'stm', 'stminsights', 'textdata',  
                    'quanteda', 'quanteda.textstats', 
                    'quanteda.textmodels', 'quanteda.textplots',
                    'tidymodels'))
library(quanteda)
library(textdata)
library(quanteda.textstats)
library(quanteda.textmodels)
library(quanteda.textplots)

rpw_corp <- corpus(df, text_field = 'text', 
                     docid_field = 'id')
docvars(rpw_corp)$text <- df$text # store unprocessed text
ndoc(rpw_corp) # no. of documents

rpw_tokens <- tokens(rpw_corp, 
                       remove_numbers = TRUE, remove_punct = TRUE, remove_symbols = TRUE, remove_url = TRUE) # removing digits
rpw_tokens[[1]][1:20] # text 1, first 20 tokens

##stopwords
rpw_tokens <- rpw_tokens |> 
  tokens_tolower() |> 
  tokens_remove(stopwords('english'), 
                padding = TRUE) # keep empty strings

rpw_tokens[[1]][1:20]

##find collocations
colls <- textstat_collocations(rpw_tokens,
                               min_count = 200) # minimum frequency
rpw_tokens_c <- tokens_compound(rpw_tokens, colls) |> 
  tokens_remove('') # remove empty strings
rpw_tokens_c[[1]][1:20] # first five tokens of first text

##dfm 
dfm_rpw <- dfm(rpw_tokens_c)
dim(dfm_rpw)

#feature trimming
dfm_rpw <- dfm_rpw |> 
  dfm_keep(min_nchar = 2) |> # remove terms < 2 characters
  dfm_trim(min_docfreq = 0.001,  # 0.1% min
           docfreq_type = 'prop') # proportions instead of counts
dim(dfm_rpw)

##word cloud with most frequent words
textplot_wordcloud(dfm_rpw, max_words = 100, color = 'black')


##count dictionary frequencies
dict_match <- dfm_lookup(dfm_rpw, dict) # apply dictionary
textstat_frequency(dict_match)

dfm_rpw_gloss <- dfm_select(dfm_rpw, pattern = dict)
print(dfm_rpw_gloss)
dim(dfm_rpw_gloss)

topfeatures(dfm_rpw_gloss, 10)

tstat_freq <- textstat_frequency(dfm_rpw_gloss)
head(tstat_freq, 20)
head(dfm_rpw_gloss)

library(wordcloud2)

wordcloud2(data=tstat_freq, size=1.6)


dict[["glossary"]]

lookup <- dfm_lookup(dfm_rpw_gloss, dictionary = dict)
lookup.df <- convert(lookup, to = "data.frame")

#####now check for each post if any of the glossary features are in it
# Create an empty matrix to store the results
# Create a matrix to store the results
freq_gloss <- matrix(FALSE, nrow = nrow(dfm_rpw), ncol = length(dict_gloss))

# Loop through each document in the feature matrix
#for (i in 1:nrow(dfm_rpw)) {
for (i in 1:100) {
  # Loop through each word in the dictionary
  for (j in 1:length(dict_gloss)) {
    # Check if the word is present in the document
    if (all(dict_gloss[j] %in% colnames(dfm_rpw)) && any(dfm_rpw[i, colnames(dfm_rpw) == dict_gloss[j]] > 0)) {
      freq_gloss[i, j] <- TRUE  # Set the value to TRUE if the word is present
    }
  }
}

# Print the results
print(freq_gloss)

length(dict_list)
print(dict_list)
dict_gloss <- unlist(dict_list)
print(dict_gloss)
str(dict_gloss)
dict_gloss <- as.vector(dict_gloss)

dim(dfm_rpw)


# Convert date to Date format
dfm_rpw_gloss$date <- as.Date(dfm_rpw_gloss$date)

# Create an empty data frame to store the results
result <- data.frame(feature = character(), date = character(), frequency = numeric(), stringsAsFactors = FALSE)

# Loop through each feature
for (i in 1:length(dfm_rpw_gloss@Dimnames[["features"]])) {
  feature <- dfm_rpw_gloss@Dimnames[["features"]][i]
   {
    # Calculate the frequency of the feature per date
    feature_frequency <- table(dfm_rpw_gloss$date, dfm_rpw_gloss[, i])
    
    # Convert the frequency table to a data frame
    feature_frequency <- as.data.frame(feature_frequency)
    
    # Rename the columns
    colnames(feature_frequency) <- c("date", "frequency")
    
    # Add the feature name to the data frame
    feature_frequency$feature <- feature
    
    # Append the results to the result data frame
    result <- rbind(result, feature_frequency)
  }
}

# Print the result
print(result)


####
View(dict_gloss)
lookup <- dfm_lookup(dfm_rpw, dictionary = dict_gloss)
lookup.df <- convert(lookup, to = "data.frame")
# Calculating the sums of columns 2 to 65 and sorting them in descending order
sums <- colSums(lookup.df[, 2:65])
sorted_sums <- sort(sums, decreasing = TRUE)

# Creating the resulting table
result_table <- data.frame(Column = names(sorted_sums), Sum = sorted_sums)

# Printing the resulting table
print(result_table)

#now get the date variable back in there
lookup.df <- lookup.df %>% rename(id=doc_id)
str(lookup.df$id)
lookup.df$id <- as.double(lookup.df$id)
glossar_df <- lookup.df %>% left_join(df_clean, by="id")


# Convert the "date" column to Date format
glossar_df$date <- as.Date(glossar_df$date)
glossar_df_small <- subset(glossar_df, select = -c(score, title, author_flair_text, link_flair_text, locked, over_18, author, body, link, nchar, ntok, text))

##sum per date
#add month column
glossar_df_small$Month_Yr <- format(as.Date(glossar_df_small$date), "%Y-%m")
sum_per_date <- glossar_df_small %>%
  group_by(date) %>%
  summarise(across(2:65, sum))
sum_per_month <- glossar_df_small %>%
  group_by(Month_Yr) %>%
  summarise(across(2:65, sum))

library(tidyr)
library(ggplot2)
library(lubridate)

##plot
str(glossar_df_small$Month_Yr)
glossar_df_small$Month_Yr <- ym(glossar_df_small$Month_Yr)

sum_per_month <- glossar_df_small %>%
  group_by(Month_Yr) %>%
  summarise(across(2:65, sum))

# Group the dataframe by "Month_Yr" and calculate the sum for each variable
df_sum <- aggregate(. ~ Month_Yr, data = sum_per_month, FUN = sum)

# Select columns 2 to 65 from df_sum
selected_columns <- df_sum[, 2:65]

# Calculate column sums
column_sums <- colSums(selected_columns)

# Create a new dataframe with column names and column sums
new_df <- data.frame(word = names(column_sums), sum = column_sums)
new_df <- new_df[order(new_df$sum, decreasing = TRUE), ]

# Select the top 10 values of the 'word' column
top_10_words <- head(new_df$word, 10)

# Convert the selected values to a character vector
top_10_words <- as.character(top_10_words)

# Print the character vector
print(top_10_words)

df_top_10 <- subset(df_sum, select =
  c("Month_Yr", "red_pill", "alpha", "captain", "close", "ltr", 
    "set", "game", "feminism", "beta", "smv"))


# Reshape the dataframe to long format
df_long <- reshape2::melt(df_top_10, id.vars = "Month_Yr", variable.name = "Variable", value.name = "Sum")

# Create the line chart

ggplot(data = df_long, aes(x = Month_Yr, y = Sum, color = Variable)) +
  geom_line() +
  labs(x = "Year", y = "Prevalence (sum)", title = "Monthly Prevalence of Top 10 Glossary Expressions") +
  theme_light() + theme(legend.position = "none", strip.text = element_text(size = 10, face = "bold")) +
  facet_wrap(~Variable, nrow=4) +
  labs(color="Glossary") 
