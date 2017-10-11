#quiz2 4. question, read the page and get the character count of 10th, 20th, 30th, 100th line
require(xml2)
require(httr)
require(httuv)
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
#req <- GET(url)
#k<-htmlParse(req) 
k <- readlines(url)
c(nchar(capture.output(k)[10]), nchar(capture.output(k)[20]), nchar(capture.output(k)[30]), nchar(capture.output(k)[100]))

# quiz2 5. question
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(url, "q2.txt", method="curl")
k<-read.fwf("q2.txt", skip=4, widths=c(-1, 9, -5, 4, 0, 4, -5, 4, 0, 4, -5,4, 0, 4, 5, 4, 0, 4)) 
sum(k$V5)
