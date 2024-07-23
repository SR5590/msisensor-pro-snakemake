import os
import pandas as pd

rule all:
    input:
        "tumor_blood_dis",
        "tumor_blood_germline",
        "tumor_blood_somatic",
        "tumor_blood"

rule msisensor_scan:   #use for microsatellite information
     input:
         "human_g1k_v37.fasta"
     output:
         "reference.site"
     threads:
         1
     shell:
         """
         msisensor-pro scan -d {input} -o {output}
         """

rule msisensor_msi:  #msi using the tumor-normal
    input:
        normal = "buffy_coat_xxxx_merged.mdup.bam",
        tumor = "tumor_xxxxx_merged.mdup.bam",
        microsat = "../../1000_reference_genome_hg37/reference.site"
    output:
        "tumor_blood_dis",
        "tumor_blood_germline",
        "tumor_blood_somatic",
        "tumor_blood"
    threads:
        1
    shell:
        """
        msisensor-pro msi -d {input.microsat} -n {input.normal} -t {input.tumor} -o tumor_blood
        """



