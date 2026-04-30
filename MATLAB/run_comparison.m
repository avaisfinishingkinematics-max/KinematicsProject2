%% FEA vs ANALYTICAL COMPARISON - COMPLETE ANALYSIS
% Comprehensive comparison of ABAQUS FEA results with Howell & Midha PRB analytical model
%
% This script:
% 1. Sets up the MATLAB path for all core functions
% 2. Loads FEA data from ABAQUS results
% 3. Computes PRB analytical predictions
% 4. Performs error analysis
% 5. Generates comparison plots and reports

clear all; close all; clc;

%% SETUP
% Add core functions to MATLAB path
matlab_root = fileparts(mfilename('fullpath'));
core_path = fullfile(matlab_root, 'core');
data_path = fullfile(matlab_root, 'data');
results_path = fullfile(matlab_root, 'results');

addpath(matlab_root, core_path);

% Create results directory if it doesn't exist
if ~isfolder(results_path)
    mkdir(results_path);
end

fprintf('========================================================\n');
fprintf('FEA vs PRB ANALYTICAL MODEL COMPARISON\n');
fprintf('Howell & Midha (1995) Parametric Deflection Approximation\n');
fprintf('========================================================\n\n');

%% MODEL PARAMETERS
L = 200e-3;                          % Beam length in meters (200 mm)
E = 1.84e9;                          % Young's modulus (Pa) - Polypropylene: 1.84 GPa
nu = 0.46;                           % Poisson's ratio
width = 10e-3;                       % Width (m)
thickness = 2e-3;                    % Thickness (m)

% Calculate flexural rigidity
I = (width * thickness^3) / 12;      % Second moment of inertia (m⁴)
EI = E * I;                          % Flexural rigidity (N·m²)

fprintf('BEAM PROPERTIES:\n');
fprintf('  Length L = %.1f mm\n', L*1000);
fprintf('  Width × Thickness = %.1f × %.1f mm\n', width*1000, thickness*1000);
fprintf('  Material: Polypropylene\n');
fprintf('  E = %.2e Pa (%.2f GPa)\n', E, E/1e9);
fprintf('  ν = %.2f\n', nu);
fprintf('  I = %.6e m⁴\n', I);
fprintf('  EI = %.6e N·m²\n', EI);
fprintf('\n');

%% FEA DATA EXTRACTION
% Extract Node 41 displacement data from GoodA load cases
fea_cases = struct();

% Case 1: n = 0.5 (GoodA loads - alpha = 0.5, P = 0.077 N)
fea_cases(1).n = 0.5;
fea_cases(1).PH = 0.0385;                % N (horizontal load = n*P)
fea_cases(1).PV = 0.077;                 % N (vertical load = P)
fea_cases(1).name = 'n = 0.5';
fea_cases(1).U1 = -0.919608;             % mm (from BeamN05_GoodA.rpt, Node 41)
fea_cases(1).U2 = 17.4733;               % mm
fea_cases(1).UR3 = 0.131518;             % rad
fea_cases(1).increments = 7;             % from report header

% Case 2: n = 1.0 (GoodA loads)
fea_cases(2).n = 1.0;
fea_cases(2).PH = 0.077;                 % N
fea_cases(2).PV = 0.077;                 % N
fea_cases(2).name = 'n = 1.0';
fea_cases(2).U1 = -1.02631;              % mm (from BeamN1_GoodA.rpt, Node 41)
fea_cases(2).U2 = 18.4432;               % mm
fea_cases(2).UR3 = 0.139144;             % rad
fea_cases(2).increments = 7;             % from report header

% Case 3: n = 2.0 (GoodA loads)
fea_cases(3).n = 2.0;
fea_cases(3).PH = 0.154;                 % N
fea_cases(3).PV = 0.077;                 % N
fea_cases(3).name = 'n = 2.0';
fea_cases(3).U1 = -1.28215;              % mm (from Beam_N2_GoodA.rpt, Node 41)
fea_cases(3).U2 = 20.5796;               % mm
fea_cases(3).UR3 = 0.155973;             % rad
fea_cases(3).increments = 7;             % from report header

