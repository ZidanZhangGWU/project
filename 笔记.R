#working dictory 
getwd()

#r function to simulate 
myfunction<- function() {
    x<-rnorm(100)
    mean(x)
}

second <- function(x) {
    x * rnorm(length(x))
}

#way to load R codes to R Console:
# save as R Code.R then 
#source("R Code.R); ls()

#assign values 
x<-5; x<-1:20
x<-"imcomplete"

########R data types
#vector 
x=vector()
#numeric 
x<-1
y<-1L ###as integer
z<-1/0      ####z turns out to be INF
k=0/0   ###NaN as missing value 

#create vectors 
x<-c(0.5,0.6) ##numeric
x<-vector("numeric",length=10) ##numeric vector defalut is 0
y<-c(True,False) ##logical
z<-c("a") ##character
k<-9:29 ##integer
#mixing objects--coercion for different classes  
y<-c(1.7,"a") #character
y<-c(TRUE,2) #numeric since TRUE is 1 and FALSE is 0
y<-c("a",TRUE) ##character 
#explicit coercion
x<-0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)

####list 
x<-list(1,"a",TRUE,1+4i)

##create matrices 
m<-matrix(nrow=2,ncol=3)
dim(m)
attributes(m)
m<-matrix(1:6,nrow=2,ncol=3)

##or
m<-1:10
dim(m)<-c(2,5)

##or
x<-1:3
y<-10:12
cbind(x,y)
rbind(x,y)

##create factor
x<-factor(c("yes","yes","no","yes","no"))
table(x) ##frequency counts
#set order of the levels 
x<-factor(c("yes","yes","no","yes","no"),levels=c("yes","no"))
#order is important in linear modeling becasue the first level is baseline level

##missing values
is.na() #test if they are NA
is.nan() #test for NaN

x<-c(1,2,NaN,NA,3)
is.na(x)
is.nan(x)

##data frames creation 
x<-data.frame(foo=1:4,bar=c(T,T,F,F)) ##first column is foo variable and second column is bar variables

##Names attributes 
x<-1:3
names(x)<-c("foo","Bar","Cd")
#name matrixs 
m<-matrix(1:4,nrow=2,ncol=2)
dimnames(m)<-list(c("a","b"),c("c","d"))

###dput-ting R objects 
y<-data.frame(a=1,b="a")
dput(y)
structure(list(a=1,
               b=structure(1L,.label="a",
                           class="factor")),
          .Name=c("a","b"),row.names=c(NA,-1L),
          class="data.frame")

dput(y,file="y.R")
new.y<-dget("y.R")

##dymping R objects--can use in multiple objects 
# x and y has been reconstructed 
x<-"foo"
y<-data.frame(a=1,b="a")
dump(c("x","y"),file="data.R")
rm(x,y)
source("data.R")


##use connection to read the file 
con<-file("math.csv","r")
x<-readLines(con,10)

##also read the webpages
con<-url("http://jhsph.edu","r")
x<-readLines(con)

###subsetting
x<-c("a","b","c","c","d","a")
#subset using numerical index
x[1]
x[1:4]
#subset using logical 
x[x>"a"]
#or 
u<-x>"a"
x[u]

##subsetting lists
x<-list(foo=1:4,bar=0.6,baz="hello")
x[1]
x[[1]] ##return just the sequences 
x$foo
x[["foo"]]
x["foo"]  ##the single one return a list 

x[c(1,3)] ##single one return multiple elements 

name<-"foo"
x[[name]]  ##computed index for "foo"
###can't use x$name

#subset nested element 
####[[ ]] can taje an integer sequence rather than a signle number
x<-list(a=list(10,12,14),b=c(3.14,2.81))
x[[c(1,3)]]  ##the third element within the first element 
x[[1]][[3]] ##same as double subsetting 

##subsetting a matrix
x<-matrix(1:6,2,3)
x[1,2] ##first row second column; it returns a vector, not a 1*1 matrix by default
x[1, ] ##first row 
x[1,2,drop=FALSE] ##can preserve the dimension to 1 by 1 
x[1, ,drop=FALSE]

##partial matching 
##is allowed with [[ and $.
x<-list(aardvark=1:5)
x$a
x[["a",exact=FALSE]]

