library(shiny)
library(data.table)
library(stringr)
library(shinythemes)
library(leaflet) 
library(DT)
library(geojsonio)
library(ggmap)
library(dplyr)
library(esquisse)

 # traffic_crimes = fread("https://opendata.smit.ee/ppa/csv/liiklusjarelevalve_2.csv", enc = "UTF-8")
#  public_crimes = fread("https://opendata.smit.ee/ppa/csv/avalik_2.csv", encoding = "UTF-8")
#  property_crimes = fread("https://opendata.smit.ee/ppa/csv/vara_2.csv", encoding = "UTF-8")
#  
# 
# 
# lest_geo = function(x, y){
#   # Konverteerib L-EST97 koordinaadid kaardirakendusele sobivaks (nn tavapäärasteks koordinaatideks)
#   # Kasutatud on maa-ameti veebilehel olevat php koodi:
#   # http://www.maaamet.ee/rr/geo-lest/files/geo-lest_function_php.txt
# 
# 
#   a = 6378137
#   F = 1 / 298.257222100883
#   ESQ = F + F - F * F
#   B0 = (57 + 31 / 60 + 3.194148 / 3600) / (180/pi)
#   L0 = 24 / (180/pi)
#   FN = 6375000
#   FE = 500000
#   B2 = (59 + 20 / 60) / (180/pi)
#   B1 = 58 / (180/pi)
#   xx = x - FN
#   yy = y - FE
#   t0 = sqrt((1 - sin(B0)) / (1 + sin(B0)) * ((1 + sqrt(ESQ) * sin(B0)) / (1 - sqrt(ESQ) * sin(B0))) ** sqrt(ESQ))
#   t1 = sqrt((1 - sin(B1)) / (1 + sin(B1)) * ((1 + sqrt(ESQ) * sin(B1)) / (1 - sqrt(ESQ) * sin(B1))) ** sqrt(ESQ))
#   t2 = sqrt((1 - sin(B2)) / (1 + sin(B2)) * ((1 + sqrt(ESQ) * sin(B2)) / (1 - sqrt(ESQ) * sin(B2))) ** sqrt(ESQ))
#   m1 = cos(B1) / (1 - ESQ * sin(B1) * sin(B1)) ** 0.5
#   m2 = cos(B2) / (1 - ESQ * sin(B2) * sin(B2)) ** 0.5
#   n1 = (log(m1) - log(m2)) / (log(t1) - log(t2))
#   FF = m1 / (n1 * t1 ** n1)
#   p0 = a * FF * t0 ** n1
#   p = (yy * yy + (p0 - xx) * (p0 - xx)) ** 0.5
#   t = (p / (a * FF)) ** (1 / n1)
#   FII = atan(yy / (p0 - xx))
#   LON = FII / n1 + L0
#   u = (pi / 2) - (2 * atan(t))
#   LAT = (u + (ESQ / 2 + (5 * ESQ ** 2 / 24) + (ESQ ** 3 / 12) + (13 * ESQ ** 4 / 360)) * sin(2 * u) +
#            ((7 * ESQ ** 2 / 48) + (29 * ESQ ** 3 / 240) + (811 * ESQ ** 4 / 11520)) * sin(4 * u) +
#            ((7 * ESQ ** 3 / 120) + (81 * ESQ ** 4 / 1120)) * sin(6 * u) + (4279 * ESQ ** 4 / 161280) * sin(8 * u))
#   LAT = LAT * 180/pi
#   LON = LON * 180/pi
# 
#   return(data.frame(lat = LAT, lon = LON))
# }
# 
# lest_geo_square = function(x_sq, y_sq){
#   # PPA andmestikus on sÃÂÃÂ¼ndmused paigutatud ruudustikku
#   # Konverteerib ruudustiku LEST kooridnaadid tavapÃÂÃÂ¤rasesse koordinaadistikku
#   x_l = str_split_fixed(x_sq, "-", 2)
#   x_l = data.frame(x_l, stringsAsFactors = FALSE)
#   x_l[,1] = as.numeric(x_l[,1])
#   x_l[,2] = as.numeric(x_l[,2])
#   colnames(x_l) = c("x1","x2")
#   y_l = str_split_fixed(y_sq, "-", 2)
#   y_l = data.frame(y_l, stringsAsFactors = FALSE)
#   y_l[,1] = as.numeric(y_l[,1])
#   y_l[,2] = as.numeric(y_l[,2])
#   colnames(y_l) = c("y1","y2")
#   lat_lon1 = lest_geo(x_l$x1, y_l$y1)
#   lat_lon2 = lest_geo(x_l$x2, y_l$y2)
#   colnames(lat_lon1) = paste0(colnames(lat_lon1), "1")
#   colnames(lat_lon2) = paste0(colnames(lat_lon2), "2")
#   out = cbind(lat_lon1, lat_lon2)
#   return(out)
# }
# 
# add_coords = function(dataset){
#   # lisab andmestikule uute tunnustena konverteeritud koordinaadid
#   return(cbind(dataset,lest_geo_square(dataset$Lest_X, dataset$Lest_Y)))
# }
# 
# traffic_crimes<-add_coords(traffic_crimes)
# property_crimes<-add_coords(property_crimes)
# public_crimes<-add_coords(public_crimes)
# 
# traffic_crimes <- traffic_crimes %>% mutate(lon = (lon1 + lon2)/2, lat = (lat1 + lat2)/2) %>% filter(!is.na(lat1))
# property_crimes <- property_crimes %>% mutate(lon = (lon1 + lon2)/2, lat = (lat1 + lat2)/2) %>% filter(!is.na(lat1))
# public_crimes <- public_crimes %>% mutate(lon = (lon1 + lon2)/2, lat = (lat1 + lat2)/2) %>% filter(!is.na(lat1))
# 
# traffic_crimes <- filter(traffic_crimes, traffic_crimes$ValdLinnNimetus == "Tallinn")
# property_crimes <- filter(property_crimes, property_crimes$ValdLinnNimetus == "Tallinn")
# public_crimes <- filter(public_crimes, public_crimes$ValdLinnNimetus == "Tallinn")
# 
# traffic_crimes <- traffic_crimes %>% select(ToimKpv, ToimKell, ToimNadalapaev, ParagrahvTais,ValdLinnNimetus,KohtNimetus,MntTanavNimetus,SoidukLiik,SoidukMark,RikkujaSugu,RikkujaVanus,lon,lat)
# property_crimes <- property_crimes %>% select(ToimKpv, ToimKell, ToimNadalapaev, SyndmusLiik, SyndmusTaiendavStatLiik, ParagrahvTais, Kahjusumma, KohtLiik, ValdLinnNimetus, KohtNimetus,lon, lat)
# public_crimes <-public_crimes %>% select(ToimKpv, ToimKell, ToimNadalapaev, SyndmusLiik, SyndmusTaiendavStatLiik, ParagrahvTais, Kahjusumma, KohtLiik, ValdLinnNimetus, KohtNimetus, lon, lat)
# saveRDS(traffic_crimes, "trafficCrimeEdited.RDS")
# saveRDS(property_crimes, "propertyCrimeEdited.RDS")
# saveRDS(public_crimes, "publicCrimeEdited.RDS")
# schools <- fread("schoolTestScores.csv", encoding = "UTF-8")
# saveRDS(schools, "schools.RDS")
#write.csv(school, "school.csv")
#write.csv(lasteaed,"lasteaed.csv")
#write.csv(schools,"schools.csv")
# saveRDS(schools,"schools.RDS")
traffic <- readRDS("trafficCrimeEdited.RDS")
traffic$ToimKpv <- as.Date(traffic$ToimKpv)
public <- readRDS("publicCrimeEdited.RDS")
public$ToimKpv <- as.Date(public$ToimKpv)
property <- readRDS("propertyCrimeEdited.RDS")
property$ToimKpv <- as.Date(property$ToimKpv)
schools <- readRDS("schools.RDS")
#schools <- fread("schools.csv", encoding = "UTF-8")
# schools$schoolTestScores.school.or.criterion <- gsub("<fc>","ü",schools$schoolTestScores.school.or.criterion)
# schools$schoolTestScores.school.or.criterion <- gsub("<e4>","ä",schools$schoolTestScores.school.or.criterion)
# schools$schoolTestScores.school.or.criterion <- gsub("<f5>","õ",schools$schoolTestScores.school.or.criterion)
# schools$schoolTestScores.school.or.criterion <- gsub("<d5>","õ",schools$schoolTestScores.school.or.criterion)
# schools$schoolTestScores.school.or.criterion <- gsub("<dc>","Ü",schools$schoolTestScores.school.or.criterion)
# saveRDS(schools, "schools.RDS")


school <- fread("school.csv", encoding = "UTF-8")
lasteaed <- fread("lasteaed.csv", encoding = "UTF-8")
cols <- c("KohtNimetus", "ToimNadalapaev", "SyndmusLiik", "SyndmusTaiendavStatLiik","Kahjusumma") 
property <- property %>% mutate_at(cols, factor)
public <- public %>%  mutate_at(cols, factor)
cols2 <- c("KohtNimetus", "ToimNadalapaev","SoidukLiik", "SoidukMark", "RikkujaVanus","RikkujaSugu") 

traffic <- traffic %>% mutate_at(cols2, factor)

datasetOptions <- c("Property Crime" = "property",
                    "Traffic Incidents" = "traffic",
                    "Public Crime" = "public",
                    "School Locations" = "school",
                    "Lasteaed Locations" = "lasteaed"
)


