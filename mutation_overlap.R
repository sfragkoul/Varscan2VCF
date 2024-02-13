rm(list = ls())
gc()

library(data.table)
library(stringr)


scenarioA = fread("simulated_data_golden.vcf")
scenarioB = fread("simulated_data_GATK_variants.vcf")


scenarioA$scenario = "A"
scenarioB$scenario = "B"
scenarioB <- scenarioB[,-c(9,10)]

x = rbind(scenarioA, scenarioB)


rm(scenarioA, scenarioB)


y = x[, c("#CHROM", "POS", "ID","REF", "ALT", "QUAL", "FILTER", "INFO","scenario"), with = FALSE]



y$mut = paste( y$CHROM, y$POS, y$REF, y$ALT, sep = ":")


z = y[, by = mut, .(
    scenarios = paste(scenario, collapse = "+")
)]

z = z[order(z$scenarios), ]

fwrite(
    z, "mutation-overlaps.csv",
    row.names = FALSE, quote = TRUE, sep = ","
)


library(ggvenn)
library(ggplot2)

y = split(y, y$scenario)


y = list(
    'Golden ' = y$A$mut,
    'Mutect2' = y$B$mut
)

ggvenn(
    y,
    fill_color = c("#0073C2FF", "#EFC000FF")
)

ggsave(
    filename = "mutation-overlaps.pdf",
    width = 6, height = 6, units = "in"
)
