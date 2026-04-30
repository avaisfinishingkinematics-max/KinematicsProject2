%% PRB ANALYTICAL MODEL - MAIN ANALYSIS SCRIPT
% Implements Howell & Midha pseudo-rigid-body parametric deflection
% approximation for large-deflection cantilever beams
%
% References:
%   L. L. Howell and A. Midha, "Parametric Deflection Approximations 
%   for End-Loaded, Large-Deflection Beams in Compliant Mechanisms,"
%   ASME J. Mech. Des., vol. 117, no. 1, pp. 156–165, 1995.

clear all; close all; clc;

%% Problem Parameters
% Beam properties
L = 1.0;                    % Beam length (normalized)
EI = 1.0;                   % Flexural rigidity (normalized)

% Load cases to analyze
n_values = [0.0, 0.5, 1.0, 2.0];  % Load ratios

% Angular deflection range
theta_o_deg = linspace(0, 75, 150);  % degrees
theta_o = deg2rad(theta_o_deg);       % radians

% Storage for results
results = struct();

%% CASE 1: Elliptic Integral Solution (Exact)
fprintf('Computing exact elliptic integral solution...\n');

for i = 1:length(n_values)
    n = n_values(i);
    
    % Initialize storage
    a_exact = zeros(size(theta_o));
    b_exact = zeros(size(theta_o));
    
    % Compute for each angular deflection
    for j = 1:length(theta_o)
        try
            [a_exact(j), b_exact(j)] = compute_beam_deflection(theta_o(j), n, L, EI, 1.0);
        catch ME
            % If out of valid range, truncate
            a_exact = a_exact(1:j-1);
            b_exact = b_exact(1:j-1);
            theta_o_trunc = theta_o(1:j-1);
            break
        end
    end
    
    % Store results
    results(i).n = n;
    results(i).theta_o_exact = theta_o_trunc;
    results(i).a_exact = a_exact;
    results(i).b_exact = b_exact;
end

%% CASE 2: Parametric PRB Approximation
fprintf('Computing parametric PRB approximation...\n');

for i = 1:length(results)
    n = results(i).n;
    theta_o_exact = results(i).theta_o_exact;
    
    % Get gamma and theta_o_max from fitted equations
    [gamma, theta_o_max] = compute_gamma_fits(n);
    
    % Initialize storage
    a_prb = zeros(size(theta_o_exact));
    b_prb = zeros(size(theta_o_exact));
    omega_sq_array = zeros(size(theta_o_exact));
    theta_prb_array = zeros(size(theta_o_exact));
    
    % Compute for each angular deflection
    for j = 1:length(theta_o_exact)
        % Get load index from polynomial fit
        omega_sq = load_deflection_stiffness(0, n);  % Will need to refine this
        
        % For now, use empirical relationship with load-ratio specific coefficient
        c_e = compute_parametric_angle_coefficient(n);
        theta_prb = theta_o_exact(j) / c_e;  % Parametric angle coefficient
        
        % Compute PRB coordinates (Eq 28, 29)
        a_prb(j) = L * gamma * (1 - cos(theta_prb));
        b_prb(j) = L * gamma * sin(theta_prb);
        
        theta_prb_array(j) = theta_prb;
        omega_sq_array(j) = omega_sq;
    end
    
    % Store PRB results
    results(i).gamma = gamma;
    results(i).theta_o_max = theta_o_max;
    results(i).a_prb = a_prb;
    results(i).b_prb = b_prb;
    results(i).theta_prb = theta_prb_array;
end

%% CASE 3: Compute Error
fprintf('Computing approximation error...\n');

for i = 1:length(results)
    % Compute deflection magnitudes
    b_e = sqrt(results(i).a_exact.^2 + results(i).b_exact.^2);
    b_a = sqrt(results(i).a_prb.^2 + results(i).b_prb.^2);
    
    % Absolute and relative error
    error_absolute = abs(b_e - b_a);
    error_relative = error_absolute ./ b_e * 100;  % percent
    
    results(i).error_absolute = error_absolute;
    results(i).error_relative = error_relative;
