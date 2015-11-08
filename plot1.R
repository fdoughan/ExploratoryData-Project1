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
hist(mytab$Global_active_power, xlab="Global Active Power(kilowatts)",col="red",main="Global Active Power")
dev.copy(png,file="plot1.png")
dev.off()
