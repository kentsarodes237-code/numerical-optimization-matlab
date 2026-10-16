# Numerical Optimization in MATLAB

MATLAB implementations and numerical experiments for classical unconstrained optimization methods.

## Topics covered

- Steepest descent
- Wolfe line search
- Gradient descent with adaptive step size
- Local Newton method with Wolfe step selection
- Gradient vs. Newton comparisons
- Gauss–Newton for nonlinear least-squares fitting

## Repository structure

```text
numerical-optimization-matlab/
├── src/
│   ├── simulators/
│   └── optimization_methods/
├── examples/
│   ├── steepest_descent/
│   ├── wolfe_line_search/
│   ├── newton/
│   ├── gradient_vs_newton/
│   └── gauss_newton/
├── results/
│   └── figures/
├── docs/
├── README.md
├── LICENSE
├── CITATION.cff
├── CORRECTIONS_APPLIQUEES.md
└── .gitignore
```

## Main implementations

The repository includes MATLAB code for:

- `pfd.m` — steepest descent
- `wolfe.m` — Wolfe line search
- `gradrl.m`, `gradrl_f1.m`, `gradrl_gen.m` — gradient methods with line search
- `newton_loc.m` — local Newton method using Wolfe step selection
- `calculeh.m`, `calculeDh.m` — residual and Jacobian evaluation for Gauss–Newton
- `interpogaussienne.m` — Gaussian fitting experiment

## Software

MATLAB

## Academic context

This repository comes from a Scientific Computing practical project on numerical optimization.

## Author

Kentsa Melatchi Rodes


## Report and numerical figures

The complete project report is available at:

```text
docs/optimization_report.pdf
```

The LaTeX source and bibliography are available in:

```text
docs/source_tex/
```

The numerical figures used in the report are stored in:

```text
results/figures/
```

These include the steepest-descent experiments, Wolfe-condition plots,
gradient/Newton comparisons, Jacobian validation and Gauss–Newton fitting results.

> Note: the report is preserved as the academic report produced for the project.
> The technical corrections made before GitHub publication are documented separately
> in `CORRECTIONS_APPLIQUEES.md`.
