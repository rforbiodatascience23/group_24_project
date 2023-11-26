# group_24_project

## Project contributors

Oliver Morell (s204116) Morell1123

André Rosengaard Jørgensen (s183451) whelixw

Antonios Otapasidis (s232996) s232996

Konstantinos Lyroudis (s232994) LyroudisK

Georgios Retsinias (s233079) GeorgiosR

We investigated two studies on comparative RNA-seq of coding RNA on a mouse cancer cell line and 18 human cancer cell lines.

**Mouse data sets**

The two data sets concerning mouse RNA-seq were derived from the study "Mouse melanoma cell line B16-F10 treated with G007-LK"" in which 12 samples were used. What was measured in that study was the effect of different compounds on the RNA-seq profile of coding RNA in the melanoma cell line B16-F10. The compounds that were used were the following: dimethyl sulfoxide (DMSO), WNT3a and GOO7LK

Each of the compound was applied on three samples (triplicates).

The sequencing was performed using Illumina HiSeq 2500 and the quantification of RNA data was performed with kallisto v0.44 using the GRCm38 assembly and TPM (transcripts per million) per gene. Normalization was performed using sleuth v0.29

**Cell line**: B16-F10C

**Compounds treated with:**

|               | DMSO  | G007-LK | WNT3a     | G007-LK + WNT3a |
|---------------|-------|---------|-----------|-----------------|
| Concentration | 0.01% | 1μM     | 0.5 μg/ml | 1μM + 0.5 μg/ml |

DMSO serves as solvent for the drug provided and it is used here as negative control (untreated cells). G007-LK is a tankyrase inhibitor that inhibits WNT signalling, a signalling pathway attenuated in many cancers. WNT-3a is a protein that promotes the tumor-inducing beta-catenin/Tcf pathway and can cause cancer when expressed in particular cell populations.

**Human data sets**

The two data sets concerning human RNA-seq were derived from the study "Human melanoma cell lines treated with G007-LK"". During this experiment 18 human melanoma cell lines derived from skin were treated with the compound GOO7-LK with the purpose of detecting its effect on the RNA-seq profile of the cells.

Three pooled technical replicates from a panel of the 18 human melanoma cell lines were treated with dimethyl sulfoxide (DMSO) or G007-LK for 24 hours.

The RNA sequence was performed using the NextSeq 500 platform and the quantification of RNA data was performed with kallisto v0.44 using the GRCm38 assembly TPM per gene. Normalization was performed using sleuth v0.29

**Cell lines**: A-375, FEMX-I, FEMX-V, LOX-IMVI, MeWo, SK-MEL-28, WM115, WM1341B, WM1366, WM1382, WM239A, WM266.4, WM35, WM451Lu, WM793B, WM852, WM9, WM983B

**Compounds treated with**:

|               | DMSO  | G007-LK |
|---------------|-------|---------|
| Concentration | 0.01% | 1μM     |

The four data sets were retrieved from from EBI-EMBL website (<https://www.ebi.ac.uk/biostudies/arrayexpress/studies>) and uploaded to another repo of Group 24 from where the URLs are provided for data loading. In this way, our team makes sure that the data sets will be available even if changes occur to the original source.

Study on human cell lines Accession Number: E-MTAB-8438

Study on mouse cell line Accession Number: E-MTAB-8101

Waaler, Jo, et al. "Tankyrase Inhibition Sensitizes Melanoma to PD-1 Immune Checkpoint Blockade in Syngeneic Mouse Models." *Communications Biology*, vol. 3, no. 1, 24 Apr. 2020, <https://doi.org/10.1038%2Fs42003-020-0916-2> Accessed 25 Nov. 2023.
