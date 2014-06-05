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

Y99_sum <- sum(Y99_24510_vehicles[,4])

Y02_sum <- sum(Y02_24510_vehicles[,4])

Y05_sum <- sum(Y05_24510_vehicles[,4])

Y08_sum <- sum(Y08_24510_vehicles[,4])

#plot results

y <- c(Y99_sum, Y02_sum, Y05_sum, Y08_sum)
x <- c(1999, 2002, 2005, 2008)

plot(x,y,xlab="Year", ylab="Total PM2p5 (Vehicle Sources in Tons)",main="PM2.5 by Year Vehicle Sources Baltimore City", type="b")

#make png of plot

dev.copy(png, file = "Plot5.png")
dev.off()

