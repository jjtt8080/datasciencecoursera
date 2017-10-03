pollutantmean <- function(directory, pollutant, id){
    s <- 0
    l <- 0
    for (i in 1:length(id)) {
        str_i = as.character(id[i])
        if (id[i] < 10) {
            str_i <- paste("00", str_i, sep="", collapse=NULL)
        }else if (id[i] < 100) {
            str_i <- paste("0",  str_i, sep="", COLLAPSE=NULL)
        }
        
        filename <- paste(directory, str_i, sep="/")
        f <- read.csv(paste(filename, "csv", sep="." ), header = TRUE, sep=",")
        f_r <- na.exclude(f[pollutant])
        s <- s + sum(f_r)
        l <- l + length(f_r[,1])
    }
    all_s <- s / l
    all_s 
}