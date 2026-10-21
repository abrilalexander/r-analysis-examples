# Vineyard soil: dissertation analysis

Statistical analysis for my undergraduate dissertation (BSc Ecology & Conservation, Lancaster University, 2025): "The Effects of Cover Crops and Tillage on the Soil Properties of a Mediterranean Vineyard: Implications for Carbon and Nitrogen Cycling"

## Background

The effect of 3 management treatments (tillage on bare soil; commercial cover crop; spontaneous cover crop) on a Mediterranean vineyard's soil properties was measured at 2 sampling depths (0-12cm; 13-25cm) (2x3 factorial design). 

## Data

The dataset `Vineyard_Data.txt` is not included in this repository. Permission to share the underlying data publicly is being clarified with the relevant project stakeholders. The analysis script expects one row per sample, with the columns described below:

| Column | Description |
|---|---|
| `Plot_N` | Plot ID (random effect) |
| `Treatment` | Management treatment |
| `Depth` | Soil depth |
| `pH` | Soil pH |
| `MC` | Moisture content |
| `OM` | Organic matter content (%) |
| `N`, `C`, `C.N` | Nitrogen (%), carbon (%), C:N ratio |
| `BasalResp` | Basal respiration rate (ul CO2 g-1 h-1) |
| `RootBiomass` | Dry root biomass (g) |

## What `Vineyard.R` does

For each response variable (pH, moisture, organic matter, N, C, C:N, basal respiration, root biomass):

1. Fits a linear mixed model (`Treatment * Depth + (1 | Plot_N)`) and a plain linear model.
2. Compares them with a likelihood ratio test to decide whether the plot random effect is needed.
3. Checks the chosen model's residuals with `DHARMa`.
4. Runs omnibus tests and pairwise comparisons with `emmeans`, and effect sizes where relevant.

Root biomass failed the residual checks, so it is analysed with Kruskal-Wallis tests, Dunn post-hoc tests and `rstatix::kruskal_effsize` instead.

The final section builds a correlation matrix and `ggplot2`/`ggpubr` scatterplots of key relationships (e.g. organic matter vs pH, basal respiration vs nitrogen), with point shapes by treatment or depth.

## Packages

`lme4` 1.1-35.1, `car` 3.1-2, `DHARMa` 0.4.6, `emmeans` 1.10.0, `ggplot2` 3.5.2, `ggpubr` 0.6.0, `dunn.test` 1.3.6, `Hmisc` 5.1-2, `rstatix` 0.7.2

## Notes

- Where the likelihood ratio test returns p = 1, the random-effect variance was estimated at (or near) zero, so the simpler linear model was used.
