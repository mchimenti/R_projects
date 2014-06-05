#read in the data

#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#NEI[,5] <- as.factor(NEI[,5])

# Search the SCC for anything with the word "coal" in the EI Sector column

SCC_coal <- SCC[grepl("Coal", as.character(SCC$EI.Sector)),]

SCC_coal[,1] <- as.character(SCC_coal[,1])

#Create a vector containing the SCC codes corresponding to matched "coal" EI Sectors

coal_codes <- SCC_coal[,1]

#subset dataframe by year

x <- which(NEI[,6] == 1999)
NEI_1999 <- NEI[x,]

x <- which(NEI[,6] == 2002)
NEI_2002 <- NEI[x,]

x <- which(NEI[,6] == 2005)
NEI_2005 <- NEI[x,]

x <- which(NEI[,6] == 2008)
NEI_2008 <- NEI[x,]

#subset year frames by coal codes

cc_1999 <- NEI_1999[,2] %in% coal_codes
NEI_1999_coal <- NEI_1999[cc_1999,]

cc_2002 <- NEI_2002[,2] %in% coal_codes
NEI_2002_coal <- NEI_2002[cc_2002,]

cc_2005 <- NEI_2005[,2] %in% coal_codes
NEI_2005_coal <- NEI_2005[cc_2005,]

cc_2008 <- NEI_2008[,2] %in% coal_codes
NEI_2008_coal <- NEI_2008[cc_2008,]

#sum total coal PM2.5 for matching SCC codes for each year

sum99 <- sum(NEI_1999_coal[,4])
sum02 <- sum(NEI_2002_coal[,4])
sum05 <- sum(NEI_2005_coal[,4])
sum08 <- sum(NEI_2008_coal[,4])

#create plot of total PM2.5 from coal by year

y <- c(sum99,sum02,sum05,sum08)
x <- c(1999,2002,2005,2008)
plot(x,y,xlab="Year", ylab="PM2p5 (Coal Related Sources in Tons)",main="PM2.5 by Year All US Coal", type="b")

#save the plot as PNG

dev.copy(png, file = "Plot4.png")
dev.off()


