%% QUICK START GUIDE
%
% To run your FEA vs Analytical comparison analysis:
%
% STEP 1: Navigate to your MATLAB folder
%   cd 'C:\Users\merrifield.12\OneDrive - The Ohio State University\classes\MECHENG 7751 Advanced Kinematics and Mechanics\project 2\MATLAB'
%
% STEP 2: Run the comparison script
%   run_comparison
%
% That's it! The script will:
%   - Automatically set up all paths
%   - Load your FEA data
%   - Compute PRB analytical predictions
%   - Generate comparison plots
%   - Save results to the 'results' folder
%
% OUTPUT FILES:
%   - results/comparison_analysis.png  (6 comparison plots)
%   - results/comparison_summary.txt   (detailed numerical results)
%
% WHAT WAS FIXED:
%   - Parametric angle coefficient now depends on load ratio (n)
%   - All three test cases (n=0.5, 1.0, 2.0) now use correct coefficients
%   - New comprehensive analysis script with better reporting
%
% FILES UPDATED:
%   - core/parametric_approximation.m  (added new function)
%   - compare_fea_analytical.m         (uses new function)
%   - main_analysis.m                  (uses new function)
%
% FILES CREATED:
%   - run_comparison.m                 (complete analysis - use this!)
%   - test_coefficient.m               (validate the coefficient function)
%   - ANALYSIS_GUIDE.md                (detailed documentation)
%   - QUICKSTART.m                     (this file)
%
% EXPECTED RESULTS:
%   - Deflection error < 1% is good agreement
%   - Check the generated PNG file for visual comparison
%   - Review comparison_summary.txt for detailed error analysis
%
% QUESTIONS?
%   See ANALYSIS_GUIDE.md for detailed explanation of the analysis
