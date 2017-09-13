library(magick)
library(stringr)
library(imager)
library(ggplot2)
library(ggjoy)
library(dplyr)
library(plotly)


#Read jpeg files into the system 
files <- list.files("data", pattern = "*.jpg")

#Create the file 
imageDataset <- data.frame(Name = numeric(), Intensity = double())

graphs <- 0

# Reads through files 
for(i in files)
{
  print(i)
  file_df <- load.image(paste0("~/Documents/r-sessions/ImageRecognition/data/",i))
  img <- grayscale(as.cimg(file_df))
  img <- resize(img,round(width(img)/4), round(height(img)/4))
  bdf <- as.data.frame(img)
  imgr <- data.frame(Name = as.numeric(str_replace(i, ".jpg", "")), Intensity = bdf$value)
 
  percentUnder <- imgr %>% filter(Intensity <= 0.3) %>% summarize(LowerThan = n())
  print(percentUnder)
  imageDataset <- rbind(imageDataset, c(as.numeric(str_replace(i, ".jpg", "")),percentUnder$LowerThan))
  
  if(graphs == 1)
  {
     graph <- imgr %>% ggplot( aes(Intensity, xmin = 0.25, xmax = 0.35)) + geom_histogram(bins = 50)
     ggsave(paste0(str_replace(i, ".jpg", ""),'.jpeg'), plot = graph)
  }
  # write.table(imgr, file = "output.csv", append = TRUE, row.names = FALSE, sep = ",")
}

#Generate data 
colnames(imageDataset) <- c("Frame","Intensity")
g <- imageDataset %>% ggplot(aes(Frame, Intensity)) + geom_line()
g

ggplotly(g)
write.csv(imageDataset, "img4626.csv")

SingleFrame <- function(i)
{
  print(i)
  file_df <- load.image(paste0("~/Documents/r-sessions/ImageRecognition/data/",i))
  img <- grayscale(as.cimg(file_df))
  img <- resize(img,round(width(img)/4),round(height(img)/4))
  bdf <- as.data.frame(img)
  imgr <- data.frame(Name = as.numeric(str_replace(i, ".jpg", "")), Intensity = bdf$value)
  graph <- imgr %>% ggplot( aes(Intensity, xmin = 0.30, xmax = 0.35)) + geom_histogram(bins = 50)
  ggsave(paste0(i,'.jpeg'), plot = graph)
  #write.table(imgr, file = "output.csv", append = TRUE, row.names = FALSE, sep = ",")
}

SingleFrame(paste0(30,".jpg"))

for(x in 1:316)
{
  SingleFrame(paste0(x,".jpg"))
}

# Reads through files 
for(i in files)
{
  print(i)
  file_df <- load.image(paste0("~/Documents/r-sessions/ImageRecognition/data/",i))
  img <- grayscale(as.cimg(file_df))
  img <- resize(img,round(width(img)/4),round(height(img)/4))
  bdf <- as.data.frame(img)
  imgr <- data.frame(Name = as.numeric(str_replace(i, ".jpg", "")), Intensity = bdf$value)
  hist(imgr$Intensity, xlim = c(0.2,0.4), breaks = 20)
  dev.print(png, paste0(i,'.png'))
  #write.table(imgr, file = "output.csv", append = TRUE, row.names = FALSE, sep = ",")
}




