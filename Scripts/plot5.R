library(dplyr)
library(ggplot2)

#read data
NEI <- readRDS(".\\Data\\summarySCC_PM25.rds")
SCC <- readRDS(".\\Data\\Source_Classification_Code.rds")


#creating dataset with data to be plotted
motorVehSources <- SCC[apply(SCC, 1, function(i){any(grepl("[Vv][Ee][Hh]"
                                                              ,i))} ),c(1)]

plotData <- NEI %>% filter(SCC %in% motorVehSources & fips == "24510") %>% 
        group_by(year) %>% summarise(sum(Emissions))


#setting col names
colnames(plotData) <- c("year", "total.emission")


#opening PNG file
png(".\\Plots\\plot5.png",width = 480, height = 480, units = "px")


#plotting data
qplot(year, total.emission, data = plotData, geom ="line",
      xlab = "Year", ylab = "Total Emission", 
      main = "Emissions from Motor Vehicles for Baltimore")


#saving and closing PNG file
dev.off()
