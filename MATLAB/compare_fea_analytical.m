%% FEA vs ANALYTICAL COMPARISON SCRIPT
% Compares ABAQUS FEA results with Howell & Midha PRB analytical model
% 
% FEA Model: L = 200 mm, E = 1.84 GPa (Polypropylene), ν = 0.46, width = 10 mm, thickness = 2 mm
% Cross-section: I = (10 × 2³)/12 = 6.667e-12 m⁴
% EI = 1.84e9 Pa × 6.667e-12 m⁴ = 0.01227 N·m²

clear all; close all; clc;

%% Model Parameters
L = 200e-3;                          % Beam length in meters (200 mm)
E = 1.84e9;                          % Young's modulus (Pa) - Polypropylene: 1.84 GPa
nu = 0.46;                           % Poisson's ratio
width = 10e-3;                       % Width (m)
thickness = 2e-3;                    % Thickness (m)
alpha_param = 0.5;                   % Load parameter from FEA setup (updated)

% Calculate flexural rigidity
I = (width * thickness^3) / 12;      % Second moment of inertia (m⁴)
EI = E * I;                          % Flexural rigidity (N·m²)

fprintf('===== FEA vs ANALYTICAL COMPARISON =====\n\n');
fprintf('Material: Polypropylene\n');
fprintf('Beam Properties:\n');
fprintf('  Length L = %.1f mm\n', L*1000);
fprintf('  Width × Thickness = %.1f × %.1f mm\n', width*1000, thickness*1000);
fprintf('  E = %.2e Pa (%.2f GPa)\n', E, E/1e9);
fprintf('  ν = %.2f\n', nu);
fprintf('  I = %.6e m⁴\n', I);
fprintf('  EI = %.6e N·m²\n', EI);
fprintf('  Load parameter α = %.2f\n', alpha_param);
fprintf('\n');

%% Parse FEA Data from .rpt files
% Load definition (corrected):
% Horizontal = PH (positive right), Vertical = PV (positive up)
% Load ratio: n = PH / |PV|
%
% Updated loads with alpha = 0.5, P = 0.077 N for each case:
% n = 0.5: PH = 0.5*P = 0.0385 N,  PV = P = 0.077 N (upward)
% n = 1.0: PH = 1.0*P = 0.077 N,  PV = P = 0.077 N (upward)
% n = 2.0: PH = 2.0*P = 0.154 N,  PV = P = 0.077 N (upward)

% Extract Node 41 displacement data from GoodA load cases
fea_cases = struct();

% Case 1: n = 0.5 (GoodA loads)
fea_cases(1).n = 0.5;
fea_cases(1).PH = 0.0385;                % N (horizontal load)
fea_cases(1).PV = 0.077;                 % N (vertical load, positive = upward)
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

%% Convert units and calculate load parameters
fprintf('FEA Results (Node 41 - Beam Tip):\n');
fprintf('--------------------------------------------------------------\n');
fprintf('%-20s | U1(mm) | U2(mm) | UR3(rad) | θ(deg)\n', 'Case');
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
    
    fprintf('%-20s | %6.2f | %6.2f | %7.4f | %6.1f\n', ...
        fea_cases(i).name, fea_cases(i).U1, fea_cases(i).U2, theta_fea, rad2deg(theta_fea));
end
fprintf('\n');

%% Estimate Load Magnitude
% From paper: α = P²/(EI) is the load index
% With alpha = 0.5 and P = 0.077 N, we can verify this

fprintf('Load Magnitude Verification:\n');
fprintf('-----------------------------------------\n');

% Calculate alpha from the given loads
P = 0.077;  % N
alpha_calculated = P^2 / EI;
fprintf('Given: P = %.3f N, α = %.3f\n', P, alpha_param);
fprintf('Calculated α = P²/EI = %.6f\n', alpha_calculated);
fprintf('Match: %.1f%%\n\n', abs(alpha_calculated - alpha_param)/alpha_param * 100);

