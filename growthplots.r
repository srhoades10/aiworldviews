

library(ggplot2)
library(readr)
library(reshape2)
library(devtools)
library(cowplot)
devtools::install_github('Mikata-Project/ggthemr')
library(ggthemr)

ggthemr('fresh')

df <- read_csv("growths.csv")
df$variable[df$variable == 'half'] <- "0.5%"
df$variable[df$variable == 'four'] <- "4%"
df$variable[df$variable == 'six'] <- "6%"
dfSub <- df[df$variable != "6%", ]
p <- ggplot(df, aes(x = year, y = value, color = variable))+ 
        geom_line(size = 1.5) +
        xlab("") +
        xlab("Year") +
        theme(axis.text.x = element_text(size=12),
        axis.title.x = element_text(size=13, face="bold"),
        legend.position='top',
        legend.title = element_text(size=13, face='bold'),
        axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.y = element_blank(),
        legend.text = element_text(size=12)) +
        labs(color="")

p2 <- ggplot(dfSub, aes(x = year, y = value, color = variable))+ 
        geom_line(size = 1.5) +
        xlab("") +
        xlab("Year") +
        theme(axis.text.x = element_text(size=12),
        axis.title.x = element_text(size=13, face="bold"),
        legend.position='top',
        legend.title = element_text(size=13, face='bold'),
        axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.y = element_blank(),
        legend.text = element_text(size=12)) +
        labs(color="GWP Annual Growth Rate")

pC <- plot_grid(p2, p, nrow = 1)
ggplot2::ggsave(pC, filename = "images/growths.png", width=11, height=5, dpi=300)
