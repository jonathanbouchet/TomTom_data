# load library
library(ggmap)
library(ggplot2)
library(grid)
library(gridExtra)

#open CSV file with summary of all runs
df<-read.csv('tempo3.csv')
myheader<-c('date','start','end','duration','latitude','longitude','distance')
colnames(df)<-myheader
model = lm(df$duration ~ df$distance)
fit<-predict(lm(duration ~ distance, data = df))
p1 <- ggplot(df, aes(x = distance, y = duration))
p1 <- p1 + geom_point(aes(color = start, size=2)) + geom_line(aes(y = fit)) + ggtitle("time vs distance") + xlab("Distance (miles)") + ylab("duration (min)")

# open csv file with geolocation for last run
df2<-read.csv('2016-07-24-09-45-41.csv',sep='\t')
myLocation <- c(-81.5,41.1,-81.4,41.16)
myMap <- get_map(location=myLocation,source="google", maptype="roadmap")
p2<- ggmap(myMap) + geom_point(aes(x = correctLong, y = correctLat), data = df2,alpha = .5, color="darkred", size = 0.1) + ggtitle("2016-07-24") + xlab("longitude") + ylab("latitude")

# quick grid
png(filename="summary.png",width = 1000, height = 800)
grid.arrange(p1, p2,ncol=1)
dev.off()