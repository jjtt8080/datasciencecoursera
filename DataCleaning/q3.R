## Data Cleaning Quiz 3
## test 1
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
##Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. 
#which(agricultureLogical) 
#What are the first 3 values that result?

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "comm.csv", method="curl")
c <- mutate(comm, agricultureLogical=(ACR==3 & AGS ==6))
which(c$agricultureLogical == TRUE)

## test2

require("jpeg")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "jeff.jpg", method="curl")
j <- readJPEG("jeff.jpg", native=TRUE)
quantile(j, probs=0.3)
quantile(j, probs=0.8)


# test 3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "produce.csv", method="curl")
p <- read.csv("produce.csv", skip=6, header=FALSE, nrows=218)
colnames(p) <- c("CountryCode", "Ranking", "Space1", "CountryName", "GDP", "X2", "X3", "X4", "X5", "X6")
p1 <- select(p, CountryCode, Ranking, CountryName, GDP)
# remove the buttom data
p11 <- p1[1:189, ]

colnames(p) <- c("CountryCode", "Ranking", "Blank", "CountryName", "GDP")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "country.csv", method="curl")
p2 <- read.csv("country.csv")
m<-inner_join(p11, p2, by="CountryCode")
# find the average ranking for the "High income: OECD and High income: nonOECD group"
m %>%
select(CountryCode, GDP, Ranking, Income.Group) %>%
filter(Income.Group == "High income: OECD" | Income.Group == "High income: nonOECD") %>%
group_by(Income.Group) %>%
summarize(mean(Ranking))

# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries
#are Lower middle income but among the 38 nations with highest GDP?
q <- quantile(m$Ranking, probs=seq(0, 1, 0.25))
m %>%
select(CountryCode, Ranking, Income.Group) %>%
filter(Ranking <= 38) %>%
filter(Income.Group == "Lower middle income")

