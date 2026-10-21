# R analysis examples

Selected R scripts from my ecology research, shared as examples of my statistical workflow. I'm Abril, a BSc Ecology & Conservation graduate (Lancaster University). I taught myself R during a placement year at Doñana Biological Station (CSIC) in Seville and have used it since for published research, my dissertation and lab research assistant work.

The scripts are functional and annotated rather than polished. They are the analyses as I actually ran them, tidied so they can be read and followed.

## Projects

| Folder | Question | Methods | Status |
|---|---|---|---|
| [`placement-year-lmm/`](placement-year-lmm/) | How do sexual selection intensity  and metapopulation structure shape reproductive tissue investment in male and female seed beetles (*Callosobruchus maculatus*)? | Linear mixed models (`lme4`), residual diagnostics (`DHARMa`), marginal means and effect sizes (`emmeans`) | First-author paper, [*Scientific Reports* (2025)](https://doi.org/10.1038/s41598-025-00180-6) |
| [`vineyard-soil/`](vineyard-soil/) | How do cover crops and tillage affect the soil properties of a Meditteranean vineyard? | LMM vs LM comparison with likelihood ratio tests, non-parametric fallback (Kruskal-Wallis, Dunn), correlations, `ggplot2` figures | Undergraduate dissertation |

## What the scripts show

- Fitting linear mixed models with random effects, and testing whether the random effect is needed
- Checking model assumptions with simulation-based residuals (`DHARMa`)
- Post-hoc comparisons and effect sizes with `emmeans`
- Switching to non-parametric tests when assumptions fail
- Producing publication-style figures with `ggplot2`

## Running the scripts

1. Open R (or RStudio) with the project folder as your working directory (in RStudio: open the folder as a project).
2. Install the packages listed in each project's README.
3. Place the data file in the same folder (see each README for data availability).

Developed with R version 2023.12.0+369. Package versions are listed in each project README.

## Other work

Further examples, including data visualisation and segmented regression from plant physiology work, are part of ongoing manuscripts and can be shared on request once cleared with my collaborators.

## Contact
abrilalexander1@outlook.com  ·
https://www.linkedin.com/in/abril-alexander-416a7820b/
