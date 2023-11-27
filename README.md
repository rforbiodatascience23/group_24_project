
# group_24_project

## Project contributors

Oliver Morell (s204116) Morell1123

André Rosengaard Jørgensen (s183451) whelixw

Antonios Otapasidis (s232996) s232996

Konstantinos Lyroudis (s232994) LyroudisK

Georgios Retsinias (s233079) GeorgiosR

We investigated two studies on comparative RNA-seq of coding RNA on a
mouse cancer cell line and 18 human cancer cell lines.

## Packages to install
-   install.packages("quarto")


-   install.packages("tidyverse")

-   install.packages("viridis")

-   install.packages("ggridges")

-   install.packages("VennDiagram")

-   install.packages("broom")

-   install.packages("ggrepel")

-   install.packages("RColorBrewer")

-   install.packages("cowplot")

-   install.packages("scales")

**Mouse data sets**

In a study focusing on mouse melanoma cell line B16-F10, 12 samples were
examined to understand the impact of different compounds---dimethyl
sulfoxide (DMSO), WNT3a, and G007-LK on the RNA-seq profile of coding
RNA. Each compound was applied in triplicates, and the RNA sequencing,
performed via Illumina HiSeq 2500. The cell line B16-F10C was treated
with specific concentrations of the compounds, serving as negative
controls or actively targeting pathways related to cancer.

**Cell line**: B16-F10C

**Compounds treated with:**

|               | DMSO  | G007-LK | WNT3a     | G007-LK + WNT3a |
|---------------|-------|---------|-----------|-----------------|
| Concentration | 0.01% | 1μM     | 0.5 μg/ml | 1μM + 0.5 μg/ml |

**Human data sets**

The two data sets concerning human RNA-seq were derived from the study
"Human melanoma cell lines treated with G007-LK"". During this
experiment 18 human melanoma cell lines derived from skin were treated
with the compound GOO7-LK with the purpose of detecting its effect on
the RNA-seq profile of the cells. Three pooled technical replicates from
a panel of the 18 human melanoma cell lines were treated with dimethyl
sulfoxide (DMSO) or G007-LK for 24 hours

**Cell lines**: A-375, FEMX-I, FEMX-V, LOX-IMVI, MeWo, SK-MEL-28, WM115,
WM1341B, WM1366, WM1382, WM239A, WM266.4, WM35, WM451Lu, WM793B, WM852,
WM9, WM983B

**Compounds treated with**:

|               | DMSO  | G007-LK |
|---------------|-------|---------|
| Concentration | 0.01% | 1μM     |

The four data sets were retrieved from from EBI-EMBL website
(<https://www.ebi.ac.uk/biostudies/arrayexpress/studies>) and uploaded
to another repo of Group 24 from where the URLs are provided for data
loading. In this way, our team makes sure that the data sets will be
available even if changes occur to the original source.

Study on human cell lines Accession Number: E-MTAB-8438

Study on mouse cell line Accession Number: E-MTAB-8101

Waaler, Jo, et al. "Tankyrase Inhibition Sensitizes Melanoma to PD-1
Immune Checkpoint Blockade in Syngeneic Mouse Models." *Communications
Biology*, vol. 3, no. 1, 24 Apr. 2020,
<https://doi.org/10.1038%2Fs42003-020-0916-2> Accessed 25 Nov. 2023.
