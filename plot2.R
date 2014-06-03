#read in the data

#NEI <- readRDS("summarySCC_PM25.rds")

#split dataframe on years by 1999, 2002, 2005 and 2008

x <- which(NEI[,6] == 1999 & NEI[,1] == 24510)
NEI_1999_24510 <- NEI[x,]

x <- which(NEI[,6] == 2002 & NEI[,1] == 24510)
NEI_2002_24510 <- NEI[x,]

x <- which(NEI[,6] == 2005 & NEI[,1] == 24510)
NEI_2005_24510 <- NEI[x,]

x <- which(NEI[,6] == 2008 & NEI[,1] == 24510)
NEI_2008_24510 <- NEI[x,]

#sum the total PM25 ('emissions')

sum99 <- sum(NEI_1999_24510[,4])
sum02 <- sum(NEI_2002_24510[,4])
sum05 <- sum(NEI_2005_24510[,4])
sum08 <- sum(NEI_2008_24510[,4])

#histogram plot using base package 

y <- c(sum99,sum02,sum05,sum08)
x <- c(1999,2002,2005,2008)
plot(x,y,xlab="Year", ylab="PM2.5(Tons)",main="Total PM25 by Year: Baltimore", type="b")


#save the plot as PNG

dev.copy(png, file = "EDA2_Plot2.png")
dev.off()