##removing NA values 
x<-c(1,2,NA,4,NA,5)
bad<-is.na(x) ##as a logical vector
x[!bad] ##! to exclude bad element 

##to see both not missing
x<-c(1,2,NA,4,NA,5)
y<-c("a","b",NA,"D",NA,"f")
good<-complete.cases(x,y)
x[good] ##subset good elements 


##vectorized operations 
x<-1:4
y<-6:9
x+y ##add each number in the vector 
x>2
y==8 ##test equality 
####  == is to test equality!!!
x*y
x/y

x<-matrix(1:4,2,2)
y<-matrix(rep(10,4),2,2)
x*y ##element-wise multiplication
x %*% y ##matrix multiplication 

####conrtol structure: if
#if () {#do something} else {#do something}
if (x>3) {y<-10} else {y<-0}
#or
y<-if(x>3) {10} else {0}

##for loop
x<-c("a","b","c","d")
for(i in 1:4) {print(x[i])} ##print out i's element of x
for (i in seq_along(x)) {print(x[i])} ##sequence of x 
for (letter in x) {print(letter)}
for(i in 1:4) print (x[i])

##nested for loops 
x<-matrix(1:6,2,3)

for (i in seq_len(nrow(x))) {
    for (j in seq_len(ncol(x))) {
        print(x[i,j])
    } 
}

##while loop
count<-0
while(count<10) {
    print(count)
    count<-count+1
}

##conditions are always evaluated from left to right 
z<-5
while(z>=3 && z<=10) {
    print(z)
    coin<-rbinom(1,1,0.5)
    
    if(coin==1) {
        z<- z+1
    } else {
        z<-z-1
    }
}

##repeat
x0<-1
tol<-1e-8

repeat{
    x1<-computeEstimate()
    
    if(abs(X1-x0) <tol) {
        break
    } else {
        x0<-x1
    }
}

##next,return
for (i in 1:100) {
    if (i<=20) {
        ##skip the first 20 iterations here
        next
    }
    ##do something here 
}

##first function
add2 <- function(x,y) {
    x+y
}

above10 <- function(x) {
    use <- x>10 ##return logical vector
    x[use] ##return a subset that has elements greater than 10
}

above10(2)
above <- function(x,n) {
    use<-x>n
    x[use]
}

##specify the default value of n 
above <- function(x,n=10) {
    use<-x>n
    x[use]
}

columnmean <- function(y,removeNA=TRUE) {
    nc <- ncol(y)
    means <- numeric(nc)
    for(i in 1:nc) {
        means[i] <- mean(y[,i],na.rm=removeNA)
    }
    means #returns the vector mean
}

###function
# f<-function(Arguments) {##do something}

#defined function
f<-function(a,b=1,c=2,d=NULL){} #set default function

#lazy evaluation 
f<-function(a,b) {
    a^2
}
f(2) #this function never actually uses the argument b

f<-function(a,b) {
    print(a)
    print(b)
}
f(2,3)

#the "..." argument
myplot <-function(x,y,type="1",...) {
    plot(x,y,type=type,...)
}

## search() returns the search lists in global environment 

#lexical scoping
f<-function(x,y) {
    x^2 + y/z
}
## 2 formal arguments as x and y; free variable z; the 
## scoping rule determine how values are assigned to free variables 
## free variable are not formal arguments and are not local variables (assigned insided the function body)


##lexical scoping-function inside function
make.power<-function(n) {
    pow <- function(x) {  ##here n is free variable since it's not defined inside pow
        x^n
    }
    pow  #make.power is the environment in which pow is defined 
}

cube<-make.power(3)
##to see function's environment
ls(environment(cube))
get("n",environment(cube))

#lexical vs. dynamic 
y<-10
f<-function(x) {
    y<-2 ##here y is the local variable with value 2
    y^2 + g(x)
}

g<-function(x) {
    x*y ##y is defined in the global environment, so y=10
}

##with dynamic scoping, the value of y is looked up in the
##environment in which the function was called, so the value of y whould be 2, since it calls function f

##dates in R
x<-as.Date("1970-01-01")
unclass(as.Date("1970-01-02"))

##Times in R
x<-Sys.time() #it already in POSIXct format
p<-as.POSIXlt(x)
unclass(x)
x$sec ###return an error, so has to convert to POSIXlt
p<-as.POSIXlt(x)
p$sec

