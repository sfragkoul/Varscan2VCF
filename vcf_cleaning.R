
rm(list = ls())
gc()

library(vcfR)
library(data.table)

somatic_vcf <- read.vcfR( paste0("test_file.vcf"), 
                          verbose = FALSE )

s0 = vcfR::getFIX(somatic_vcf) |> as.data.frame() |> setDT()
#s1 = extract_gt_tidy(somatic_vcf) |> setDT()
s2 = extract_info_tidy(somatic_vcf) |> setDT()
s2 = s2[,c( "DP", "Pvalue", "AF" )]

s0 = s0[which(s2$AF>0.0)]
s2 = s2[which(s2$AF>0.0)]
somatic = cbind(s0, s2)
