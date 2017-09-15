library(leaflet)
library(magrittr)

# 输出带有标记的地图

SFmap <- leaflet() %>%
  addTiles() %>%
  setView(118.46, 32.03, zoom=13) %>% # 设置经度，纬度和缩放比例
  addMarkers(118.46, 32.03, popup='jiangsu') # 设定弹出信息

SFmap
  
# 输出圆圈标记的地图
SFmap <- leaflet() %>%
  addTiles() %>%
  setView(118.46, 32.03, zoom=13) %>% 
  addCircleMarkers(118.46, 32.03, popup='江苏', radius=10, color='red')

SFmap

# 建立多位置标注的地图
sj = read.table('clipboard.txt', header=T)
SFmap1 <- leaflet() %>%
  addTiles() %>%
  setView(118.4, 32.04, zoom=13) %>%
  addMarkers(data=sj, lng=~X, lat=~Y, popup=sj$crime) # 设置多位置标签及地理位置
SFmap1

#不同事件的分区标注地图
SFmap2 <- leaflet() %>%
  addTiles() %>%
  setView(118.46, 32.04, zoom=10) %>%
  addCircleMarkers(data=sj, lng=~X, lat=~Y, radius=5, color=~ifelse(crime=='BRIBERY', 'red', 'blue'), 
                   clusterOptions=markerClusterOptions()) #对不同的事件进行标示
SFmap2

# z
dl_cust = read.table('D:/dl_cust_info.csv', sep=',', header=T, fill=T)
# ORIGINAL_LONGITUDE	ORIGINAL_LATITUDE
DLmap1 = leaflet() %>%
  addTiles() %>%
  setView(122.0, 39.5, zoom=13) %>%
  addMarkers(data=dl_cust, lng=~ORIGINAL_LONGITUDE, lat=~ORIGINAL_LATITUDE, popup=dl_cust$SHOP_NAME)

DLmap1


# 读取云POS零售户，并与商户信息关联
pos_cust = read.table('D:/temp/data_file/云pos零售户.csv', sep=',', header=T)
#LICENSE_CODE
pos_cust_info <-  merge(dl_cust, pos_cust, by.x='LICENSE_CODE', by.y='LICENSE_CODE')
# 在地图上展示云POS户
DLmap2 = leaflet() %>%
  addTiles() %>%
  setView(122.0, 39.5, zoom=13) %>%
  addMarkers(data=pos_cust_info, lng=~ORIGINAL_LONGITUDE, lat=~ORIGINAL_LATITUDE, popup=pos_cust_info$SHOP_NAME)
DLmap2

#按照不同颜色展示不同类型的云pos户
# 直营店 合作 普通 使用者 不在发展 
getColor <- function(df_cust){
  sapply(df_cust$DICT_VALUE, function(dict_value){
    if(dict_value == '直营店'){
      "green"
    }else if(dict_value == '合作'){
      "blue"
    }else if(dict_value == '普通'){
      "orange"
    }else if(dict_value == '使用者'){
      "red"
    }else{
      "gray"
    }
  })
}

icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(pos_cust_info)
)

leaflet(pos_cust_info) %>%
  addTiles() %>%
  addAwesomeMarkers(~ORIGINAL_LONGITUDE, ~ORIGINAL_LATITUDE, icon=icons, label=~SHOP_NAME)

# Marker Clusters
leaflet(pos_cust_info) %>%
  addTiles() %>%
  addMarkers(
    clusterOptions = markerClusterOptions()
  )

# 读取云POS零售户，并与商户信息关联
market = read.table('D:/temp/dl_market_info.csv', sep=',', header=T)


#################################################
# z
cust_sales = read.table('D:\\temp\\data_file\\export\\玉溪（软）_H_all.csv', sep=',', header=T, fill=T, encoding = 'utf-8')

summary(cust_sales)

getColor2 <- function(cust_sale){
  sapply(cust_sale$H, function(H_value){
    if(is.na(H_value)){
      "blue"
    }else if(H_value < 1.578){
      "blue"
    }else if(H_value < 2.278){
      "green"
    }else if(H_value < 3.699){
      "yellow"
    }else{
      "red"
    }
  })
}

# ORIGINAL_LONGITUDE	ORIGINAL_LATITUDE
DLmap1 = leaflet() %>%
  addTiles() %>%
  setView(122.0, 39.5, zoom=13) %>%
  addCircleMarkers(data=cust_sales, lng=~ORIGINAL_LONGITUDE, lat=~ORIGINAL_LATITUDE, 
                   radius=1, color=getColor2(cust_sales), 
                   popup=cust_sales$CUST_NAME)
DLmap1

