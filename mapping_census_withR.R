require(RCurl)
require (xlsx)


urlfile <-'http://www.psc.isr.umich.edu/dis/census/Features/tract2zip/MedianZIP-3.xlsx'
destfile <- "census20062010.xlsx"
dest <- "census20062010.csv"
#download.file(url, dest, mode="wb")
census <- read.csv(dest)

census <- census[c('Zip','Median')]
names(census) <- c('Zip','Median')
census$Median <- as.character(census$Median)
census$Median <- as.numeric(gsub(',','',census$Median))
print(head(census,5))

data(zipcode)
census$Zip <- clean.zipcodes(census$Zip)

census <- merge(census, zipcode, by.x='Zip', by.y='zip')

map<-get_map(location='united states', zoom=4, maptype = "terrain",
             source='google',color='color')


ggmap(map) + geom_point(
  aes(x=longitude, y=latitude, show_guide = TRUE, colour=Median), 
  data=census, alpha=.7, na.rm = T)  + 
  scale_color_gradient(low="beige", high="coral2")