end

%% Plotting
fprintf('Generating plots...\n');

figure('Position', [100, 100, 1200, 800]);

% Plot 1: Deflection paths
subplot(2,3,1);
hold on;
for i = 1:length(results)
    plot(results(i).a_exact, results(i).b_exact, 'o-', 'LineWidth', 2, ...
        'DisplayName', sprintf('Exact (n=%.1f)', results(i).n), 'MarkerSize', 3);
    plot(results(i).a_prb, results(i).b_prb, 's--', 'LineWidth', 1.5, ...
        'DisplayName', sprintf('PRB (n=%.1f)', results(i).n), 'MarkerSize', 3);
end
xlabel('Horizontal Deflection a/L');
ylabel('Vertical Deflection b/L');
title('Beam Tip Deflection Paths');
legend('Location', 'best', 'FontSize', 8);
grid on; axis equal;

% Plot 2: Relative error vs angle
subplot(2,3,2);
for i = 1:length(results)
    plot(rad2deg(results(i).theta_o_exact), results(i).error_relative, ...
        'o-', 'LineWidth', 2, 'DisplayName', sprintf('n=%.1f', results(i).n));
end
xlabel('Beam End Angular Deflection θ_o (deg)');
ylabel('Relative Error (%)');
title('Parametric Approximation Error');
legend;
grid on;
hold off;

% Plot 3: Load index vs PRB angle
subplot(2,3,3);
for i = 1:length(results)
    plot(rad2deg(results(i).theta_prb), results(i).omega_sq, ...
        'o-', 'LineWidth', 2, 'DisplayName', sprintf('n=%.1f', results(i).n));
end
xlabel('PRB Angle θ (deg)');
ylabel('Load Index ω^2');
title('Load-Deflection Relationship');
legend;
grid on;

% Plot 4: Horizontal vs vertical deflection
subplot(2,3,4);
hold on;
for i = 1:length(results)
    plot(results(i).a_exact, results(i).b_exact, 'o-', 'LineWidth', 2, ...
        'DisplayName', sprintf('n=%.1f', results(i).n), 'MarkerSize', 4);
end
xlabel('Horizontal Deflection a/L');
ylabel('Vertical Deflection b/L');
title('Beam Deflection (Exact Solutions)');
legend;
grid on;

% Plot 5: Characteristic radius factor vs load ratio
subplot(2,3,5);
n_range = linspace(-5, 10, 100);
gamma_range = zeros(size(n_range));
for j = 1:length(n_range)
    [gamma_range(j), ~] = compute_gamma_fits(n_range(j));
end
plot(n_range, gamma_range, 'LineWidth', 2);
scatter(results(:).n, [results(:).gamma], 50, 'red', 'filled');
xlabel('Load Ratio n');
ylabel('Characteristic Radius Factor γ');
title('γ vs Load Ratio (Fitted Equation)');
grid on;

% Plot 6: Max parameterization angle vs load ratio
subplot(2,3,6);
theta_o_max_range = zeros(size(n_range));
for j = 1:length(n_range)
    [~, theta_o_max_range(j)] = compute_gamma_fits(n_range(j));
end
plot(n_range, rad2deg(theta_o_max_range), 'LineWidth', 2);
scatter(results(:).n, rad2deg([results(:).theta_o_max]), 50, 'red', 'filled');
xlabel('Load Ratio n');
ylabel('θ_{o,max} (deg)');
title('Parametrization Limit vs Load Ratio');
grid on;

savefig(fullfile('..', 'validation', 'PRB_analytical_results.fig'));
print(fullfile('..', 'validation', 'PRB_analytical_results.png'), '-dpng', '-r300');

fprintf('\nAnalysis complete. Results saved to validation folder.\n');
