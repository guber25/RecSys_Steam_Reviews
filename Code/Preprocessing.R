#Network science project, UniMi

#Academic year 2023-2024

#Author: Guglielmo Berzano

#Game Reccomendation System


#library import

library(tidyverse)
library(magrittr)
library(grid)
library(ggpmisc)
library(gridExtra)


#importing the reviews dataset

full_rev_ds=read.csv(".../Network Science/Project/recommendations.csv")


#trimming the dataset and changing datatypes

trimmed_reviews<-full_rev_ds %>% filter(date >= "2022-06") %>% select(-c("helpful", "funny", "review_id"))

trimmed_reviews$date %<>% as.Date()
trimmed_reviews$is_recommended %<>% as.factor()
trimmed_reviews<-trimmed_reviews %>% rename("date_review"="date")


#import the games dataset and changing the datatypes -> this dataset is useful because we get the games' title

games=read.csv(".../Network Science/Project/games.csv")
games<- games %>% select(-c("win", "mac", "linux", "positive_ratio", "price_original", "discount", "price_final", "steam_deck"))
games$date_release %<>% as.Date()
games$rating %<>% as.factor()
games<-games %>% rename("total_nr_reviews"="user_reviews")


#joining the two datasets into final_ds

final_ds<-left_join(trimmed_reviews, games, "app_id")
final_ds<-final_ds %>% select(-c(price_final, date_release, date_review))


#eliminate useless columns and selecting just popular games

final_ds<-rename(final_ds, "total_nr_reviews"="user_reviews")
final_ds$rating=NULL
final_ds$total_nr_reviews=NULL
final_ds<-final_ds %>% filter(game_popularity=="high")


#checking the median and the mean levels of hours played and putting the results into a dataframe

final_ds %>% filter(is_recommended=="true" &hours<200) %>% .$hours %>% mean() %>% round(2) %>%  cat("Mean for recommended games:",.,"\n\n")
final_ds %>% filter(is_recommended=="false" &hours<200) %>% .$hours %>% mean() %>% round(2) %>%cat("Mean for non recommended games:",.,"\n\n\n")

final_ds %>% filter(is_recommended=="true" &hours<200) %>% .$hours %>% median() %>% round(2) %>%cat("Median for recommended games:",.,"\n\n")
final_ds %>% filter(is_recommended=="false" &hours<200) %>% .$hours %>% median() %>% round(2) %>%cat("Median for non recommended games:",.,"\n\n")

means<-data.frame("Means"=c(35.08,24.22),
                  "Median"=c(18.4,7.4),
                  "is_recommended"=c("true","false"),
                  "Text_mean"=c("Mean: 35.08", "Mean: 24.22"),
                  "Text_median"=c("Median: 18.4", "Median: 7.4"))


#do some plotting

labels <- c(true = "Recommended", false = "Not recommended")
final_ds$is_recommended <- factor(final_ds$is_recommended, levels=c("true","false"))
options(scipen = 999)
final_ds %>% filter(hours<200)%>% ggplot()+
  geom_histogram(aes(hours), fill="purple",color="black", bins=30)+
  
  geom_vline(aes(xintercept=Means),means, color="red", linewidth=1.2)+
  geom_text(
    data    = means,
    mapping = aes(x=means$Mean+38, y=550000, label = Text_mean), colour="red", size=4.5)+
  
  geom_vline(aes(xintercept=Median),means, color="darkgreen", linewidth=1.2)+
  geom_text(
    data    = means,
    mapping = aes(x=means$Median+40, y=450000, label = Text_median), colour="darkgreen", size=4.5)+
  
  facet_wrap(vars(is_recommended), labeller=as_labeller(labels), scales = "free")+
  scale_y_continuous(limits = c(0, 600000), breaks = seq(0,600000,100000))+
  scale_x_continuous(limits = c(0, 200), breaks = seq(0,200,20))+
  xlab("\nHours played")+
  ylab("Number of gamers\n")+
  labs(title = "How many hours gamers played before giving a review?",
       subtitle = "\nHours capped at 200\n")+
  
  theme_minimal()+
  theme(plot.title = element_text(color = "purple", size = 16, face = "bold"),
        strip.text.x = element_text(size=12, face="bold"),
        axis.title.y= element_text(size=11))


#data export

final_ds1=final_ds
final_ds1$user_rating<-ifelse((final_ds1$hours<71 & final_ds1$is_recommended=="false"),
                              "N_R", "R") 
final_ds1$is_recommended=NULL
final_ds1$hours=NULL
final_ds1$game_popularity<-NULL
final_ds1$total_nr_reviews<-NULL
final_ds1$general_rating<-NULL
final_ds1<-final_ds1 %>% filter(user_rating=="R")
final_ds1$user_rating=NULL
final_ds1 %>% write.csv(file=".../Network Science/Project/final_ds.csv", row.names = FALSE)

final_ds1

#let's hop on Python!