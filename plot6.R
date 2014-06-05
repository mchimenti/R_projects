
#import ggplot2

library(ggplot2)

#read in the data

#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Convert "type" column to factors

#NEI[,5] <- as.factor(NEI[,5])

#split dataframe on years by 1999, 2002, 2005 and 2008 and Baltimore City "Fips" code

x <- which(NEI[,6] == 1999 & NEI[,1] == 24510)
NEI_1999_24510 <- NEI[x,]

x <- which(NEI[,6] == 2002 & NEI[,1] == 24510)
NEI_2002_24510 <- NEI[x,]

x <- which(NEI[,6] == 2005 & NEI[,1] == 24510)
NEI_2005_24510 <- NEI[x,]

x <- which(NEI[,6] == 2008 & NEI[,1] == 24510)
NEI_2008_24510 <- NEI[x,]

#Investigate SCC dataframe for sources from EI.Sector matching word "Vehicle"

SCC_vehicle <- SCC[grepl("Vehicle", as.character(SCC$EI.Sector)),]

#I note that anytime "Vehicle" appears in EI.Sector, type = Onroad
#Thus I will simply subset the above dataframe by type = Onroad for calculations

Y99_24510_vehicles <- NEI_1999_24510[NEI_1999_24510$type=="ON-ROAD",]

Y02_24510_vehicles <- NEI_2002_24510[NEI_2002_24510$type=="ON-ROAD",]

Y05_24510_vehicles <- NEI_2005_24510[NEI_2005_24510$type=="ON-ROAD",]

Y08_24510_vehicles <- NEI_2008_24510[NEI_2008_24510$type=="ON-ROAD",]

#sum contributions to emissions from all motor vehicle sources in B-more betwee 99 and 08

Y99_BCsum <- sum(Y99_24510_vehicles[,4])

Y02_BCsum <- sum(Y02_24510_vehicles[,4])

Y05_BCsum <- sum(Y05_24510_vehicles[,4])

Y08_BCsum <- sum(Y08_24510_vehicles[,4])

##
#split dataframe on years by 1999, 2002, 2005 and 2008 and Los Angeles County "Fips" code
##

x <- which(NEI[,6] == 1999 & NEI[,1] == "06037")
NEI_1999_06037 <- NEI[x,]

x <- which(NEI[,6] == 2002 & NEI[,1] == "06037")
NEI_2002_06037 <- NEI[x,]

x <- which(NEI[,6] == 2005 & NEI[,1] == "06037")
NEI_2005_06037 <- NEI[x,]

x <- which(NEI[,6] == 2008 & NEI[,1] == "06037")
NEI_2008_06037 <- NEI[x,]

#

Y99_06037_vehicles <- NEI_1999_06037[NEI_1999_06037$type=="ON-ROAD",]

Y02_06037_vehicles <- NEI_2002_06037[NEI_2002_06037$type=="ON-ROAD",]

Y05_06037_vehicles <- NEI_2005_06037[NEI_2005_06037$type=="ON-ROAD",]

Y08_06037_vehicles <- NEI_2008_06037[NEI_2008_06037$type=="ON-ROAD",]

#sum contributions to emissions from all motor vehicle sources in B-more betwee 99 and 08

Y99_LAsum <- sum(Y99_06037_vehicles[,4])

Y02_LAsum <- sum(Y02_06037_vehicles[,4])

Y05_LAsum <- sum(Y05_06037_vehicles[,4])

Y08_LAsum <- sum(Y08_06037_vehicles[,4])

#make a dataframe with summed data

test <- data.frame(c(rep("LA", 4), rep("BALTIMORE", 4)), rep(c(1999,2002,2005,2008),2), c(Y99_BCsum, Y02_BCsum, Y05_BCsum, Y08_BCsum, Y99_LAsum, Y02_LAsum, Y05_LAsum, Y08_LAsum))
colnames(test) <- c("City", "Year", "PM25")



#make the plot

g <- ggplot(test, aes(x = Year, y = log10(PM25))) + 
        geom_line(aes(color = City), size=3) +
        labs(y = "LOG PM2.5 Vehicle Sources (Tons)") +
        labs(title = "Change in Vehicle PM2.5 (1999-2008) in Baltimore City and LA")

print(g)

#make png of plot

dev.copy(png, file = "Plot6.png")
dev.off()