%% ANALYTICAL PREDICTIONS
% For each case, compute analytical solution using PRB model

fprintf('Analytical PRB Predictions:\n');
fprintf('-----------------------------------------\n');

for i = 1:length(fea_cases)
    n = fea_cases(i).n;
    
    % Get PRB parameters using paper's definition
    [gamma, theta_o_max] = compute_gamma_fits(n);
    
    % Angular deflection from FEA
    theta_o_fea = fea_cases(i).theta_fea;  % radians
    
    % Compute PRB coordinates using parametric approximation
    % Get proper parametric angle coefficient based on load ratio
    c_e = compute_parametric_angle_coefficient(n);
    theta_prb = theta_o_fea / c_e;
    
    % PRB deflections (Eq. 28, 29)
    a_prb = L * gamma * (1 - cos(theta_prb));
    b_prb = L * gamma * sin(theta_prb);
    
    fea_cases(i).gamma = gamma;
    fea_cases(i).theta_o_max = theta_o_max;
    fea_cases(i).a_prb = a_prb;
    fea_cases(i).b_prb = b_prb;
    fea_cases(i).c_e = c_e;
    
    fprintf('n = %.1f: γ = %.6f, c_e = %.6f, θ_o_max = %.2f°\n', n, gamma, c_e, rad2deg(theta_o_max));
end
fprintf('\n');

%% COMPARISON AND ERROR ANALYSIS
fprintf('Error Analysis:\n');
fprintf('================================================================\n');
fprintf('%-30s | a error | b error | Deflection | Angle error\n', 'Case');
fprintf('%-30s | (mm)    | (mm)    | error (%)  | (deg)\n', '');
fprintf('================================================================\n');

for i = 1:length(fea_cases)
    % Errors in displacements
    a_error = (fea_cases(i).a_prb - fea_cases(i).a_fea) * 1000;  % mm
    b_error = (fea_cases(i).b_prb - fea_cases(i).b_fea) * 1000;  % mm
    
    % Deflection magnitude error
    deflection_prb = sqrt(fea_cases(i).a_prb^2 + fea_cases(i).b_prb^2);
    deflection_error = abs(deflection_prb - fea_cases(i).deflection_mag) / fea_cases(i).deflection_mag * 100;
    
    % Angle error
    angle_error = rad2deg(fea_cases(i).UR3 - fea_cases(i).theta_fea);
    
    fprintf('%-30s | %7.3f | %7.3f | %10.2f | %9.2f\n', ...
        fea_cases(i).name, a_error, b_error, deflection_error, angle_error);
    
    fea_cases(i).a_error = a_error;
    fea_cases(i).b_error = b_error;
    fea_cases(i).deflection_error = deflection_error;
    fea_cases(i).angle_error = angle_error;
end
fprintf('================================================================\n\n');

%% PLOTTING
figure('Position', [100, 100, 1400, 900]);

% Plot 1: Deflection Paths Comparison
subplot(2,3,1);
hold on;
colors = {'r', 'b', 'g', 'm'};
for i = 1:length(fea_cases)
    % FEA path
    scatter(fea_cases(i).a_fea*1000, fea_cases(i).b_fea*1000, 100, colors{i}, 'o', ...
        'LineWidth', 2, 'DisplayName', sprintf('FEA: %s', fea_cases(i).name));
    
    % PRB prediction
    scatter(fea_cases(i).a_prb*1000, fea_cases(i).b_prb*1000, 100, colors{i}, 's', ...
        'LineWidth', 2, 'DisplayName', sprintf('PRB: %s', fea_cases(i).name));
