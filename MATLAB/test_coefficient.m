%% Quick Validation - Check if parametric angle coefficient is correct
% Tests the new compute_parametric_angle_coefficient function

clear all; close all; clc;

% Add path
addpath('core');

fprintf('Testing parametric angle coefficient function:\n');
fprintf('===============================================\n\n');

% Test values from Table 1
test_n_values = [0.0, 0.5, 1.0, 1.5, 2.0, 3.0, 5.0, 10.0];
expected_c_e = [1.2385, 1.2430, 1.2467, 1.2492, 1.2511, 1.2534, 1.2557, 1.2578];

fprintf('n value  | Expected c_e | Computed c_e | Error %%\n');
fprintf('---------------------------------------------------------\n');

for i = 1:length(test_n_values)
    n = test_n_values(i);
    expected = expected_c_e(i);
    
    try
        computed = compute_parametric_angle_coefficient(n);
        error_pct = abs(computed - expected) / expected * 100;
        
        fprintf('%8.1f | %12.6f | %12.6f | %7.2f\n', n, expected, computed, error_pct);
    catch ME
        fprintf('%8.1f | %12.6f | ERROR: %s\n', n, expected, ME.message);
    end
end

fprintf('\n✓ Test complete\n');
