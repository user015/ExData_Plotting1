library(chron)
d=scan("household_power_consumption.txt",sep=';', what="character" , nlines=1) 
cols=c(rep("character",length(d)))
data=read.csv("household_power_consumption.txt",sep=";",header=TRUE,colClasses=cols)
t=data$Date!="?" & data$Time!="?" & data$Voltage !="?" & data$Global_active_power!="?" & data$Global_reactive_power!="?" & data$Global_intensity!="?" & data$Sub_metering_1 !="?" & data$Sub_metering_2!="?" & data$Sub_metering_3 !="?"
data=data[t,]
data$Date=as.Date(data$Date,"%d/%m/%Y")
dt=subset(data,Date >="2007-2-1"& Date<="2007-2-2")
rm(data)
dtstr=as.character(dt$Date)
datetimestr=paste(dtstr,dt$Time)
timestamp=strptime(datetimestr,"%Y-%m-%d %H:%M:%S")
dt$Time=chron(times=dt$Time)
dt$Global_active_power=as.numeric(dt$Global_active_power)
dt$Global_reactive_power=as.numeric(dt$Global_reactive_power)
dt$Voltage=as.numeric(dt$Voltage)
dt$Global_intensity=as.numeric(dt$Global_intensity)
dt$Sub_metering_1=as.numeric(dt$Sub_metering_1)
dt$Sub_metering_2=as.numeric(dt$Sub_metering_2)
dt$Sub_metering_3=as.numeric(dt$Sub_metering_3)

png(file="Plot2.png",width=480,height=480)
plot(timestamp,dt$Global_active_power,type="l",ylab="Global Active Power (kilowatts)", xlab= " ") #plot2
dev.off()