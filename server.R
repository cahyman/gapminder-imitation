#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
#render function makes a dynamic object
#output function shows/displays the dynamic object created by render function 
    

    output$aNicePlot<-renderPlot({
        
        plot_data <- filter(full_data,year==input$year)
        
        if(input$xTrans=="log2"){
            xrange <- c(1,max(full_data[,input$xVar],na.rm=T))
            xcenter <- 2^(mean(c(1, max(log2(na.omit(full_data[,input$xVar]))))))
        } else if(input$xTrans=="identity"){
            xrange <- c(0,max(full_data[,input$xVar],na.rm=T))
            xcenter <- mean(xrange)
        }
        
        if(input$yTrans=="log2"){
            yrange <- c(1,max(full_data[,input$yVar],na.rm=T))
            ycenter <- 2^(mean(c(1,max(log2(na.omit(full_data[,input$yVar]))))))
        } else if(input$yTrans=="identity"){
            yrange <- c(0,max(full_data[,input$yVar],na.rm=T))
            ycenter <- mean(yrange)
        }
        
        
        g <- ggplot(plot_data)+
            annotate(geom="text",x=xcenter,y=ycenter,
                     label=input$year,size=50,color="grey90")+
            geom_point(aes_string(x=input$xVar,
                                  y=input$yVar,
                                  size="population",
                                  color="region"),alpha=.4,shape=16)+
            geom_point(data=filter(plot_data,country %in% input$countriesOfInterest),
                       aes_string(x=input$xVar,
                                  y=input$yVar,
                                  size="population",
                                  color="region"),shape=16)+
            scale_size_area(guide=F,max_size=35,limits=c(0,max(full_data$population)))+
            scale_color_discrete(name=element_blank())+
            scale_color_brewer(palette="Set2")
            theme_minimal()
        
        if(input$xDollar){
            g <- g + scale_x_continuous(labels=scales::dollar,
                                        name=input$xLabel,
                                        trans=input$xTrans,
                                        limits=xrange)
        } else{
            g <- g + scale_x_continuous(name=input$xLabel,
                                        trans=input$xTrans,
                                        limits=xrange)
        }
        
        if(input$yDollar){
            g <- g + scale_y_continuous(labels=scales::dollar,
                                        name=input$yLabel,
                                        trans=input$yTrans,
                                        limits=yrange)
        } else{
            g <- g + scale_y_continuous(name=input$Label,
                                        trans=input$yTrans,
                                        limits=yrange)
        }
        
        g+geom_text_repel(data=filter(plot_data,country %in% input$countriesOfInterest),
                          aes_string(x=input$xVar,y=input$yVar,label="country"),size=5)
        
        
    })

})
