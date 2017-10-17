# Download the zip file from course website
download.file("https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip", "hospital.zip", method="curl")
unzip("hospital.zip", files=NULL);
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

require("dplyr")
require("data.table")
# best.R
best <- function(state, outcome) {
    ## Read outcome data
    outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    ## Check that state and outcome are valid
    colNumber <- 0
    if (outcome == "heart attack")
        colNumber <- 11
    else if (outcome == "heart failure")
        colNumber <- 16
    else if (outcome == "pneumonia")
        colNumber <- 23
    else return
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    
    hospitals <- outcomes %>%
        select(State, Hospital.Name, colnames(outcomes)[colNumber]) %>%
        filter(State == state) 
    if (length(hospitals) == 0)
        return
    hospitals[, 3] <- as.numeric(hospitals[, 3])
    ordered_hospital <- arrange(hospitals, desc(hospitals[,3]))
    # return the first hospital that has the highest mortality rate
    ordered_hospital[1, 2]
}
