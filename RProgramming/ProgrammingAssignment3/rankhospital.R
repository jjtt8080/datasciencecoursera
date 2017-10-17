
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

# 
rankhospital <- function(state, outcome, num = "best") {
    # refer to the best.R script for the orderering hospital
    # according to the mortality rate
    oh <- order_hospital(state, outcome)
    # assigning ranking to the hospitals 
    ohr <- cbind(oh, c(1:dim(oh)[1]))
    # transform num to ranking 
    ranking <- 0
    if (num == "best")
        ranking <- 1
    else if (num == "worst")
        ranking <- dim(oh)[1]
    else
        ranking <- as.numeric(num)
    if (ranking <= 0 || ranking >= dim(oh)[1] || is.na(ranking))
        return
    h <- filter(ohr, ohr[,4] == ranking)
    h[1, 2]
}
