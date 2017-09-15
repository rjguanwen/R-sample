.libPaths()
library()
search()

v <- c('hello', 'loop')
cnt <- 2

repeat{
  print(v)
  cnt <- cnt + 1
  if(cnt > 5){
    break
  }
}

city <- c("beijing", "shanghai", "dalian", "jinan")
temperatrue <- c(30, 28, 25, 33)
zipcode <- c(111111, 222222, 333333, 444444)

# cbind() 将多个向量连接为一个dataframe
address = cbind(city, temperatrue, zipcode)

address

cat("###第一个dataframe")

# 直接创建dataframe
new.address <- data.frame(
  city = c("chongqing", "chengdu"),
  temperatrue = c(36, 32),
  zipcode = c("555555", "666666"),
  stringAsFactors = FALSE
)

print(new.address)

new.address.1 <- data.frame(
  city = c("chongqing", "chengdu"),
  temperatrue = c(36, 32),
  zipcode = c("555555", "666666")
)

print(new.address.1)

all.adress <- rbind(address, new.address.1)

all.adress
