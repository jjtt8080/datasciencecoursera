corr <- function(directory, threshold=0)
{
    n <- c()
    sul <- c()
    nit <- c()
    files = list.files(directory);
    corr_r <- c()
    for (i in 1:length(files)) {
        filename <- paste(directory, "/", files[i], sep="");
        f <- read.csv(filename, header = TRUE, sep=",")
        f_c <- complete.cases(f);
        if (sum(f_c) <= threshold) {
           # print(c("filename skipped:", filename))
            next;
        }
        f_r <- na.exclude(f);
        sul <- f_r$sulfate
        nit <- f_r$nitrate
        corr_v <- cor(sul, nit)
        corr_r <- c(corr_r, corr_v)
    }
    
    corr_r
}