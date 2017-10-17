# Download the zip file from course website
download.file("https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip", "hospital.zip", method="curl")
unzip("hospital.zip", files=NULL);
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

require("dplyr")
require("data.table")

checkRanking <- function(num, oh) {
    # return the hospital that has the mortality rate that's within the range
    # check the num input variable first and assign to ranking variable
    ranking <- 0
    if (num == "best")
        ranking <- 1
    else if (num == "worst")
        ranking <- dim(oh)[1]
    else
        ranking <- as.numeric(num)
    if (ranking <= 0 || ranking >= dim(oh)[1] || is.na(ranking))
        return
    ranking

}
# rankall.R
rankall <- function(outcome, num = "best") {
    ## Read outcome data
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
        select(State, Hospital.Name, cName)
    if (length(hospitals) == 0)
        return
    ## Return hospital name in that state with lowest 30-day death rate
    hospitals[, 3] <- as.numeric(hospitals[, 3])
    hospitals <- na.omit(hospitals)
    unique_states <- as.vector(sort(unique(hospitals$State)))
    colnames(hospitals)[3] <- "death.rate"    
    
    result <- data.frame()
    for (i in 1:length(unique_states))
    {
        s <- unique_states[i];
        current_frame <- hospitals %>% 
            select(Hospital.Name, State, death.rate) %>%
            filter(State == s) %>%
            arrange(death.rate, Hospital.Name) %>% # arrange according to death rate, and then hospital name
            mutate(r = seq(n())) %>% # this produce the running count(rank)  
            select(Hospital.Name, State, r)
        # check the best, worst ranking according to current grouped
        # hospital's max
        ranking <- checkRanking(num, current_frame)    
        filtered_frame <- current_frame %>% 
            filter(r == ranking) %>% # we only need the ranking matches num in a given state
            select(Hospital.Name, State)
        if (dim(filtered_frame)[1] == 0) # if we don't so many hospitals for a given rank
        {
            filtered_frame <- as.data.frame(cbind(NA, s))
            colnames(filtered_frame) <- c("Hospital.Name", "State")
        }
        result <- rbind(result, filtered_frame)
        
    }
    result
}
