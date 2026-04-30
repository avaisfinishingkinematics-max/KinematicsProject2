clc; clearvars; close all;

% PRB Model Analysis for Side-Crank Compliant Mechanism
% This script calculates the slider position and input torque as a function of crank angle
% using the Pseudo-Rigid-Body (PRB) model with parametric approximations

% Define parameters
r1 = 3.0;        % Crank length
Lc = 5.0;        % Coupler length
offset = 0.5;    % Vertical offset from crank pivot to slider ground
Kb = 0.85;       % Characteristic beam parameter
EI = 16.0;        % Flexural rigidity (adjusted to match torque range)
K_theta = 12.7 * EI / Lc;  % Torsional spring constant
phi1_range = linspace(0, 2*pi, 1000);  % Crank angle range

% Function to calculate parametric coordinates of the beam tip in the beam frame
param_x = @(Theta) Lc * (1 - (2*Kb/pi)*sin(Theta/2)) .* cos(Theta);
param_y = @(Theta) Lc * (1 - (2*Kb/pi)*sin(Theta/2)) .* sin(Theta);

% Function for y_tip = 0, with crank pivot at (0, offset)
y_tip_func = @(Theta, phi1) offset + r1*sin(phi1) + param_y(Theta);

% Initialize arrays
Theta_sol = zeros(size(phi1_range));
x_slider = zeros(size(phi1_range));

% Solve for each crank angle with a stable Θ branch
Theta_prev = 0.5;
Theta_grid = linspace(-pi, pi, 4001);
for i = 1:length(phi1_range)
    phi1 = phi1_range(i);
    f_vals = y_tip_func(Theta_grid, phi1);
    sign_changes = find(diff(sign(f_vals)) ~= 0);
    if isempty(sign_changes)
        Theta_sol(i) = Theta_prev;
    else
        roots = zeros(length(sign_changes),1);
        for j = 1:length(sign_changes)
            a = Theta_grid(sign_changes(j));
            b = Theta_grid(sign_changes(j)+1);
            roots(j) = fzero(@(Theta) y_tip_func(Theta, phi1), [a b]);
        end
        [~, idx] = min(abs(roots - Theta_prev));
        Theta_sol(i) = roots(idx);
    end
    Theta_prev = Theta_sol(i);
    
    % Calculate x_tip
    x_param = param_x(Theta_sol(i));
    x_slider(i) = r1*cos(phi1) + x_param;
end

% Calculate input torque via energy derivative
dTheta_dphi1 = gradient(Theta_sol, phi1_range);
torque = - K_theta * Theta_sol .* dTheta_dphi1;

% Plot results
figure;
subplot(2,1,1);
plot(rad2deg(phi1_range), x_slider, 'b-', 'LineWidth', 2);
xlabel('Crank Angle \phi_1 (deg)');
ylabel('Slider Position x (units)');
title('Slider Position vs Crank Angle (PRB Model)');
grid on;

subplot(2,1,2);
plot(rad2deg(phi1_range), torque, 'r-', 'LineWidth', 2);
xlabel('Crank Angle \phi_1 (deg)');
ylabel('Input Torque \tau (units)');
title('Input Torque vs Crank Angle (PRB Model)');
grid on;

% Display some statistics
fprintf('Crank length: %.2f\n', r1);
fprintf('Coupler length: %.2f\n', Lc);
fprintf('Offset: %.2f\n', offset);
fprintf('Characteristic parameter Kb: %.2f\n', Kb);
fprintf('Flexural rigidity EI: %.2f\n', EI);
fprintf('Torsional spring constant K_theta: %.2f\n', K_theta);
fprintf('Slider position range: %.3f to %.3f\n', min(x_slider), max(x_slider));
fprintf('Torque range: %.3f to %.3f\n', min(torque), max(torque));