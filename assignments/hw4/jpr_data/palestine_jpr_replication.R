####
#Author: Richard J. McAlexander, PhD
#Purpose: Replication file for "How do International Borders affect Conflict Processes? Evidence from the End of Mandate Palestine"
#Date: March 7th, 2022
#Email: richardmcalexander@gmail.com
#Website: www.rmcalexander.com
####

#LOAD PACKAGES
library(stargazer)
library(tidyverse)
library(rgdal)
library(ggplot2)
library(rdrobust)
library(lubridate)


# READ IN DATA ------------------------------
palestine_jpr_rep_df <- readRDS("palestine_jpr_replication_data/palestine_rep_data.rds")


# MAKE FIGURE 1, MAPS --------
#import shapefiles
outside_border <- readOGR("palestine_jpr_replication_data/shapefiles/outside_border.shp")
un_land_1 <- readOGR("palestine_jpr_replication_data/shapefiles/un_land_poly1.shp")
un_land_2 <- readOGR("palestine_jpr_replication_data/shapefiles/un_land_poly2.shp")
un_land_3 <- readOGR("palestine_jpr_replication_data/shapefiles/un_land_poly3.shp")

exodus  <- readOGR("palestine_jpr_replication_data/shapefiles/exodus.shp")
exodus <- as.data.frame(exodus)[,4:5]

no_exodus  <- readOGR("palestine_jpr_replication_data/shapefiles/no_exodus.shp")
no_exodus <- as.data.frame(no_exodus)[,4:5]

fbi_shapefile_no <- readOGR("palestine_jpr_replication_data/shapefiles/fbi_shapefile_no.shp")
fbi_shapefile_no <- as.data.frame(fbi_shapefile_no)[,-1]

fbi_shapefile_yes <- readOGR("palestine_jpr_replication_data/shapefiles/fbi_shapefile_yes.shp")
fbi_shapefile_yes <- as.data.frame(fbi_shapefile_yes)[,-1]

#MAKE MAP OF ALL DEPOPULATED/NOT DEPOPULATED VILLAGES
ggplot() + 
  geom_polygon(data = un_land_1, aes(x = long, y = lat, group = group), colour = "#def247", fill = "#307efc",alpha=0.25)+
  geom_polygon(data = un_land_2, aes(x = long, y = lat, group = group), colour = "#def247", fill = "#307efc",alpha=0.25)+
  geom_polygon(data = un_land_3, aes(x = long, y = lat, group = group), colour = "#def247", fill = "#307efc",alpha=0.25)+
  theme_void()+
  geom_polygon(data = outside_border, aes(x = long, y = lat, group = group), colour = "black", fill = NA)+
  geom_point(data=exodus,aes(x = coords.x1, y = coords.x2),colour="#ff0001",size=.5)+
  geom_point(data=no_exodus,aes(x = coords.x1, y = coords.x2),colour="#0400ff",size=.5)

#MAKE MAP OF ALL DEPOPULATED VILLAGES BEFORE MAY 15
ggplot() + 
  geom_polygon(data = un_land_1, aes(x = long, y = lat, group = group), colour = "#def247", fill = "#307efc",alpha=0.25)+
  geom_polygon(data = un_land_2, aes(x = long, y = lat, group = group), colour = "#def247", fill = "#307efc",alpha=0.25)+
  geom_polygon(data = un_land_3, aes(x = long, y = lat, group = group), colour = "#def247", fill = "#307efc",alpha=0.25)+
  theme_void()+
  geom_polygon(data = outside_border, aes(x = long, y = lat, group = group), colour = "black", fill = NA)+
  geom_point(data=fbi_shapefile_yes,aes(x = coords.x1, y = coords.x2),colour="#ff0001",size=.5)+
  geom_point(data=fbi_shapefile_no,aes(x = coords.x1, y = coords.x2),colour="#0400ff",size=.5)


# MAKE SUMMARY STATS ------------------------
select(palestine_jpr_rep_df,
       fell_before_ind,
       massacre,
       any_exodus_violent,
       un_arab_land_47,
       arab_land,
       arab_pop_45,
       jew_land,
       jew_pop_45,
       jew_land_share,
       distance) %>%
  stargazer(float = FALSE,
          title="Summary Statistics of the Village-level Data",
          median = TRUE,
          covariate.labels = c("Depopulated Before 5/15",
                               "Any Massacre",
                               "Any Violent Depopulation",
                               "In Arab Land",
                               "Amount of Land Owned by Arabs",
                               "Arab Population (log)",
                               "Amount of Land Owned by Jews",
                               "Jewish Population (log)",
                               "Share of Land Owned by Jews",
                               "Distance to Partition Line (KM)"))


# MAKE DIFFERENCE IN MEANS BARPLOTS ---------

#DIFFERENCE IN MEANS, ARAB VILLAGES 
arab_pop_distance_5_un_fbi <- filter(palestine_jpr_rep_df,arab_pop_45 >0, distance_forcing >0 & distance < 5) %>%
  dplyr::select(fell_before_ind) %>%
  na.omit() 

arab_pop_distance_5_noun_fbi <- filter(palestine_jpr_rep_df,arab_pop_45 >0, distance_forcing <0 & distance < 5) %>%
  dplyr::select(fell_before_ind) %>%
  na.omit() 

