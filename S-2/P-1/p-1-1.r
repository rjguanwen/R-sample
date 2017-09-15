
library(ggplot2)

ggplot_cars <- ggplot(data = mtcars ,aes(x = wt,y=mpg,size=mtcars$disp,color=am.f,fill=am.f))

head(mtcars)

ggplot_cars +
  geom_point() +
  geom_text(data=mtcars,aes(x=wt,y=mpg,label=am.f),size=4) +
  labs(title = "Automobile Data汉子" ,x='Weight',y="Miles Per Gallon")

# install.packages(gcookbook)

library(gcookbook)
library(ggplot2)
head(heightweight)

ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point(size=3,shape=21)
