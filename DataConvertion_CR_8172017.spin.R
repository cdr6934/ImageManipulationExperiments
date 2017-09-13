library(magick)
library(stringr)
library(imager)
library(ggplot2)



#Read jpeg files into the system 
files <- list.files("data", pattern = "*.jpg")

#Create the file 
imageDataset <- data.frame(Name = character(), Intensity = double())


# Reads through files 
for(i in files)
{
  print(i)
  file_df <- load.image(paste0("~/Documents/r-sessions/ImageRecognition/data/",i))
  img <- grayscale(as.cimg(file_df))
  img <- resize(img,round(width(img)/4),round(height(img)/4))
  bdf <- as.data.frame(img)
  imgr <- data.frame(Name = as.numeric(str_replace(i, ".jpg", "")), Intensity = bdf$value)
  write.table(imgr, file = "output.csv", append = TRUE, row.names = FALSE, sep = ",")
}








#Looking at the RGB channels from jpeg
bdf <- as.data.frame(img_g)
head(bdf,3)
bdf <- plyr::mutate(bdf,channel=factor(cc,labels=c('R','G','B')))
ggplot(bdf,aes(value,col=channel))+geom_histogram(bins=30)+facet_wrap(~ channel)


#Create a data.frame with columns x,y and value
df <- expand.grid(x=1:10,y=1:10) %>% mutate(value=x*y)
#Convert to cimg object (2D, grayscale image of size 10*10
as.cimg(df,dims=c(10,10,1,1)) %>% plot