#character string convert to date/time 
#using strptime(), as.Date, as.POSIXlt, as.POSIXct

#operations on Dates and times
x<-as.POSIXct("2012-10-25 01:00:00")
y<-as.POSIXct("2012-10-25 06:00:00",tz="GMT")
y-x

##lapply
x<-list(a=1:5,b=rnorm(10))
lapply(x,mean) ##apply the mean function to each elements of the list 

x<-1:4
lapply(x,runif)

x<-list(a=matrix(1:4,2,2),b=matrix(1:6,3,2))
lapply(x,function(elt) elt[,1]) ##the function only exit in lapply 
##the function extract the first column of each element in x

##sapply
x<-list(a=1:4,b=rnorm(10),c=rnorm(20,1),d=rnorm(100,5))
sapply(x,mean)  

##apply
x<-matrix(rnorm(200),20,10) ##matrix with 20 rows and 10 columns 
apply(x,2,mean) ##keep the second dimension--the number of columns, 
##get back the vector that has means for each columns 

apply(x,1,mean) ##calculate the mean of the row

##so: rowSums=apply(x,1,sum)

apply(x,1,quantile,probs=c(0.25,0.75))
#returns a matrix, with # of clumn=20, # of rows=2

a<-array(rnorm(2*2*10),c(2,2,10)) #2 rows and 2 columns, with third dimension as 10 (a brunchs of 2 by 2 matrixs putting together)
apply(a,c(1,2),mean) ##here, take the average of 2 by 2 matrixes 
rowMeans(a,dims=2) #same

##mapply
list(rep(1,4),rep(2,3),rep(3,2),rep(4,1))  ##tedious to type
mapply(rep,1:4,4:1) #two arugments, and function rep

#instant vectorization 
noise<-function(n,mean,sd) {
    rnorm(n,mean,sd)
}

mapply(noise,1:5,1:5,2) ##changing to mean and n 

##tapply
x<-c(rnorm(10),runif(10),rnorm(10,1))
f<-gl(3,10)  ##create three levels, each level have 10
tapply(x,f,mean) ##returns means of each group of number 
tapply(x,f,mean,simplify=FALSE) #get back a list 

##split
x<-c(rnorm(10),runif(10),rnorm(10,1))
f<-gl(3,10)
split(x,f)

#split followed by lapply
lapply(split(x,f),mean)

#splitting a data frame
# s<-split(airquality,airquality$Month)  to split data into monthly pieces 
# lapply(s, functin(x) colMenas(x[,c("Ozone","Solar.R","Wind)]))
#returns column means for three variables for each monthy data frame 

#split on more than one level 
x<-rnorm(10)
f1<-gl(2,5)
f2<-gl(5,2)
interaction(f1,f2)  #10 levels 

str(split(x,list(f1,f2),drop=TRUE)) ##returns a list of the 10 differenet kind of interaction factor levels 
##there are empty level, then use drop 

###str function
str(lm)

s<-rnorm(100,2,4)
summary(s)
str(s)

str(file)

m<-matrix(rnorm(100),10,10)
str(m)

##simulation
x<-rnorm(10)

#set the random number seed ensures reproducibility (you can get the same result)
set.seed(1)
rnorm(5)
#because people might reproduece what you've done 

rpois(10,1)
ppois(2,2)

##generate random numbers from linear model
## e~N(0,4) x~N(0,1) beta0=0.5 beta1=2

set.seed(20)
x<-rnorm(100)
e<-rnorm(100,0,2)
y<-0.5 + 2*x + e
summary(y)
plot(x,y)


set.seed(10)
x<-rbinom(100,1,0.5)
e<-rnorm(100,0,2)
y<-0.5 + 2*x + e
summary(y)
plot(x,y)

##random sampling
set.seed(1)
sample(1:10,4)  #sample 4 from 1:10; without replacement
sample(letters,5)
sample(1:10) ##permutation
sample(1:10)
sample(1:10, replace=TRUE) ##sample w replacement 




###vector and list 
c(1, c(2, c(3, 4))) ##扁平的 same as c(1,2,3,4)

int_var <- c(1L, 6L, 10L)
attributes(int_var) #NULL
is.vector(int_var)  #true if a is a vector of the specified mode haveing no attributes other than names 
typeof(int_var)        # "integer"  
is.integer(int_var)    # TRUE
is.atomic(int_var)     # TRUE
is.numeric(int_var)    #TRUE


