url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"dataset.zip")
unzip("./dataset.zip")
f<-list.files()
dataset<-read.table("./household_power_consumption.txt",sep=";",header=TRUE)
d<-dataset
d$Date<-as.Date(d$Date,"%d/%m/%Y")
d<-d[(d$Date>='2007-02-01' & d$Date<='2007-02-02'), ]
library(dplyr)
d_set<-tbl_df(d)
d_set<-mutate(d_set,Date_Time = paste(Date,Time,sep=" "))
d_set$Date_Time<-strptime(d_set$Date_Time,"%Y-%m-%d %H:%M:%S")
#d_set<-mutate(d_set,GLP = as.numeric(Global_active_power)/1000)
d_set$Global_active_power<-as.numeric(paste(d_set$Global_active_power))
d_set$Global_reactive_power<-as.numeric(paste(d_set$Global_reactive_power))
d_set$Voltage<-as.numeric(paste(d_set$Voltage))
d_set$Sub_metering_1<-as.numeric(paste(d_set$Sub_metering_1))
d_set$Sub_metering_2<-as.numeric(paste(d_set$Sub_metering_2))
d_set$Sub_metering_3<-as.numeric(paste(d_set$Sub_metering_3))

head(d_set)

#Plot 2
png(filename="plot2.png")
with(d_set,plot(d_set$Date_Time,d_set$Global_active_power,type="n",xlab="",ylab=""))
lines(d_set$Date_Time,d_set$Global_active_power)
title(xlab=NULL,ylab="Global Active Power (killowatts)")
#dev.copy(png,file="plot2.png")
dev.off()