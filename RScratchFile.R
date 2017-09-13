summary(output)

colnames(output)
output %>% ggplot(aes(x = Intensity, y = Name)) + geom_point()

ggplot(output) + geom_joy(aes(x = Intensity, y = Name))

d <- data.frame(x = rep(1:5, 3), y = c(rep(0, 5), rep(1, 5), rep(2, 5)),
                height = c(0, 1, 3, 4, 0, 1, 2, 3, 5, 4, 0, 5, 4, 4, 1))
ggplot(d, aes(x, y, height = height, group = y)) + geom_ridgeline(fill = "lightblue")

ggplot(iris, aes(x = Sepal.Length, y = Species)) + geom_joy2()

#Looking at the RGB channels from jpeg
bdf <- as.data.frame(img_g)
head(bdf,3)
bdf <- plyr::mutate(bdf,channel=factor(cc,labels=c('R','G','B')))
ggplot(bdf,aes(value,col=channel))+geom_histogram(bins=30)+facet_wrap(~ channel)


#Create a data.frame with columns x,y and value
df <- expand.grid(x=1:10,y=1:10) %>% mutate(value=x*y)
#Convert to cimg object (2D, grayscale image of size 10*10
as.cimg(df,dims=c(10,10,1,1)) %>% plot