#Question 2
library(jpeg)
image = jpeg::readJPEG("./quiz3_data/getdata-jeff.jpg",native = TRUE)
quantile(image, c(0.3,0.8))