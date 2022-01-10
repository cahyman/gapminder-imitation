# gapminder-imitation
Shiny web app that imitates the Gapminder bubble interactive animation. 


Inspired by Gapminder's comprehensive data visualization tool, I created a Shiny web app that functions in a similar way. The app contains a slider that allows the user to choose a specific year to examine. The user is able to choose between a logarithmic or identity transformation of the data on either axis. The user is allowed to choose which variables to display on the X and Y axes. The user is also able to highlight certain countries. 

bubbles-parametarized.R contains the code that modifies the data and plots a snapshot of the data shown in the shiny app. The following variables are placeholders. For example, in the shinyapp, input$xVar is an interactive variable that allows the user to choose between "mortality" "expectancy" "income" "population". 

    selectedYear <- 2002 #Choose a year from 1800-2018
    xVar <- "mortality" #Pick one of: "mortality" "expectancy" "income" "population"
    yVar <- "income"  #Pick one of: "mortality" "expectancy" "income" "population"
    xLabel <- "Child Mortality\n(Number of 0-5 year olds died per 1000 births)" #Give appropriate label, suggestions: "Child Mortality\n(Number of 0-5 year olds died per 1000 births)", "Life Expectancy (in years)", ""GDP per Capita \n (inflation-adjusted)", "Population"
    yLabel <- "GDP per Capita" #Give appropriate label, suggestions: "Child Mortality\n(Number of 0-5 year olds died per 1000 births)", "Life Expectancy (in years)", ""GDP per Capita \n (inflation-adjusted)", "Population"
    xTrans <- "identity" #Pick one of "identity", "log2"
    yTrans <- "log2" #Pick one of "identity", "log2"
    xDollar <- F #Pick T or F
    yDollar <- T #Pick T or F
    countriesOfInterest <- c("India","United States","Nigeria") #name countries to highlight and label