arab_land_distance_5_df <- rbind(cbind(arab_pop_distance_5_un_fbi$fell_before_ind,"Arab State \n (103 Villages Total)"),
                                 cbind(arab_pop_distance_5_noun_fbi$fell_before_ind,"Jewish State \n (75 Villages Total)")) %>% 
  as_tibble() %>%
  rename("fell_before_ind" = V1, "location" = V2)

arab_land_distance_5_df$location <- as.factor(arab_land_distance_5_df$location)
arab_land_distance_5_df$fell_before_ind <- as.integer(arab_land_distance_5_df$fell_before_ind)

arab_land_distance_5_df <- arab_land_distance_5_df %>%
  group_by(location) %>%
  summarise(fell_before_ind = mean(fell_before_ind))

arab_land_distance_5_df$number_of_villages <- c(103,75)
arab_land_distance_5_df$fell_before_ind_round <- round(arab_land_distance_5_df$fell_before_ind,2)

#PLOT
ggplot(arab_land_distance_5_df,aes(x=location,y=fell_before_ind,fill=location)) + 
  geom_bar(stat="identity",color="black") +
  xlab("") +
  ylab("Share of Villages with Depopulation Before 5/15")+
  #ggtitle("Difference in Level of Violence for Arab Villages \n within 3 km of UN Border")+
  geom_text(aes(label=fell_before_ind_round), vjust=1.6, color="white", size=5)+
  theme_minimal()+
  theme(legend.position="none")+
  scale_fill_manual(values=c("red", "blue"))

#DIFFERENCE IN MEANS, JEWISH VILLAGES 
jew_pop_distance_5_un_fbi <- filter(palestine_jpr_rep_df,jew_pop_45 >0, distance_forcing >0 & distance < 5) %>%
  dplyr::select(fell_before_ind) %>%
  na.omit() 

jew_pop_distance_5_noun_fbi <- filter(palestine_jpr_rep_df,jew_pop_45 >0, distance_forcing <0 & distance < 5) %>%
  dplyr::select(fell_before_ind) %>%
  na.omit() 

jew_land_distance_5_df <- rbind(cbind(jew_pop_distance_5_un_fbi$fell_before_ind,"Arab State \n (8 Villages Total)"),
                                cbind(jew_pop_distance_5_noun_fbi$fell_before_ind,"Jewish State \n (8 Villages Total)")) %>% 
  as_tibble() %>%
  rename("fell_before_ind" = V1, "location" = V2)

jew_land_distance_5_df$location <- as.factor(jew_land_distance_5_df$location)
jew_land_distance_5_df$fell_before_ind <- as.integer(jew_land_distance_5_df$fell_before_ind)

jew_land_distance_5_df <- jew_land_distance_5_df %>%
  group_by(location) %>%
  summarise(fell_before_ind = mean(fell_before_ind))

jew_land_distance_5_df$number_of_villages <- c(8,8)
jew_land_distance_5_df$fell_before_ind_round <- round(jew_land_distance_5_df$fell_before_ind,2)

#PLOT
ggplot(jew_land_distance_5_df,aes(x=location,y=fell_before_ind,fill=location)) + 
  geom_bar(stat="identity",color="black") +
  xlab("") +
  ylab("Share of Villages with Depopulation Before 5/15")+
  #ggtitle("Difference in Level of Violence for Jewish Villages \n within 5 km of UN Border")+
  geom_text(aes(label=fell_before_ind_round), vjust=1.6, color="white", size=5)+
  theme_minimal()+
  theme(legend.position="none")+
  scale_fill_manual(values=c("red", "blue"))

# RDD ---------------------------------------

#FIGURE 3, RDD PLOT OF FALLING BEFORE INDEPENDENCE
rdd_df_fig3 <- select(palestine_jpr_rep_df,fell_before_ind,distance_forcing,jew_land_share,jewish_pop_share) %>%
  na.omit()
rdplot(y = rdd_df_fig3$fell_before_ind, 
       x = rdd_df_fig3$distance_forcing,
       #h=25,
       title = "Effect of Distance to UN Border on Occupation Before Independence",
       x.label = "Distance",
       y.label = "Probablity of Occupation",
       covs = cbind(rdd_df_fig3$jew_land_share,rdd_df_fig3$jewish_pop_share),
       #h=25,
       x.lim=c(-25,25),
       y.lim=c(-.05,1)
)

#figure 4 after independe
#need to do this to rmeove villages ocupied before may 15
rdd_df_fig4 <- dplyr::select(palestine_jpr_rep_df,distance_forcing,fell_after_ind,`Occupation Date`,jew_land_share,jewish_pop_share)

rdd_df_fig4 <- rdd_df_fig4[rdd_df_fig4$`Occupation Date`>as_date("1948-5-14")|is.na(rdd_df_fig4$`Occupation Date`<=as_date("1948-5-14")),]


rdplot(y = rdd_df_fig4$fell_after_ind, 
       x = rdd_df_fig4$distance_forcing,
       covs = cbind(rdd_df_fig4$jew_land_share,rdd_df_fig4$jewish_pop_share),
       #h=25,
       title = "Effect of Distance to UN Border on Occupation After Independence",
       x.label = "Distance",
       y.label = "Probablity of Occupation",
       x.lim=c(-25,25),
       y.lim=c(-.05,1)
)

