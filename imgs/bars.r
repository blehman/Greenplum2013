#!/usr/bin/env Rscript
library(ggplot2)
library(stringr)
library(gridExtra)

CBPalette<-"Set3"

Z = read.delim("tidysums.csv", sep=",", header=TRUE)
summary(Z)

Z$Pub <- as.character(Z$Pub)
Z$Pub[Z$Pub == "WPCom"] <- "Wordpress"
Z$Pub[Z$Pub == "WPOrg"] <- "Wordpress"
Z$Pub[Z$Pub == "WPComCom"] <- "WP Comments" 
Z$Pub[Z$Pub == "WPOrgCom"] <- "WP Comments" 
Z <- aggregate(Z["Activities"], by=list(Z$Pub, Z$Keyword), sum)
names(Z)[names(Z)=="Group.1"] <- "Publisher"
names(Z)[names(Z)=="Group.2"] <- "Keyword"
summary(Z)

Y <- subset(Z, Keyword != "Total")
summary(Y)
T <- subset(Z, Keyword == "Total")
summary(T)


png(filename = "bars.png", width = 550, height = 700, units = 'px')
  print(
    ggplot(data=Y) +
	geom_bar(aes(Keyword, Activities, color = Keyword, fill=Keyword)) +
    facet_grid( Publisher ~ ., scales="free") + 
    labs(title = "Activities (2012-10-15 thru 2012-11-15)") +
    scale_fill_brewer(palette=CBPalette) +
    scale_color_brewer(palette=CBPalette) +
    theme(
          panel.background = element_rect(fill = "#545454"),
          panel.grid.major = element_line(colour = "#757575"),
          panel.grid.minor = element_line(colour = "#757575")
          )
    )
dev.off()

summary(T)

png(filename = "bars_tot.png", width = 550, height = 300, units = 'px')
  print(
    ggplot(data=Y) +
	geom_bar(aes(Publisher, Activities, color = Keyword, fill=Keyword)) +
    labs(title = "Total Activities\n(2012-10-15 thru 2012-11-15)") +
    scale_fill_brewer(palette=CBPalette) +
    scale_color_brewer(palette=CBPalette) +
    theme(
          panel.background = element_rect(fill = "#545454"),
          panel.grid.major = element_line(colour = "#757575"),
          panel.grid.minor = element_line(colour = "#757575")
          )
    )
dev.off()
CBPalette <- "Spectral"
 
png(filename = "bars_stacked.png", width = 300, height = 400, units = 'px')
  print(
    ggplot(data=T) +
    geom_bar(aes(Keyword, Activities, color = Publisher, fill=Publisher)) +
    labs(title = "Total Activities by Publisher\n(2012-10-15 thru 2012-11-15)") +
    scale_fill_brewer(palette=CBPalette) +
    scale_color_brewer(palette=CBPalette) +
    theme(
          panel.background = element_rect(fill = "#545454"),
          panel.grid.major = element_line(colour = "#757575"),
          panel.grid.minor = element_line(colour = "#757575")
          )
    )
dev.off()



###
#
#
#
###

# Great lookikng in beamer
pdf("bars.pdf")
    ggplot(data=Y) +
    geom_bar(aes(Keyword, Activities, color = Keyword, fill=Keyword)) +
    facet_grid( Publisher ~ ., scales="free") +
    labs(title = "Activities (2012-10-15 thru 2012-11-15)") +
    scale_fill_brewer(palette=CBPalette) +
    scale_color_brewer(palette=CBPalette) +
    theme(
          panel.background = element_rect(fill = "#545454"),
          panel.grid.major = element_line(colour = "#757575"),
          panel.grid.minor = element_line(colour = "#757575")
          )
dev.off()

pdf("bars_tot.pdf")
    ggplot(data=Y) +
    geom_bar(aes(Publisher, Activities, color = Keyword, fill=Keyword)) +
    labs(title = "Total Activities\n(2012-10-15 thru 2012-11-15)") +
    scale_fill_brewer(palette=CBPalette) +
    scale_color_brewer(palette=CBPalette) +
    theme(
          panel.background = element_rect(fill = "#545454"),
          panel.grid.major = element_line(colour = "#757575"),
          panel.grid.minor = element_line(colour = "#757575")
          )
dev.off()

pdf("bars_stacked.pdf")
    ggplot(data=T) +
    geom_bar(aes(Keyword, Activities, color = Publisher, fill=Publisher)) +
    labs(title = "Total Activities by Publisher\n(2012-10-15 thru 2012-11-15)") +
    scale_fill_brewer(palette=CBPalette) +
    scale_color_brewer(palette=CBPalette) +
    theme(
          panel.background = element_rect(fill = "#545454"),
          panel.grid.major = element_line(colour = "#757575"),
          panel.grid.minor = element_line(colour = "#757575")
          )
dev.off()
