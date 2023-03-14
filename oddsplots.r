library(ggplot2)
library(readr)
library(reshape2)
library(devtools)
library(cowplot)
devtools::install_github('Mikata-Project/ggthemr')
library(ggthemr)

ggthemr('fresh')

df <- read_csv("odds.csv")
med <- summary(df$odds)['Median']
qrt1 <- quantile(df$odds, probs = 0.25)
qrt3 <- quantile(df$odds, probs = 0.75)

p <- ggplot(df, aes(x = odds))+ 
        geom_histogram(binwidth=0.01, alpha=0.25) +
        xlab("") +
        xlab("Odds (%)") +
        geom_vline(xintercept = med, color='red', alpha=0.75, size = 1.5) +
        geom_vline(xintercept = qrt1, color='red', size = 1, alpha=0.5) +
        geom_vline(xintercept = qrt3, size = 1, alpha=0.5, color='red') +
        scale_x_continuous(breaks=c(0, 0.1, 0.2, 0.3, 0.4, 0.5), labels=c("0", "10", "20", "30", "40", "50"), expand=c(0,0)) +
        scale_y_continuous(expand=c(0,0)) +
        theme(
                axis.text.x = element_text(size=15),
                axis.title.x = element_text(size=15, face="bold"),
                legend.position='top',
                axis.text.y = element_blank(),
                axis.title.y = element_blank(),
                axis.ticks.y = element_blank()) +
        labs(color="")

pA <- p +
        annotate("text", x = qrt1, y = 6700, size=5.5, angle=90, vjust=-1.,
                label = paste0("25th Percentile: ", round(qrt1*100, 2), "%")) +
        annotate("text", x = med, y = 7000, size=5.5, angle=90, vjust=-1.,
                label = paste0("Median: ", round(med*100, 2), "%")) +
        annotate("text", x = qrt3, y = 6700, size=5.5, angle=90, vjust=-1.,
                label = paste0("75th Percentile: ", round(qrt3*100, 2), "%"))
ggplot2::ggsave(pA, filename = "images/odds.png", width=8, height=5, dpi=300)

