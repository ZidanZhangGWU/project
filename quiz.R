quiz1=read.csv("hw1_data.csv")
names(quiz1)
quiz1[1:2,]
nrow(quiz1)
quiz1[152:153,]
quiz1[47,]

#16
subset=quiz1[,1]
missing=is.na(subset)
subset[missing]

#17
complete=subset[!missing]
mean(complete)

#18
subset <- quiz1[ with(quiz1,Ozone>31 & Temp>90), ]
mean(subset$Solar.R[!is.na(subset$Solar.R)])

#19
month <- quiz1[quiz1$Month==6, ]
mean(month$Temp)

#20
month <- quiz1[quiz1$Month==5, ]
max(month$Ozone[!is.na(month$Ozone)])










