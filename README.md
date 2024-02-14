### Summary
This is a repo with scripts to convert the output of VarScan to the VCF format.

To install VarScan follow the intructions [here](https://anaconda.org/bioconda/varscan) and to execute it follow [these](https://dkoboldt.github.io/varscan/using-varscan.html) intructions.

To excute this script just run `python vscan_pileup2cns2vcf.py test_file.tsv > test_file.vcf`


***Please note that the vcf file contains all positions, even those without variants, so it needs some cleaning afterwards.***
