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
output_file <- paste0(prefix, "_coverage.pdf")

# Read coverage file
cov <- read.csv(
  file = tsv_file,
  header = FALSE,
  sep = "\t"
) %>%
  rename(
    Position = V2,
    Coverage = V3
  ) %>%
  mutate(
    Position = as.numeric(as.character(Position)),
    Coverage = as.numeric(as.character(Coverage))
  ) %>%
  arrange(Position)

# Generate coverage plot
p <- ggplot(cov, aes(x = Position, y = Coverage)) +
  geom_line(linewidth = 0.4) +
  scale_x_continuous(
    name = "Genome position",
    labels = scales::label_comma()
  ) +
  scale_y_continuous(
    name = "Coverage depth",
    labels = scales::label_comma()
  ) +
  theme_bw() +
  labs(
    title = paste("Coverage:", basename(tsv_file))
  ) +
  theme(
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14)
  )

# Save plot
ggsave(
  filename = output_file,
  plot = p,
  device = "pdf",
  width = 12,
  height = 5,
  dpi = 300
)
