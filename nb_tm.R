#packages
install.packages("RedditExtractoR")
install.packages("tidytext")
library("RedditExtractoR")
library("tidytext")
library("dplyr")
library("stringr")
library("ggplot2")

#sub
nb_sub <- find_thread_urls(sort_by = "top",
                                         subreddit = "naturalbodybuilding",
                                         period = "year")
nb_sub <- na.exclude(nb_sub)

#exporting
write.csv(nb_sub,
          "../R/reddit_data.csv",
          row.names=FALSE)


################## MANIPULATION ##################

#removing characters
nb_tidy <- nb_tidy %>% filter(word != "ve")

#tokenization 
nb_tidy <- nb_sub %>% unnest_tokens(word, text)

View(nb_tidy)

#removing stop words

data(stop_words)
nb_tidy <- nb_tidy %>% anti_join(stop_words)

View(nb_tidy)

#counting 
nb_tidy %>% count(word, sort = TRUE)

############ VISUALIZATION ############

nb_tidy %>%
  count(word, sort = TRUE) %>%
  filter(n > 200) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  geom_col() +
  labs(y = NULL)