%% CONVERT FEA DATA TO STANDARD UNITS
fprintf('FEA RESULTS (Node 41 - Beam Tip):\n');
fprintf('--------------------------------------------------------------\n');
fprintf('%-20s | U1(mm) | U2(mm) | UR3(rad) | θ(deg) | P_tot(N)\n', 'Case');
fprintf('--------------------------------------------------------------\n');

for i = 1:length(fea_cases)
    n = fea_cases(i).n;
    
    % Convert to meters
    a_fea = fea_cases(i).U1 * 1e-3;   % horizontal displacement (m)
    b_fea = fea_cases(i).U2 * 1e-3;   % vertical displacement (m)
    theta_fea = fea_cases(i).UR3;     % rotation (rad)
    
    % Store in structure for later use
    fea_cases(i).a_fea = a_fea;
    fea_cases(i).b_fea = b_fea;
    fea_cases(i).theta_fea = theta_fea;
    
    % Deflection magnitude
    deflection_mag = sqrt(a_fea^2 + b_fea^2);
    fea_cases(i).deflection_mag = deflection_mag;
    
    % Total load magnitude
    P_total = sqrt(fea_cases(i).PH^2 + fea_cases(i).PV^2);
    
    fprintf('%-20s | %6.2f | %6.2f | %7.4f | %6.1f | %7.2f\n', ...
        fea_cases(i).name, fea_cases(i).U1, fea_cases(i).U2, theta_fea, rad2deg(theta_fea), P_total);
end
fprintf('\n');

%% ANALYTICAL PREDICTIONS USING PRB MODEL
fprintf('ANALYTICAL PRB MODEL PREDICTIONS:\n');
fprintf('--------------------------------------------------------------\n');
fprintf('%-20s | γ (radius) | c_e (coeff) | θ_o_max(deg)\n', 'Case');
fprintf('--------------------------------------------------------------\n');

for i = 1:length(fea_cases)
    n = fea_cases(i).n;
    
    % Try to get PRB parameters
    try
        [gamma, theta_o_max] = compute_gamma_fits(n);
        c_e = compute_parametric_angle_coefficient(n);
    catch ME
        fprintf('ERROR computing PRB parameters for n = %.1f:\n%s\n', n, ME.message);
        continue;
    end
    
    % Angular deflection from FEA
    theta_o_fea = fea_cases(i).theta_fea;  % radians
    
    % Warn when the FEA rotation is outside the PRB parametrization range
    if abs(theta_o_fea) > abs(theta_o_max)
        warning('FEA θ_o = %.2f° exceeds PRB valid θ_o_max = %.2f° for n = %.1f. Accuracy may degrade.', ...
            rad2deg(theta_o_fea), rad2deg(theta_o_max), n);
    end
    
    % Compute PRB coordinates using parametric approximation
    theta_prb = theta_o_fea / c_e;
    
    % PRB deflections (Eq. 28, 29) with FEA coordinate sign conventions
    a_prb = sign(fea_cases(i).a_fea) * L * gamma * (1 - cos(theta_prb));
    b_prb = sign(fea_cases(i).b_fea) * L * gamma * sin(theta_prb);
    
    % Store results
    fea_cases(i).gamma = gamma;
    fea_cases(i).theta_o_max = theta_o_max;
    fea_cases(i).a_prb = a_prb;
    fea_cases(i).b_prb = b_prb;
    fea_cases(i).c_e = c_e;
    fea_cases(i).theta_prb = theta_prb;
    
    fprintf('%-20s | %.6f | %.6f | %7.2f\n', fea_cases(i).name, gamma, c_e, rad2deg(theta_o_max));
end
fprintf('\n');

