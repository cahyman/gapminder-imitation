library(tidyverse)
library(ggrepel)

income_wide <- read_csv("income.csv")
expectancy_wide <- read_csv("life_expectancy_years.csv")
population_wide <- read_csv("population_total.csv")
child_mortality_wide <- read_csv("child_mortality.csv")
gapGeo <- read_csv("gapMinderGeo.csv")

income_tall <- gather(income_wide,key="year",value="income",-country)
income_tall <- mutate(income_tall,year=as.numeric(year))

child_mortality_tall <- gather(child_mortality_wide,key="year",value="mortality",-country)
child_mortality_tall <- mutate(child_mortality_tall,year=as.numeric(year))

expectancy_tall <- gather(expectancy_wide,key="year",value="expectancy",-country)
expectancy_tall <- mutate(expectancy_tall,year=as.numeric(year))

population_tall <- gather(population_wide,key="year",value="population",-country)
population_tall <- mutate(population_tall,year=as.numeric(year))

regions <- select(gapGeo, country=name, region=four_regions)

full_data <- full_join(income_tall,expectancy_tall,by=c("country","year"))
full_data <- full_join(full_data,population_tall,by=c("country","year"))
full_data <- full_join(full_data,child_mortality_tall,by=c("country","year"))
full_data <- left_join(full_data,regions,by="country")

#####parameterization##############
selectedYear <- 2002 #Pick year from 1800-2018
xVar <- "mortality" #Pick one of: "mortality" "expectancy" "income" "population"
yVar <- "income"  #Pick one of: "mortality" "expectancy" "income" "population"
xLabel <- "Child Mortality\n(Number of 0-5 year olds died per 1000 births)" #Give appropriate label, suggestions: "Child Mortality\n(Number of 0-5 year olds died per 1000 births)", "Life Expectancy (in years)", ""GDP per Capita \n (inflation-adjusted)", "Population"
yLabel <- "GDP per Capita" #Give appropriate label, suggestions: "Child Mortality\n(Number of 0-5 year olds died per 1000 births)", "Life Expectancy (in years)", ""GDP per Capita \n (inflation-adjusted)", "Population"
xTrans <- "identity" #Pick one of "identity", "log2"
yTrans <- "log2" #Pick one of "identity", "log2"
xDollar <- F #Pick T or F
yDollar <- T #Pick T or F
countriesOfInterest <- c("India","United States","Nigeria") #name countries to highlight and label
###################################

plot_data <- filter(full_data,year==selectedYear)

if(xTrans=="log2"){
  xrange <- c(1,max(full_data[,xVar],na.rm=T))
  xcenter <- 2^(mean(c(1, max(log2(na.omit(full_data[,xVar]))))))
} else if(xTrans=="identity"){
  xrange <- c(0,max(full_data[,xVar],na.rm=T))
  xcenter <- mean(xrange)
}

if(yTrans=="log2"){
  yrange <- c(1,max(full_data[,yVar],na.rm=T))
  ycenter <- 2^(mean(c(1,max(log2(na.omit(full_data[,yVar]))))))
} else if(yTrans=="identity"){
  yrange <- c(0,max(full_data[,yVar],na.rm=T))
  ycenter <- mean(yrange)
}


g <- ggplot(plot_data)+
  annotate(geom="text",x=xcenter,y=ycenter,
           label=selectedYear,size=50,color="grey90")+
  geom_point(aes_string(x=xVar,
                 y=yVar,
                 size="population",
                 color="region"),alpha=.4,shape=16)+
  geom_point(data=filter(plot_data,country %in% countriesOfInterest),
             aes_string(x=xVar,
                        y=yVar,
                        size="population",
                        color="region"),shape=16)+
  scale_size_area(guide=F,max_size=35,limits=c(0,max(full_data$population)))+
  scale_color_discrete(name=element_blank())+
  theme_minimal()

if(xDollar){
  g <- g + scale_x_continuous(labels=scales::dollar,
                         name=xLabel,
                         trans=xTrans,
                         limits=xrange)
} else{
  g <- g + scale_x_continuous(name=xLabel,
                         trans=xTrans,
                         limits=xrange)
}

if(yDollar){
  g <- g + scale_y_continuous(labels=scales::dollar,
                         name=yLabel,
                         trans=yTrans,
                         limits=yrange)
} else{
  g <- g + scale_y_continuous(name=yLabel,
                         trans=yTrans,
                         limits=yrange)
}

g+geom_text_repel(data=filter(plot_data,country %in% countriesOfInterest),
            aes_string(x=xVar,y=yVar,label="country"),size=5)