end
xlabel('Horizontal Deflection a (mm)');
ylabel('Vertical Deflection b (mm)');
title('FEA vs PRB Deflection Paths (Final Load State)');
legend('Location', 'best', 'FontSize', 8);
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
plot(n_sorted, a_fea_vals(idx), 'o-', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'FEA');
plot(n_sorted, a_prb_vals(idx), 's--', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'PRB');
xlabel('Load Ratio n');
ylabel('Horizontal Deflection a (mm)');
title('Horizontal Deflection vs Load Ratio');
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
plot(n_sorted, b_fea_vals(idx), 'o-', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'FEA');
plot(n_sorted, b_prb_vals(idx), 's--', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'PRB');
xlabel('Load Ratio n');
ylabel('Vertical Deflection b (mm)');
title('Vertical Deflection vs Load Ratio');
legend;
grid on;
hold off;

% Plot 4: Deflection Magnitude Error
subplot(2,3,4);
defl_error_vals = [];
for i = 1:length(fea_cases)
    defl_error_vals = [defl_error_vals, fea_cases(i).deflection_error];
end
bar(n_sorted, defl_error_vals(idx), 'FaceColor', [0.7 0.7 0.9], 'EdgeColor', 'b', 'LineWidth', 2);
xlabel('Load Ratio n');
ylabel('Relative Error (%)');
title('Deflection Magnitude Error');
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
plot(n_sorted, theta_fea_vals(idx), 'o-', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'FEA');
xlabel('Load Ratio n');
ylabel('Angular Deflection (deg)');
title('Beam End Angular Deflection vs Load Ratio');
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
bar(x_pos - width/2, a_error_vals, width, 'FaceColor', [0.9 0.7 0.7], 'DisplayName', 'Horiz. Error');
bar(x_pos + width/2, b_error_vals, width, 'FaceColor', [0.7 0.9 0.7], 'DisplayName', 'Vert. Error');
set(gca, 'XTickLabel', {'n=0.5', 'n=1.0', 'n=2.0'});
ylabel('Absolute Displacement Error (mm)');
title('Displacement Errors by Component');
legend;
grid on;
hold off;

sgtitle('FEA vs PRB Analytical Model Comparison', 'FontSize', 14, 'FontWeight', 'bold');

% Save figure
print('FEA_vs_Analytical_Comparison.png', '-dpng', '-r300');
fprintf('Comparison figure saved: FEA_vs_Analytical_Comparison.png\n\n');

%% SUMMARY
fprintf('===== SUMMARY =====\n');
fprintf('Material: Polypropylene (E = %.2f GPa, ν = %.2f)\n', E/1e9, nu);
fprintf('Average deflection magnitude error: %.2f%%\n', mean([fea_cases.deflection_error]));
fprintf('Paper target error: < 0.5%%\n\n');
fprintf('Load Definition: Horizontal = n×P, Vertical = P (matches paper)\n\n');
fprintf('Note: Full load path comparison requires intermediate FEA increments.\n');
fprintf('Current analysis shows final load state (Load Factor = 1.0).\n');

%% HELPER FUNCTIONS

function [gamma_fit, theta_o_max_fit] = compute_gamma_fits(n)
    % Compute gamma and theta_o_max using fitted polynomial equations
    % Based on Howell & Midha equations (39) and (41)
    %
    % Inputs:
    %   n: load ratio
    %
    % Outputs:
    %   gamma_fit: characteristic radius factor
    %   theta_o_max_fit: maximum parameterization angle (rad)
    
    % Polynomial fits for gamma (Eq 39)
    if n >= 0.5 && n <= 10.0
        gamma_fit = 0.841655 - 0.0067807*n + 0.000438004*n^2;
    elseif n >= -1.8316 && n < 0.5
        gamma_fit = 0.852144 - 0.0182867*n;
    elseif n >= -5.0 && n < -1.8316
        gamma_fit = 0.912364 + 0.0145928*n;
    else
        warning('n = %.4f is outside valid range [-5, 10]', n);
        gamma_fit = NaN;
    end
    
    % Parametrization limit (Eq 41)
    theta_o_max_deg = 0.85 * atand(-1/n);  % in degrees
    theta_o_max_fit = deg2rad(theta_o_max_deg);
end
