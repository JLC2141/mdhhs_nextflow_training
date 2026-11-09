#!/usr/bin/env Rscript

library(tidyverse)

# Parse command-line arguments
args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 2) {
  stop("Usage: Rscript coverage_plot.R <coverage.tsv> <output_prefix>")
}

tsv_file <- args[1]
prefix <- args[2]

# Output filename
output_file <- paste0(prefix, "_coverage.png")

#Read in coverage file
cov <- read.csv(
  file = tsv_file,
  header = FALSE,
  sep = "\t"
) %>%
  rename(
    Position = V2,
    Coverage = V3
  )

# Generate coverage plot
p <- ggplot(cov, aes(x = Position, y = Coverage)) +
  geom_line() +
  theme_bw() +
  labs(
    title = paste("Coverage:", basename(tsv_file)),
    x = "Genome position",
    y = "Coverage depth"
  )

# Save plot
ggsave(
  filename = output_file,
  plot = p,
  device = "png",
  width = 12,
  height = 5,
  dpi = 300
)
