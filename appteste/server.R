require(data.table)
require(dplyr)
require(tidyr)


shinyServer(function(input, output) {
        dados <- fread('TP.csv',sep=';')
        head(dados)
        tdia <- group_by(dados,mes,dia,dsem) %>%
                summarise_each(funs(sum)) %>% 
                select(-hora) 
        mm = c('janeiro','fevereiro','março','abril','maio','junho','julho',
               'agosto','setembro','outubro','novembro','dezembro') 

  output$barPlot <- renderPlot({
          barplot(filter(tdia,mes==input$n)$ptot,
                  col='darkgreen',
                  xlab=paste('Dias do mês de',mm[as.numeric(input$n)],'de 2014'),
                  names.arg=filter(tdia,mes==input$n)$dia,
                  ylab='número de passageiros',
                  ylim=c(0,1400000)
                  )
  })
  
})
