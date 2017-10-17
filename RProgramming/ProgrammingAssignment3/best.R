# Download the zip file from course website
require("dplyr")
require("data.table")

download.file("https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip", "hospital.zip", method="curl")
unzip("hospital.zip", files=NULL);
#outcome[, 11] <- as.numeric(outcome[, 11])
#hist(outcome[, 11])


# Utility function used by both rankhospital.R and best.R
## Read outcome data
order_hospital <- function(state, outcome) 
{
    outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    ## Check that state and outcome are valid
    cName <- "Hospital.30.Day.Death..Mortality..Rates.from."
    
    if (outcome == "heart attack")
        cName <- paste(cName, "Heart.Attack", collapse = NULL, sep="")
    else if (outcome == "heart failure")
        cName <- paste(cName, "Heart.Failure", collapse = NULL, sep="")
    else if (outcome == "pneumonia")
        cName <- paste(cName, "Pneumonia", collapse = NULL, sep="")
    else stop("Invalid outcome")
    
    hospitals <- outcomes %>%
        select(State, Hospital.Name, cName) %>%
        filter(State == state)
    if (dim(hospitals)[1] == 0) {
        stop("Invalid state")
    }
    
    ## Return hospital name in that state with lowest 30-day death rate
    ## ordered by the mortality rate first, hospital name 2nd
    hospitals[, 3] <- as.numeric(hospitals[, 3])
    hospitals <- na.omit(hospitals)
    ordered_hospitals <- arrange(hospitals, hospitals[,3], hospitals[, 2])
    ordered_hospitals
}
# best.R
best <- function(state, outcome) {
    oh <- order_hospitals(state, outcome)
    # return the first hospital that has the highest mortality rate
    oh[1, 2]
}
