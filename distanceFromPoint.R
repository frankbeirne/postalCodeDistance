library(gmapsdistance)

#reading in csv with postal codes, description, weekend flad and lat/lon
raw<-read.csv("data/raw.csv")

#API key named R distance
set.api.key("############")

distances<-data.frame("pc"=character(109), "dow"=integer(109), "time (s)"=integer(109), "distance (m)"=integer(109))
distances$PC<-as.character(distances$PC)

for (i in 1:length(raw$WeekEnd[raw$WeekEnd<3])) {
  
  result<-gmapsdistance(
                origin= paste0(raw$Lat[i],"+", raw$Lon[i]), 
                destination= paste0(raw$Lat[raw$Description == "Point1"], "+", raw$Lon[raw$Description == "Point1"]), 
                mode = "driving")
  
  distances$PC[i]<-as.character(raw$PC[i])
  distances$DOW[i]<-raw$WeekEnd[i]
  distances$time[i]<-result$Time
  distances$distance[i]<-result$Distance
  
}

write.csv(distances, "distanceFromPoint.csv")

version