%% ERROR ANALYSIS
fprintf('DETAILED ERROR ANALYSIS:\n');
fprintf('================================================================\n');
fprintf('%-30s | a error | b error | Total    | Angle\n', 'Case');
fprintf('%-30s | (mm)    | (mm)    | Defl %   | error(deg)\n', '');
fprintf('================================================================\n');

for i = 1:length(fea_cases)
    % Errors in displacements
    a_error = (fea_cases(i).a_prb - fea_cases(i).a_fea) * 1000;  % mm
    b_error = (fea_cases(i).b_prb - fea_cases(i).b_fea) * 1000;  % mm
    
    % Deflection magnitude error
    deflection_prb = sqrt(fea_cases(i).a_prb^2 + fea_cases(i).b_prb^2);
    deflection_error = abs(deflection_prb - fea_cases(i).deflection_mag) / fea_cases(i).deflection_mag * 100;
    
    % Angle error (should be small since we're using FEA angle)
    theta_prb_from_coords = atan2(fea_cases(i).b_prb, fea_cases(i).a_prb);
    angle_error = rad2deg(fea_cases(i).theta_fea - theta_prb_from_coords);
    
    fprintf('%-30s | %7.3f | %7.3f | %8.2f | %9.2f\n', ...
        fea_cases(i).name, a_error, b_error, deflection_error, angle_error);
    
    fea_cases(i).a_error = a_error;
    fea_cases(i).b_error = b_error;
    fea_cases(i).deflection_error = deflection_error;
    fea_cases(i).angle_error = angle_error;
end
fprintf('================================================================\n\n');

%% SUMMARY STATISTICS
fprintf('SUMMARY STATISTICS:\n');
fprintf('-----------------------------------------\n');

all_defl_errors = [fea_cases.deflection_error];
mean_defl_error = mean(all_defl_errors);
max_defl_error = max(all_defl_errors);
min_defl_error = min(all_defl_errors);

fprintf('Deflection Error Statistics:\n');
fprintf('  Mean: %.4f%%\n', mean_defl_error);
fprintf('  Min:  %.4f%%\n', min_defl_error);
fprintf('  Max:  %.4f%%\n', max_defl_error);
fprintf('  Target (paper): 0.5%%\n\n');

all_a_errors = abs([fea_cases.a_error]);
all_b_errors = abs([fea_cases.b_error]);

fprintf('Displacement Error Statistics (mm):\n');
fprintf('  Horizontal: mean = %.4f, max = %.4f\n', mean(all_a_errors), max(all_a_errors));
fprintf('  Vertical:   mean = %.4f, max = %.4f\n', mean(all_b_errors), max(all_b_errors));
fprintf('\n');

%% PLOTTING
fprintf('Generating comparison plots...\n');

fig = figure('Position', [100, 100, 1400, 900], 'Name', 'FEA vs PRB Comparison');

% Plot 1: Deflection Paths Comparison
subplot(2,3,1);
hold on;
colors = {'r', 'b', 'g'};
for i = 1:length(fea_cases)
    % FEA path (circle)
    scatter(fea_cases(i).a_fea*1000, fea_cases(i).b_fea*1000, 100, colors{i}, 'o', ...
        'LineWidth', 2.5, 'DisplayName', sprintf('FEA n=%.1f', fea_cases(i).n));
    
    % PRB prediction (square)
    scatter(fea_cases(i).a_prb*1000, fea_cases(i).b_prb*1000, 100, colors{i}, 's', ...
        'LineWidth', 2.5, 'DisplayName', sprintf('PRB n=%.1f', fea_cases(i).n));
end
xlabel('Horizontal Deflection a (mm)', 'FontSize', 11);
ylabel('Vertical Deflection b (mm)', 'FontSize', 11);
title('FEA vs PRB Deflection Paths (Final Load State)', 'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'best', 'FontSize', 9);
grid on;
hold off;

% Plot 2: Horizontal Displacement Comparison
subplot(2,3,2);
hold on;
n_vals = [];
a_fea_vals = [];
a_prb_vals = [];
for i = 1:length(fea_cases)
    n = fea_cases(i).n;
    n_vals = [n_vals, n];
    a_fea_vals = [a_fea_vals, fea_cases(i).a_fea*1000];
    a_prb_vals = [a_prb_vals, fea_cases(i).a_prb*1000];
end
[n_sorted, idx] = sort(n_vals);
plot(n_sorted, a_fea_vals(idx), 'o-', 'LineWidth', 2.5, 'MarkerSize', 8, 'DisplayName', 'FEA', 'Color', 'b');
plot(n_sorted, a_prb_vals(idx), 's--', 'LineWidth', 2.5, 'MarkerSize', 8, 'DisplayName', 'PRB', 'Color', 'r');
xlabel('Load Ratio n', 'FontSize', 11);
ylabel('Horizontal Deflection a (mm)', 'FontSize', 11);
title('Horizontal Deflection vs Load Ratio', 'FontSize', 12, 'FontWeight', 'bold');
legend;
grid on;
hold off;

% Plot 3: Vertical Displacement Comparison
subplot(2,3,3);
hold on;
b_fea_vals = [];
b_prb_vals = [];
for i = 1:length(fea_cases)
    b_fea_vals = [b_fea_vals, fea_cases(i).b_fea*1000];
    b_prb_vals = [b_prb_vals, fea_cases(i).b_prb*1000];
end
plot(n_sorted, b_fea_vals(idx), 'o-', 'LineWidth', 2.5, 'MarkerSize', 8, 'DisplayName', 'FEA', 'Color', 'b');
plot(n_sorted, b_prb_vals(idx), 's--', 'LineWidth', 2.5, 'MarkerSize', 8, 'DisplayName', 'PRB', 'Color', 'r');
xlabel('Load Ratio n', 'FontSize', 11);
ylabel('Vertical Deflection b (mm)', 'FontSize', 11);
title('Vertical Deflection vs Load Ratio', 'FontSize', 12, 'FontWeight', 'bold');
legend;
grid on;
hold off;

% Plot 4: Deflection Magnitude Error
subplot(2,3,4);
defl_error_vals = [];
case_names = {};
for i = 1:length(fea_cases)
    defl_error_vals = [defl_error_vals, fea_cases(i).deflection_error];
    case_names{i} = sprintf('n=%.1f', fea_cases(i).n);
end
[n_sorted_cases, idx_cases] = sort([fea_cases.n]);
bar_handle = bar(1:length(fea_cases), defl_error_vals(idx_cases), 'FaceColor', [0.7 0.7 0.9], 'EdgeColor', 'b', 'LineWidth', 2);
set(gca, 'XTickLabel', case_names(idx_cases));
ylabel('Relative Error (%)', 'FontSize', 11);
title('Deflection Magnitude Error', 'FontSize', 12, 'FontWeight', 'bold');
grid on;
hold on;
yline(0.5, '--r', 'Paper target (0.5%)', 'LineWidth', 1.5);
hold off;

% Plot 5: Angular Deflection Comparison
subplot(2,3,5);
hold on;
theta_fea_vals = [];
for i = 1:length(fea_cases)
    theta_fea_vals = [theta_fea_vals, rad2deg(fea_cases(i).theta_fea)];
end
plot(n_sorted, theta_fea_vals(idx), 'o-', 'LineWidth', 2.5, 'MarkerSize', 8, 'DisplayName', 'FEA', 'Color', 'b');
xlabel('Load Ratio n', 'FontSize', 11);
ylabel('Angular Deflection (deg)', 'FontSize', 11);
title('Beam End Angular Deflection vs Load Ratio', 'FontSize', 12, 'FontWeight', 'bold');
legend;
grid on;
hold off;

% Plot 6: Summary Statistics
subplot(2,3,6);
hold on;
a_error_vals = [];
b_error_vals = [];
for i = 1:length(fea_cases)
    a_error_vals = [a_error_vals, abs(fea_cases(i).a_error)];
    b_error_vals = [b_error_vals, abs(fea_cases(i).b_error)];
end
x_pos = 1:length(fea_cases);
width = 0.35;
bar(x_pos - width/2, a_error_vals(idx_cases), width, 'FaceColor', [0.9 0.7 0.7], 'DisplayName', 'Horiz. Error', 'EdgeColor', 'k', 'LineWidth', 1.5);
bar(x_pos + width/2, b_error_vals(idx_cases), width, 'FaceColor', [0.7 0.9 0.7], 'DisplayName', 'Vert. Error', 'EdgeColor', 'k', 'LineWidth', 1.5);
set(gca, 'XTickLabel', case_names(idx_cases));
ylabel('Absolute Displacement Error (mm)', 'FontSize', 11);
title('Displacement Errors by Component', 'FontSize', 12, 'FontWeight', 'bold');
legend;
grid on;
hold off;

sgtitle('FEA vs PRB Analytical Model Comparison', 'FontSize', 14, 'FontWeight', 'bold');

% Save figure
fig_path = fullfile(results_path, 'comparison_analysis.png');
saveas(fig, fig_path);
fprintf('  Saved: %s\n', fig_path);

%% EXPORT RESULTS TO TEXT FILE
results_file = fullfile(results_path, 'comparison_summary.txt');
fid = fopen(results_file, 'w');

fprintf(fid, '========================================================\n');
fprintf(fid, 'FEA vs PRB ANALYTICAL MODEL COMPARISON\n');
fprintf(fid, 'Howell & Midha (1995) Parametric Deflection Approximation\n');
fprintf(fid, '========================================================\n\n');

fprintf(fid, 'BEAM PROPERTIES:\n');
fprintf(fid, '  Length L = %.1f mm\n', L*1000);
fprintf(fid, '  Width × Thickness = %.1f × %.1f mm\n', width*1000, thickness*1000);
fprintf(fid, '  Material: Polypropylene\n');
fprintf(fid, '  E = %.2e Pa (%.2f GPa)\n', E, E/1e9);
fprintf(fid, '  ν = %.2f\n', nu);
fprintf(fid, '  I = %.6e m⁴\n', I);
fprintf(fid, '  EI = %.6e N·m²\n\n', EI);

fprintf(fid, 'COMPARISON RESULTS:\n');
fprintf(fid, '================================================================\n');
fprintf(fid, 'Case     | n  | FEA a(mm) | PRB a(mm) | FEA b(mm) | PRB b(mm) | Error%%\n');
fprintf(fid, '================================================================\n');

for i = 1:length(fea_cases)
    fprintf(fid, '%8s | %.1f | %9.2f | %9.2f | %9.2f | %9.2f | %6.2f\n', ...
        fea_cases(i).name, fea_cases(i).n, fea_cases(i).a_fea*1000, fea_cases(i).a_prb*1000, ...
        fea_cases(i).b_fea*1000, fea_cases(i).b_prb*1000, fea_cases(i).deflection_error);
end

fprintf(fid, '\nSUMMARY:\n');
fprintf(fid, '  Mean deflection error: %.4f%%\n', mean_defl_error);
fprintf(fid, '  Max deflection error:  %.4f%%\n', max_defl_error);
fprintf(fid, '  Min deflection error:  %.4f%%\n\n', min_defl_error);

if mean_defl_error < 1.0
    fprintf(fid, 'RESULT: ✓ GOOD AGREEMENT - Model predictions are within acceptable tolerance\n');
elseif mean_defl_error < 5.0
    fprintf(fid, 'RESULT: ~ MODERATE AGREEMENT - Model shows reasonable correlation\n');
else
    fprintf(fid, 'RESULT: ✗ POOR AGREEMENT - Consider model adjustments\n');
end

fclose(fid);
fprintf('  Saved: %s\n', results_file);

fprintf('\n========================================================\n');
fprintf('ANALYSIS COMPLETE\n');
fprintf('Results saved to: %s\n', results_path);
fprintf('========================================================\n');
