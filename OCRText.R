library(magick)
library(magrittr)
library(imager)


text <- image_read("data/frame390.jpg") %>%
  image_resize("2000") %>%
  image_convert(colorspace = 'gray') %>%
  image_trim() %>%
  image_ocr()

cat(text)

text <- image_read("data/frame390.jpg")

files <- list.files("data", pattern = "*.jpg")
file_df <- data.frame(files) 

for(i in files)
{
  print(i)
  #image_read(paste0("data/",i))
}