##强制转换
str(c("a", 1)) #character 

x <- c(FALSE, FALSE, TRUE)
as.numeric(x) ##to numeric
# Total number of TRUEs
sum(x)

##list 
x <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
str(x)

x <- list(list(list(list())))
str(x)
is.recursive(x) #TRUE since x has a recursive structure


x <- list(list(1, 2), c(3, 4))
y <- c(list(1, 2), c(3, 4)) ##可以把多个列表组合成一个列表,先把原子向量强制转化成列表
str(x) #list of two 
str(y) #list of four 

unlist()  #如果一个列表中的元素是不同的数据类型，使用unlist()进行强制类型转换成原子向量

##属性
y <- 1:10
attr(y, "my_attribute") <- "This is a vector" ##str 可以附加属性
attr(y, "my_attribute")
str(attributes(y)) 

structure(1:10, my_attribute = "This is a vector")  ##可以修改属性
attributes(y[1]) 
names(y[1]) 

###最重要的属性：
#names(x)，dim(x)和class(x)
#名字，维度，类

#取名字
x <- c(a = 1, b = 2, c = 3) #创建时
x <- setNames(1:3, c("a", "b", "c")) #添加名字
unname(x) #得到去掉名字的新向量

#因子 可以用来储存分类数据
x <- factor(c("a", "b", "b", "a"))
class(x) #factor
levels(x) ##得到a，b

# 注意：因子不可以合并
#c(factor("a"), factor("b")
  
sex_char <- c("m", "m", "m" )
sex_factor <- factor(sex_char, levels = c("m", "f"))
  
  

f1 <- factor(letters)
levels(f1) <- rev(levels(f1))

f2 <- rev(factor(letters))
f3 <- factor(letters, levels = rev(letters))

##增加维度：matrix and data frame 
##three ways
a<-matrix(1:6,ncol=3,nrow=2)
a <- array(1:6, c(3, 2)) #get same result 
c <- array(1:12, c(2, 3, 2)) #three diminsion 
a<-1:8
dim(a)<-c(4,2)

l <- list(1:3, "a", TRUE, 1.0)
dim(l) <- c(2, 2)
l

#length() in matrix are: nrow(), ncol()
#names() in matrix are: rownames(), colnames()
#names() in array is: dimnames()

c <- array(1:12, c(2, 3, 2))
dimnames(c) <- list(c("one", "two"), c("a", "b", "c"), c("A", "B"))
c

#c() in matrix are cbind()和rbind()
#c() in array are abind()
#你可以使用t()来转置一个矩阵；数组转置则用aperm()

#is.matrix(), as.matrix()




###data frame 
#其实隐藏在数据框中的是一个包含多个相同长度向量的列表

#data.frame()会默认地将字符串转换成因子，可以使用 stringAsFactors = FALSE 来取消这一转换
df <- data.frame(
    x = 1:3,
    y = c("a", "b", "c"),
    stringsAsFactors = FALSE)
str(df)

#combine data frame 
bad <- data.frame(cbind(a = 1:2, b = c("a", "b")))
str(bad)
good <- data.frame(a = 1:2, b = c("a", "b"), stringsAsFactors = FALSE)
str(good)

#特殊列
df <- data.frame(x = 1:3)
df$y <- list(1:2, 1:3, 1:4) #add an column 

bad<-data.frame(x = 1:3, y = list(1:2, 1:3, 1:4)) #会把每一单元放到一列中
correct<-dfl <- data.frame(x = 1:3, y = I(list(1:2, 1:3, 1:4)))


###曲子集
a<-list(c(1,2,3),c("a","b","c"))
a[1] ###return a list 
a[[2]]  ###return a vector




#for vector
x <- c(2.1, 4.2, 3.3, 5.4) 

x[c(3, 1)] #x[order(x)]   #sort 
x[-c(3, 1)]
x[c(TRUE, TRUE, FALSE, FALSE)] #   x[x > 3]
#x[c(TRUE, FALSE)] = x[c(TRUE, FALSE, TRUE, FALSE)]
x[]  #get the orignal vector
(y <- setNames(x, letters[1:4]))
y[c("d", "c", "a")] #return value that have the same name 






