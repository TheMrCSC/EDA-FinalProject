library(dplyr)
library(ggplot2)

#read data
NEI <- readRDS(".\\Data\\summarySCC_PM25.rds")
SCC <- readRDS(".\\Data\\Source_Classification_Code.rds")


#creating dataset with data to be plotted
motorVehSources <- SCC[apply(SCC, 1, function(i){any(grepl("[Vv][Ee][Hh]"
                                                           ,i))} ),c(1)]

plotData <- NEI %>% filter(SCC %in% motorVehSources & 
                                (fips == "24510" | fips=="06037")) %>% 
        group_by(year, fips) %>% summarise(sum(Emissions)) %>% 
        mutate(fips = ifelse(fips == "24510", "Baltimore City",
                             "Los Angeles County"))


#setting col names
colnames(plotData) <- c("year", "state", "total.emission")


#opening PNG file
png(".\\Plots\\plot6.png",width = 480, height = 480, units = "px")


#plotting data
qplot(year, total.emission, data = plotData, color = state, geom ="line",
      xlab = "Year", ylab = "Total Emission", facets = . ~ state,
      main = "Emissions from Motor Vehicles for Baltimore and Los Angeles")


#saving and closing PNG file
dev.off()
