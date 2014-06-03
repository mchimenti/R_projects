#read in the data

NEI <- readRDS("summarySCC_PM25.rds")

#split dataframe on years by 1999, 2002, 2005 and 2008

x <- which(NEI[,6] == 1999)
NEI_1999 <- NEI[x,]

x <- which(NEI[,6] == 2002)
NEI_2002 <- NEI[x,]

x <- which(NEI[,6] == 2005)
NEI_2005 <- NEI[x,]

x <- which(NEI[,6] == 2008)
NEI_2008 <- NEI[x,]

#sum the total PM25 ('emissions')

sum99 <- sum(NEI_1999[,4])
sum02 <- sum(NEI_2002[,4])
sum05 <- sum(NEI_2005[,4])
sum08 <- sum(NEI_2008[,4])

#histogram plot using base package 

y <- c(sum99,sum02,sum05,sum08)
x <- c(1999,2002,2005,2008)
plot(x,y,xlab="year", ylab="PM2p5",main="Plot1", type="b")


#save the plot as PNG

dev.copy(png, file = "EDA2_Plot1.png")
dev.off()