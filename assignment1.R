##########programing assignment 1
##pollutantmean
pollutantmean <- function(directory, pollutant, id=1:332) {
    listcsv<-list.files(directory,full.names=TRUE)
    data_add<-data.frame() #creates a blank data frame 
    for(i in id) {
        data_add<-rbind(data_add,read.csv(listcsv[i]))
    }
        #combined csv files for specific ids' 
    #print(data_add$pollutant)?????why can't return 
    mean(data_add[,pollutant],na.rm=TRUE)
    }
    
#call 
pollutantmean("specdata","nitrate",70:72)


##complete
complete <- function(directory,id=1:332) {
    listcsv<-list.files(directory,full.names=TRUE)
    data<-c()
    for (i in id) {
        file<-read.csv(listcsv[i])
        completecase<-nrow(file[complete.cases(file), ])
        data<-rbind(data,c(i,completecase))
        colnames(data)<-c("id","nobs")
    }
    print(data)
}

#call 
complete("specdata", c(2,4,8,10,12))

##
corr<-function(directory, threshold=0) {
    correlation<-c()
    for(i in 1:332) {
        file<-read.csv(listcsv[i])
        completecase<-nrow(file[complete.cases(file), ])
        if (completecase>threshold) {
            co=cor(file[,2],file[,3],use="complete")
        } else {
            co<-c()
        }
        correlation<-c(correlation,co)
    }
    print(correlation)
}

#run
cr<-corr("specdata",150)
head(cr)
length(cr)
summary(cr)


##########programming assignment 2 Lexical Scoping

##example
makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}

########################################
#create a matrix that cache its inverse 
makeCacheMatrix <- function(x = matrix()) {
    m<-NULL
    set <- function(y) {
        x<<- y
        m<<-NULL
    }
    get<-function() x    
    setinverse<- function(inverse) m <<- inverse
    getinverse<- function() m 
    list(set=set,get=get,
         setinverse=setinverse,
         getinverse=getinverse)
}

#computes the inverse of the matrix by makeCacheMatrix 
cacheSolve <- function(x, ...) {
    m<-x$getinverse()
    if (!is.null(m)) {
        message("getting cache data")
        return(m)  #return the inverse from cache
    }
    data<-x$get()
    m<-solve(data, ...)
    x$setinverse(m)
    m
}

#####################programming assignment 3 

###2 best 
best <-function(state,outcome) {
    ##read outcome data
    outcome_of_care<-read.csv("outcome-of-care-measures.csv")
    
    ##check validity
    statelist<-outcome_of_care[,7]
    outcomelist<-c('heart attack', 'heart failure', "pneumonia")
    if (!(state %in% statelist)) {
        print(state)
        stop("invalid state")
    }
    if (!(outcome %in% outcomelist)) {
        stop("invalid outcome")
    }
    
    ##define col
    if (outcome=='heart attack') {column=11}
    if (outcome=='heart failure') {column=17}
    if (outcome=='pneumonia') {column=23}
    
    
    ##order data 
    stateslist <- outcome_of_care [grep(state,outcome_of_care$State),] #dataframe for a given state 
    a<-suppressWarnings(as.numeric(levels(stateslist[,column])[stateslist[,column]])) #return a numeric vector for choosen column 
    orderdata <- stateslist[order(a,stateslist[,2],na.last = NA),]  #order data 
    name <- levels(orderdata[,2])[orderdata[1,2]]
    

 return(name)

} 

##call 
best("MD", "pneumonia")
best("TX", "heart attack")
best("TX", "heart failure")





###3: rankhospital
rankhospital <- function(state,outcome,num) {
    ##read outcome data
    outcome_of_care<-read.csv("outcome-of-care-measures.csv")
    
    ##check validity
    statelist<-outcome_of_care[,7]
    outcomelist<-c('heart attack', 'heart failure', "pneumonia")
    if (!(state %in% statelist)) {
        print(state)
        stop("invalid state")
    }
    if (!(outcome %in% outcomelist)) {
        stop("invalid outcome")
    }
    
    ##define col
    if (outcome=='heart attack') {column=11}
    if (outcome=='heart failure') {column=17}
    if (outcome=='pneumonia') {column=23}
    
    ##order data 
    stateslist <- outcome_of_care [grep(state,outcome_of_care$State),] #dataframe for a given state 
    a<-suppressWarnings(as.numeric(levels(stateslist[,column])[stateslist[,column]])) #return a numeric vector for choosen column 
    orderdata <- stateslist[order(a,stateslist[,2],na.last = NA),]  #order data 
    last<-nrow(orderdata)
    ##return name of given name 
    if (num == "best") {
        name<-levels(orderdata[,2])[orderdata[1,2]]
    } else if (num == "worst") {
        name<-levels(orderdata[,2])[orderdata[last,2]]
    } else 
        name<-levels(orderdata[,2])[orderdata[num,2]]
    
    print(name)

}


#call 
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)
rankhospital("TX", "heart failure", 4)
rankhospital("WV", "pneumonia", "worst")


###4 rankall 
rankall <- function(outcome,num="best") {
    ##read outcome data
    outcome_of_care<-read.csv("outcome-of-care-measures.csv")
    
    ##check validity
    outcomelist<-c('heart attack', 'heart failure', "pneumonia")
    if (!(outcome %in% outcomelist)) {
        stop("invalid outcome")
    }
    
    ##return best hospital for each state 
    
    #define col
    if (outcome=='heart attack') {column=11}
    if (outcome=='heart failure') {column=17}
    if (outcome=='pneumonia') {column=23}
   
     state<-levels(outcome_of_care[,7]) #save character vector for state levels
     output<-c() #create blank vector 
    
     for (i in 1:length(state) ) {
        stateslist <- outcome_of_care [grep(state[i],outcome_of_care$State),] #dataframe for a given state 
        a<-suppressWarnings(as.numeric(levels(stateslist[,column])[stateslist[,column]])) #return a numeric vector for choosen column 
        orderdata <- stateslist[order(a,stateslist[,2],na.last = NA),]  #order data 
        last <-nrow(orderdata)
        
        ##return name of given name 
        if (num == "best") {
            name<-levels(orderdata[,2])[orderdata[1,2]]
        } else if (num == "worst") {
            name<-levels(orderdata[,2])[orderdata[last,2]]
        } else 
            name<-levels(orderdata[,2])[orderdata[num,2]]
        
        output<-rbind(output,c(name,state[i]))
        result<-as.data.frame(output,length(state),2,byrow = TRUE)     
     }
             
         
         rownames(result) <- state
         colnames(result) <- c("hospital","state")
         
         return(result)       
    }
    
    
##return 
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)    




