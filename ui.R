# selectedYear <- 2002 #Pick year from 1800-2018
# xVar <- "mortality" #Pick one of: "mortality" "expectancy" "income" "population"
# yVar <- "income"  #Pick one of: "mortality" "expectancy" "income" "population"
# xLabel <- "Child Mortality\n(Number of 0-5 year olds died per 1000 births)" #Give appropriate label, suggestions: "Child Mortality\n(Number of 0-5 year olds died per 1000 births)", "Life Expectancy (in years)", ""GDP per Capita \n (inflation-adjusted)", "Population"
# yLabel <- "GDP per Capita" #Give appropriate label, suggestions: "Child Mortality\n(Number of 0-5 year olds died per 1000 births)", "Life Expectancy (in years)", ""GDP per Capita \n (inflation-adjusted)", "Population"
# xTrans <- "identity" #Pick one of "identity", "log2"
# yTrans <- "log2" #Pick one of "identity", "log2"
# xDollar <- F #Pick T or F
# yDollar <- T #Pick T or F
# countriesOfInterest <- c("India","United States","Nigeria") #name countries to highlight and label

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Gapminder immitation"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("year", "Pick a Year", min=1800,max=2018,value=1800,sep=""),
            selectInput("xVar","Pick an X Variable", c("mortality", "expectancy", "income", "population")),
            selectInput("yVar","Pick a Y Variable", c("mortality", "expectancy", "income", "population")),
            textInput("xLabel", "Enter a Label for the X-Axis"),
            textInput("yLabel", "Enter a Label for the Y-Axis"),
            radioButtons("xTrans","Pick a transformation for the X variable",c("identity","log2")),
            radioButtons("yTrans","Pick a transformation for the Y variable",c("identity","log2")),
            checkboxInput("xDollar", "Should X Variable be Labelled as a Dollar Amount?"),
            checkboxInput("yDollar", "Should Y Variable be Labelled as a Dollar Amount?"),  
            selectInput("countriesofInterest", "Pick Some Countries to Highlight and Label",
                        levels(as.factor(full_data$country)),multiple=TRUE)
            ),
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("aNicePlot")
        )
    )
))


