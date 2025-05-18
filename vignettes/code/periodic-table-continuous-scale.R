# https://aosmith.rbind.io/2018/08/20/automating-exploratory-plots
periodic_plot_continuous <- function(pdata = periodicdata, ptitle = "Periodic Table of the Elements", psubtitle = "Created with the periodicdata package", plegendtitle = "") {
   # Rather than having this function accept individual columns (Group, Period, Values, etc.)
   # it is smarter to pass the entire tibble because when plotting we may want
   # to not only limit the dataset by properties (columns) but also filter rows (elements),
   # for example to plot only the p-block, etc.
## constants
symbol.voffset <- 0
name.voffset   <- 0.12
# positive number offsets to the north
number.voffset <- 0.28
scale.x.offsets <- c(-1.2, 0.8)
scale.y.offsets <- c(1, -1.5)
# ggplot
p <- ggplot() +
   ### PLOT DIMENSIONS
   scale_x_continuous(
      breaks = seq(min(pdata$Group), max(pdata$Group)),
      limits = c(min(pdata$Group) + scale.x.offsets[1], max(pdata$Group) + scale.x.offsets[2]),
      expand = c(0, 0)) +
   scale_y_continuous(
      trans = "reverse",
      breaks = seq(min(pdata$Period), max(pdata$Period)),
      limits = c(max(pdata$Period) + scale.y.offsets[1], min(pdata$Period) + scale.y.offsets[2]),
      expand = c(0, 0)) +
   ### ELEMENTS
   # square boxes for all elements
   geom_point(
      data = pdata,
      # shape 22 both fill and colour
      # shape 15 colour only (is always filled)
      # shape 0 colour only (is always empty)
      shape = 15,
      # size has been manually adjusted based on fig.width, and then fig.height was adjusted
      # adjusted to yield a thin white line between each element's box
      # going to even smaller size causes a too-wide split between group 9 and 10, better
      # to slightly increase fig height instead
      size = 12.24,
      aes(y = Period, x = Group, colour = VALUE)) +
   # element symbol
   geom_text(
      data = pdata,
      size = 3, fontface = "bold",
      # because we fill legibility gets poor if text is black
      colour = "white",
      aes(label = Symbol, y = Period - symbol.voffset, x = Group)) +
   # atomic number
   geom_text(
      data = pdata,
      size = 1.8, colour = "white",
      aes(label = Atomic_Number, y = Period - number.voffset, x = Group)) +
   ### LEGEND COLOUR
   scale_colour_continuous(
      low = "#56B1F7", high = "#132B43",
      # colour if value is NA
      na.value = "grey70") +
   ### LABELS
   # period labels # hard-coded x coordinate
   geom_text(
      # to avoid multiples in the data limit to a single group (any group that contains all periods)
      data = pdata %>% filter(Period <= 7) %>% filter(Group == 1),
      size = 1.7, colour = "black", x = 0.30,
      aes(label = .data$Period, y = .data$Period)) +
   # group labels # hard-coded x,y coordinates
   geom_text(
      data = data.frame(
         y = c(0.32, 1.32, rep(3.32, 10), rep(1.32, 5), 0.32),
         x = seq(1, 18)),
      size = 1.7, colour = "black",
      aes(label = x, x = x, y = y)) +
   labs(
      title = ptitle,
      subtitle = psubtitle,
      colour = plegendtitle
   ) +
   theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "white"),
      plot.margin = unit(c(0, 0, -0.85, -0.85), "line"),
      axis.title = element_blank(),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      # title # https://r-charts.com/ggplot2/titles
      plot.title = element_text(
         face = "bold", size = rel(1.15),
         # shift ggtitle into the plot area itself, roughly "top center"
         # ideally without affecting the y scale axis extent but unfortunately it
         # seems the mere existence of plot.title adds some y extent
         # in any case, title looks better slightly down-shifted
         hjust = 0.5, vjust = -2,
         margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")
      ),
      # subtitle
      plot.subtitle = element_text(
         size = rel(0.85), hjust = 0.5, vjust = -4,
         # set margins to zero to affect as little as possible the boxes
         # https://ggplot2.tidyverse.org/reference/element.html
         margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")),
      # legend should be centered over the transition metal block
      # with its top edge (not counting legend title) in line with top of period 2
      # coordinates a result of trial-and-error and eye-balling it
      legend.position = c(0.41, 0.88),
      legend.justification = c(0.5, 1),
      legend.direction = "horizontal",
      # make the legend colourbar a little wider
      legend.key.width = unit(2.5, "line"),
      legend.title.position = "top",
      # https://wilkelab.org/ggtext/reference/element_markdown.html
      legend.title = element_markdown(
         # shift the legend title a little closer to the legend box
         margin = margin(t = 0, r = 0, b = 2, l = 0, unit = "pt"),
         size = rel(0.75)),
      legend.background = element_rect(fill = "transparent")
   )
return(p)
}
