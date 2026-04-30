# FEA vs PRB Analytical Model Comparison - User Guide

## Overview
This MATLAB analysis compares your ABAQUS FEA results with the **Pseudo-Rigid-Body (PRB) parametric deflection approximation** model from Howell & Midha (1995).

**Reference Paper:**
> L. L. Howell and A. Midha, "Parametric Deflection Approximations for End-Loaded, Large-Deflection Beams in Compliant Mechanisms," *ASME J. Mech. Des.*, vol. 117, no. 1, pp. 156–165, 1995.

## What I Fixed

### 1. **Parametric Angle Coefficient** (Critical Issue)
**Problem:** The code was using a hardcoded coefficient value (1.23850) for the parametric angle coefficient c_e, which only applies to the n=0 (purely vertical load) case.

**Solution:** Created a new function `compute_parametric_angle_coefficient(n)` that interpolates the correct coefficient based on the load ratio n, using Table 1 values from the paper:
- n=0.0:  c_e = 1.2385
- n=0.5:  c_e = 1.2430
- n=1.0:  c_e = 1.2467
- n=1.5:  c_e = 1.2492
- n=2.0:  c_e = 1.2511
- n=3.0:  c_e = 1.2534
- n=5.0:  c_e = 1.2557
- n=10.0: c_e = 1.2578

This function is now used in the comparison analysis to correctly account for the load ratio-dependent coefficient.

### 2. **Updated Files**
- **`core/parametric_approximation.m`**: Added `compute_parametric_angle_coefficient(n)` function
- **`compare_fea_analytical.m`**: Updated to use the proper coefficient for each n case
- **`main_analysis.m`**: Updated to use the proper coefficient
- **`run_comparison.m`**: NEW comprehensive script with full setup, analysis, and reporting

### 3. **New Scripts Created**
- **`run_comparison.m`**: Complete analysis script with proper path setup and report generation
- **`test_coefficient.m`**: Validation script to verify the coefficient function works correctly

## How to Run the Analysis

### Option 1: Run the Main Comparison Script (Recommended)

```matlab
cd 'path\to\project 2\MATLAB'
run_comparison
```

This script will:
1. Set up all necessary paths automatically
2. Load FEA data from ABAQUS results
3. Compute PRB analytical predictions
4. Perform error analysis
5. Generate comparison plots
6. Save results to the `results/` folder

**Expected Output:**
- Command window: Detailed analysis summary with error statistics
- `results/comparison_analysis.png`: 6-panel comparison figure
- `results/comparison_summary.txt`: Text file with all results

### Option 2: Run Individual Components

```matlab
% Add path
addpath('core');

% Test the parametric coefficient function
test_coefficient

% Run original comparison (if all functions work)
compare_fea_analytical
```

## FEA Test Cases

Your FEA model includes three load cases (from your ABAQUS results):

| Case | Load Ratio n | PH (N) | PV (N) | U1 (mm) | U2 (mm) | UR3 (rad) |
|------|--------------|--------|--------|---------|---------|-----------|
| 1    | 0.5          | 0.96   | 1.92   | -142.55 | 167.59  | 1.71474   |
| 2    | 1.0          | 1.92   | 1.92   | -193.70 | 167.38  | 2.08060   |
| 3    | 2.0          | 3.83   | 1.92   | -257.77 | 145.10  | 2.52551   |

**Note:** These are extracted from Node 41 (beam tip) from the FLIPPED load case results.

## Understanding the Results

### Deflection Error
The script computes the error between FEA and PRB predictions as:

$$\text{Error\%} = \frac{|\text{Deflection}_{\text{PRB}} - \text{Deflection}_{\text{FEA}}|}{\text{Deflection}_{\text{FEA}}} \times 100$$

**Target:** According to the Howell & Midha paper, the PRB model aims to maintain error < 0.5% across the deflection range.

### Key Parameters
- **γ (Gamma)**: Characteristic radius factor (affects the equivalent rigid body radius)
- **c_e**: Parametric angle coefficient (depends on load ratio n)
- **θ_o_max**: Maximum deflection angle that can be parameterized using the PRB model

## File Structure

```
MATLAB/
├── core/
│   ├── elliptic_integrals.m           # Exact solution using elliptic integrals
│   ├── parametric_approximation.m     # PRB parametric model (UPDATED)
│   └── load_deflection.m              # Load-deflection relationships
├── validation/
│   └── test_analytical_model.m        # Validation tests
├── data/
│   └── (output data files)
├── results/
│   ├── comparison_analysis.png        # Generated comparison plots
│   └── comparison_summary.txt         # Text report
├── run_comparison.m                   # Main analysis script (NEW)
├── test_coefficient.m                 # Coefficient validation (NEW)
├── compare_fea_analytical.m           # Original comparison (UPDATED)
├── main_analysis.m                    # Main analysis (UPDATED)
└── README.md                          # This file
```

## Troubleshooting

### Issue: "Undefined function 'compute_parametric_angle_coefficient'"
**Solution:** Make sure the path includes the `core` folder. The `run_comparison.m` script does this automatically.

### Issue: "Cannot find FEA data"
**Solution:** The FEA data is hardcoded in the comparison script. If you have different values from your ABAQUS reports, update the U1, U2, and UR3 values in the script:

```matlab
fea_cases(1).U1 = your_value;  % mm
fea_cases(1).U2 = your_value;  % mm
fea_cases(1).UR3 = your_value; % rad
```

### Issue: "Cannot create results folder"
**Solution:** Manually create a `results/` folder in the MATLAB directory, or run the script from a location where you have write permissions.

## Verifying Your Results

After running the analysis, check:

1. **Deflection Error**: Is it < 0.5%? If so, the PRB model matches your FEA well.
2. **Displacement Errors**: Small errors in horizontal (a) and vertical (b) directions indicate good agreement.
3. **Plots**: Do the deflection paths (FEA circles vs PRB squares) align closely?

## Next Steps

1. **Validate the Comparison**: Run `run_comparison` and check the results
2. **Interpret Results**: Review the 6 comparison plots to understand model behavior
3. **Document Findings**: Use the generated plots and summary for your project report
4. **Iterate if Needed**: If errors are large, verify:
   - FEA data extraction (Node 41 values correct?)
   - Material properties (E, ν, dimensions correct?)
   - Load definitions (n = PH/PV computed correctly?)

## Technical Notes

### Normalization
The PRB model uses normalized parameters:
- **n = PH/PV**: Load ratio (horizontal to vertical)
- **θ_o**: Beam end angular deflection
- **a, b**: Horizontal and vertical displacements

### Parametrization Relationship
The key relationship is:
$$\theta_{prb} = \frac{\theta_o}{c_e}$$

where θ_prb is the pseudo-rigid-body angle and c_e is the load-ratio-dependent coefficient.

### Deflection Computation
PRB deflections are computed using:
$$a = L \cdot \gamma \cdot (1 - \cos(\theta_{prb}))$$
$$b = L \cdot \gamma \cdot \sin(\theta_{prb})$$

## Questions or Issues?

If you encounter any problems or need to customize the analysis:
1. Check the MATLAB command window for error messages
2. Verify all function files exist in the `core/` folder
3. Ensure the FEA data values match your ABAQUS results
4. Review the paper's equations if results seem unexpected

---

**Last Updated:** April 2025  
**Analysis Scope:** FEA model comparison with Howell & Midha (1995) PRB parametric approximation  
**Load Cases:** n = 0.5, 1.0, 2.0
