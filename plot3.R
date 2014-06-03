#load the plotting package

library(ggplot2)

#read in the data

#NEI <- readRDS("summarySCC_PM25.rds")
NEI[,5] <- as.factor(NEI[,5])

#split dataframe by finding rows that match 24510 AND years 1999, 2002, 2005 and 2008

x <- which(NEI[,6] == 1999 & NEI[,1] == 24510)
NEI_1999_24510 <- NEI[x,]

x <- which(NEI[,6] == 2002 & NEI[,1] == 24510)
NEI_2002_24510 <- NEI[x,]

x <- which(NEI[,6] == 2005 & NEI[,1] == 24510)
NEI_2005_24510 <- NEI[x,]

x <- which(NEI[,6] == 2008 & NEI[,1] == 24510)
NEI_2008_24510 <- NEI[x,]

#split each year data by "type" factor to create lists of dataframes by type

NEI_1999_24510_type <- split(NEI_1999_24510, NEI_1999_24510$type, drop=TRUE)
NEI_2002_24510_type <- split(NEI_2002_24510, NEI_2002_24510$type, drop=TRUE)
NEI_2005_24510_type <- split(NEI_2005_24510, NEI_2005_24510$type, drop=TRUE)
NEI_2008_24510_type <- split(NEI_2008_24510, NEI_2008_24510$type, drop=TRUE)

#sum the total PM25 ('emissions') using lapply over lists of dataframes

NEI_1999_24510_typesum <- lapply(NEI_1999_24510_type, function(x) sum(x[,"Emissions"]))
NEI_2002_24510_typesum <- lapply(NEI_2002_24510_type, function(x) sum(x[,"Emissions"]))
NEI_2005_24510_typesum <- lapply(NEI_2005_24510_type, function(x) sum(x[,"Emissions"]))
NEI_2008_24510_typesum <- lapply(NEI_2008_24510_type, function(x) sum(x[,"Emissions"]))

#concatenate data into single frame for plotting

NEI_1999_sums <- data.frame(NEI_1999_24510_typesum, Year=1999)
NEI_2002_sums <- data.frame(NEI_2002_24510_typesum, Year=2002)
NEI_2005_sums <- data.frame(NEI_2005_24510_typesum, Year=2005)
NEI_2008_sums <- data.frame(NEI_2008_24510_typesum, Year=2008)

all_years <- rbind(NEI_1999_sums, NEI_2002_sums, NEI_2005_sums, NEI_2008_sums)

#x,y plot using ggplot2 NOTE: this is not the best way to do it
# you ideally want to plot the data with type as a factor, not as y columns
# I could use melt to rearrange the data to make this easier in the future

g <- ggplot(all_years, aes(x = Year)) + 
        geom_line(aes(y=POINT, colour = "POINT"), size=3) +
        geom_line(aes(y=ON.ROAD, colour = "ON.ROAD"), size=3) +
        geom_line(aes(y=NONPOINT, colour = "NONPOINT"), size=3) +
        geom_line(aes(y=NON.ROAD, colour = "NON.ROAD"), size=3) +
        scale_colour_manual("", breaks =c("POINT","ON.ROAD","NONPOINT", "NON.ROAD"), values = c("red", "blue", "green", "black")) +
        labs(y = "PM2.5 (Tons)") +
        labs(title = "Change in PM2.5 (1999-2008) in Baltimore City: 4 Sources")

print(g)
#save the plot as PNG

dev.copy(png, file = "EDA2_Plot3.png")
dev.off()