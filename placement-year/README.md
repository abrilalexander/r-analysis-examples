# Placement year: mixed models of reproductive tissue investment

Statistical analysis for:

Alexander, A., Iglesias-Carrasco, M., Lozano, M. & Garcia-Gonzalez, F. (2025). *Monogamy removes constraints on reproductive tissue investment imposed by intense sexual selection.* Scientific Reports 15:19646. https://doi.org/10.1038/s41598-025-00180-6 (open access)

I carried out the statistical analysis and wrote the first draft during a placement year at Doñana Biological Station (CSIC), Seville.

## Background

The study used experimental evolution in the seed beetle *Callosobruchus maculatus* with a 2x2 factorial design: sexual selection intensity (polygamy = intense vs monogamy = relaxed sexual selection) crossed with metapopulation structure (absent vs present), with four replicate lines per combination (16 lines in total). After 129 generations, individuals from each line were weighed and dissected to measure **relative reproductive tissue investment** (dried reproductive tissue weight / wet body weight) in both sexes.

Main result: males and females from monogamous lines invested more in reproductive tissue than those from polygamous lines, with no effect of metapopulation structure and no interaction.

## Data

The collected data are in the `final_proc_data.txt` file in the placement-year folder and in the paper's supplementary material, with one row per individual:

| Column | Description |
|---|---|
| `SEX` | F / M (models are fitted to each sex separately, as in the paper) |
| `MATING_SYSTEM` | Polygamy or monogamy evolutionary history |
| `POP_STRUCTURE` | Metapopulation structure absent or present |
| `LINE_ID` | Replicate selection line (random effect) |
| `WET_WEIGHT` | Total wet body weight, measured the day after emergence [units] |
| `REP_WEIGHT` | Dry weight of dissected reproductive tissue [units] |

## What `LMMAnalysis.R` does

1. Loads the data, converts grouping variables to factors and splits it by sex.
2. Mean-centres wet weight within each sex (for the covariate models).
3. Fits two exploratory models on both sexes together: body weight (`WET_WEIGHT ~ SEX * MATING_SYSTEM`) and relative reproductive investment (`REP_WEIGHT / WET_WEIGHT ~ SEX * MATING_SYSTEM`), each with `(1 | LINE_ID)`.
4. Fits the sex-specific models, each followed by a `DHARMa` simulated-residual check:
   - **1A (final model, Table 1 of the paper):** `REP_WEIGHT / WET_WEIGHT ~ MATING_SYSTEM * POP_STRUCTURE + (1 | LINE_ID)`
   - 1B: absolute reproductive weight with centred wet weight as a covariate [check: Table S3]
   - 2: absolute reproductive weight, no covariate
   - 3: wet body weight [check: Table S4]
5. Tests fixed effects with Type II Wald chi-square tests (`car::Anova`).
6. Estimates marginal means and Cohen's d effect sizes for mating system from the final models (`emmeans`).
7. Repeats the male models without one influential data point.

## Packages

R 4.3.2, `lme4` 1.1.35.1, `car` 3.1.2, `DHARMa` 0.4.6, `emmeans` 1.10.0

(Versions as reported in the paper. Run `sessionInfo()` for the full list.)
