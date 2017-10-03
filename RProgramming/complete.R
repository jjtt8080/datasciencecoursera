complete <- function(directory, id="1:332")
{
    n <- c()
    for (i in 1:length(id)) {
        str_i = as.character(id[i])
        if (id[i] < 10) {
            str_i <- paste("00", str_i, sep="", collapse=NULL)
        }else if (id[i] < 100) {
            str_i <- paste("0",  str_i, sep="", COLLAPSE=NULL)
        }
        
        filename <- paste(directory, str_i, sep="/")
        f <- read.csv(paste(filename, "csv", sep="." ), header = TRUE, sep=",")
        n <- c(n, sum(complete.cases(f)))
    }
    d <-cbind(id, n)
    colnames(d) <- c("id", "nobs")
    rownames(d) <- c(1:length(id))
    d
}