library(dplyr)


#read data
NEI <- readRDS(".\\Data\\summarySCC_PM25.rds")
SCC <- readRDS(".\\Data\\Source_Classification_Code.rds")


#creating dataset with data to be plotted
plotData <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% 
        summarise(sum(Emissions))


#setting col names
colnames(plotData) <- c("year", "total.emission")


#opening PNG file
png(".\\Plots\\plot2.png",width = 480, height = 480, units = "px")


#plotting data
with(plotData, plot(year, total.emission, type = "l", xlab = "Year", 
                    ylab = "Total Emissions", lwd = 2, 
                    main = "Baltimore City Data"))


#saving and closing PNG file
dev.off()
