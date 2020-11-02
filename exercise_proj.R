# File:    exercise_proj.r
# Author:  Joe Yuke
# Purpose: Exercise data project#

# ------------------------- #
#                           #
#       Preliminaries       #
#                           #
# ------------------------- #

#                           # This is a comment #

# Packages:
#                           # Enter the following command into the console or     #
                            # uncomment it and run it, only needs to be run once: #
#install.packages(c(tidyverse,ggplot2))

library(tidyverse)          # This set of packages (set of commands)    #
                            # lets you manipulate data and create plots #

# Directories:
wd <- "C:/Users/Joe Yuke/OneDrive - BAY AREA TECHNOLOGY MANAGEMENT INC/Documents/EFP/Data_science_blog"
#                           # This ^ is the filepath of the folder we created     #
#                           # This is an example of assignment notation: '<-'     #
#                           # We've just assigned a 'string' to the variable: wd  #

setwd(wd)                   # setwd() tells R which folder you're working out of  #


# ---------------- #
#                  #
#       Main       #
#                  #
# ---------------- #

# Load in data from csv, create data frame:
#                           # First, let's get help with the 'read.csv' function  #
#?read.csv                  # Enter into the console or uncomment it and run it   #

workout_data <- read.csv("Workouts_data.csv")
#                           # This loads our data as a data frame. You can look        #
                            # at it by clicking on workout_data in the Environment --> #


# Analyze data:
length(workout_data$Date)   # This line tells us how many dates we have in our data    #
#                           # The '$' operator extracts a specific variable            #
typeof(workout_data[1,3])   # This returns the type of the object in the 1st row and   #
                            # 3rd column of the data frame.                            #
typeof(workout_data[,1])    # This line tells us that each date is stored as an        #
                            # integer. However, we want them to be stored as dates.    #


# Format dates:
workout_data$Date <- paste("2019", workout_data$Date, sep="-")
workout_data$Date <- as.Date(workout_data$Date, format="%Y-%d-%b")

# Optional: the following does the same as the previous 2 lines: #
#workout_data$Date <- paste("2019-", workout_data$Date, sep="") %>%
#  as.Date("%Y-%d-%b")
# This line makes use of a 'piping' operator to consolidate two lines into one.        #
# Note that in as.Date(), you don't have to specify which objects you're converting.   #


# Edit a single observation:
workout_data[18,4] <- 2.0   # Assigns a new value to the 18th row, 4th column          #


# Change variable names:
colnames(workout_data)[3:4] <- c("Strength Minutes","Miles Ran")
#                           # This line transforms the 3rd and 4th column names        #
#                           # colnames() identifies the names of the variables         #
#                           # 'c()' creates a vector with objects separated by ','     #


# Add a row of data:
new_row      <- list("2019-01-30", "Wednesday", as.integer(20), as.numeric(1.0))
workout_data <- rbind(workout_data,new_row)
#                           # First, format the new row as a list, which is basically  #
                            # a vector that can include  objects of different types    #
#                           # rbind() then adds new_row to the bottom of workout_data  #


# ----------------- #
#                   #
#       Plots       #
#                   #
# ----------------- #

# Create bar graphs:
# For now, we'll skip assigning names to our plots and just view the output of ggplot() #

# Strength:
ggplot() +
  geom_col(data=workout_data, aes(x=Date, y=`Strength Minutes`), fill="dodgerblue")

# Cardio:
ggplot() +
  geom_col(data=workout_data, aes(x=Date, y=`Miles Ran`), fill="salmon")
#                           # geom_col() tells R to make a bar chart                    #
#                           # aes() lets us specify which variables we want to give     #
                            # visual properties in our plot                             #

# Change the bar color to represent day of the week by including 'fill' in aes():
ggplot() +
  geom_col(data=workout_data, aes(x=Date, y=`Strength Minutes`, fill=Weekday))


# Save output:
my_plot <- ggplot() +
  geom_col(data=workout_data, aes(x=Date, y=`Strength Minutes`, fill=Weekday))
#                           # first we give our plot a name                             #

ggsave(paste(wd,"strength_plot.png", sep="/"), my_plot, height=4, width=6)
#                           # ggsave() requires the full path of the .png file we want  #
                            # to create, so we use the paste() function again           #