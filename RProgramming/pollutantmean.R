pollutantmean <- function(directory, pollutant, id=1:332){
    s <- 0
    l <- 0
    for (i in 1:length(id)) {
        str_i = as.character(id[i])
        if (id[i] < 10) {
            str_i <- paste("00", str_i, sep="", collapse=NULL)
        }else if (id[i] < 100) {
            str_i <- paste("0",  str_i, sep="", COLLAPSE=NULL)
        }
        else {
            str_i <- as.character(str_i);
        }
        filename <- paste(directory, str_i, sep="/")
        filename <- paste(filename, "csv", sep="." )
        f <- read.csv(filename, header = TRUE, sep=",")
        if (sum(complete.cases(f[pollutant])) == 0)
            next;
        f_r <- na.exclude(f[pollutant])
        s <- s + sum(f_r, na.rm=TRUE)
        l <- l + length(f_r[,1])
    }
    all_s <- s / l
    all_s 
}