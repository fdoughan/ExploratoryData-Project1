##set date and time
 pow<-read.table("household_power_consumption.txt",header=TRUE,nrows=1,sep=";")
 pow1<- names(pow)

firstDateTime<- strptime("2006-12-16 17:24:00", "%Y-%m-%d %H:%M:%S")
beginDateTime<- strptime("2007-02-01 00:01:00", "%Y-%m-%d %H:%M:%S")

##calculate number of rows needed
boof<- beginDateTime - firstDateTime
startrow<- as.numeric(boof)*24*60 #starting row to read
numrows<- 2880 #total number of rows needed
mytab<- read.table("household_power_consumption.txt",sep=";",
        skip = startrow,nrows=2880) #Reading part of file

names(mytab)<- pow1#Assigning column names to data

 mytab$Date<- as.Date(mytab$Date, "%d/%m/%Y") #Changing column to Date&time resp:
 mytab$DateTime<- as.POSIXct(paste(mytab$Date,mytab$Time),format="%Y-%m-%d %H:%M:%S")


dev.cur()
plot(mytab$DateTime,mytab$Sub_metering_1,type="n",xlab="",
     ylab="Energy sub metering")
lines(mytab$DateTime,mytab$Sub_metering_1)
lines(mytab$DateTime,mytab$Sub_metering_2,col="red")
lines(mytab$DateTime,mytab$Sub_metering_3,col="blue")
 legend("topright",pch=c("-","-","-"),col=c("black","red","blue"),
   legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png,file="plot3.png")
dev.off()
