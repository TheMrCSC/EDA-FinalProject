library(dplyr)
library(ggplot2)

#read data
NEI <- readRDS(".\\Data\\summarySCC_PM25.rds")
SCC <- readRDS(".\\Data\\Source_Classification_Code.rds")


#creating dataset with data to be plotted
plotData <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>% 
        summarise(sum(Emissions))


#setting col names
colnames(plotData) <- c("year", "types","total.emission")


#opening PNG file
png(".\\Plots\\plot3.png",width = 480, height = 480, units = "px")


#plotting data
qplot(year, total.emission, data = plotData, color = types , geom ="line",
      xlab = "Year", ylab = "Total Emission", main = "Baltimore Data")


#saving and closing PNG file
dev.off()
