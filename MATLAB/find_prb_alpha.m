%% FIND ALPHA VALUES FOR PRB VALIDITY REGIME
% Compute alpha values that keep FEA tip angles within PRB validity limits
% Then compute corresponding physical loads P

clear all; close all; clc;

%% Geometry and Material
L = 200e-3;                          % Beam length (m)
E = 1.84e9;                          % Young's modulus (Pa)
width = 10e-3;                       % Width (m)
thickness = 2e-3;                    % Thickness (m)
I = (width * thickness^3) / 12;      % Second moment of inertia (m⁴)
EI = E * I;

fprintf('FINDING ALPHA VALUES FOR PRB VALIDITY REGIME\n');
fprintf('=================================================\n\n');

%% Load ratios and PRB validity limits
n_values = [0.5, 1.0, 2.0];
theta_o_max_deg = 0.85 * atand(1 ./ n_values);  % PRB validity limits (deg)

fprintf('PRB VALIDITY LIMITS:\n');
fprintf('  n = %.1f: θ_o_max = %.2f°\n', [n_values; theta_o_max_deg]);
fprintf('\n');

%% Target deflection angles (75% of max for safety margin)
target_percent = 0.75;
theta_target_deg = target_percent * theta_o_max_deg;
theta_target_rad = deg2rad(theta_target_deg);

fprintf('TARGET DEFLECTION ANGLES (%.0f%% of PRB max):\n', target_percent*100);
fprintf('  n = %.1f: θ_o_target = %.2f°\n', [n_values; theta_target_deg]);
fprintf('\n');

%% Find alpha values using forward sweep and interpolation
fprintf('FINDING ALPHA VALUES...\n');
fprintf('-------------------------------------------------\n');

alpha_values = zeros(size(n_values));
P_values = zeros(size(n_values));

for i = 1:length(n_values)
    n = n_values(i);
    theta_target = theta_target_rad(i);
    
    % Parametric sweep: compute max valid angle for a range of alpha^2 values
    alpha_sq_range = logspace(-2, 1, 100);  % 0.01 to 10
    theta_max_array = zeros(size(alpha_sq_range));
    
    fprintf('  Computing angle sweep for n = %.1f...\n', n);
    for j = 1:length(alpha_sq_range)
        alpha_sq = alpha_sq_range(j);
        P_test = sqrt(alpha_sq * EI / (L^2));
        
        % Find maximum valid angle for this alpha
        theta_max_array(j) = solve_theta_for_alpha(alpha_sq, n, L, EI, 85);
    end
    
    % Remove NaN values
    valid = ~isnan(theta_max_array);
    if sum(valid) > 2
        % Interpolate to find alpha that produces target angle
        alpha_sq_target = interp1(theta_max_array(valid), alpha_sq_range(valid), theta_target, 'linear');
        
        if isnan(alpha_sq_target)
            % Target angle outside range - use closest
            [~, idx] = min(abs(theta_max_array(valid) - theta_target));
            alpha_sq_target = alpha_sq_range(valid);
            alpha_sq_target = alpha_sq_target(idx);
        end
    else
        warning('Not enough valid angles for n = %.1f', n);
        alpha_sq_target = 0.5;
    end
    
    alpha_values(i) = sqrt(alpha_sq_target);
    P_values(i) = sqrt(alpha_sq_target * EI / (L^2));
    
    % Verify result
    theta_verify = solve_theta_for_alpha(alpha_sq_target, n, L, EI, 85);
    
    fprintf('n = %.1f:\n', n);
    fprintf('  α² = %.4f\n', alpha_sq_target);
    fprintf('  α  = %.4f\n', alpha_values(i));
    fprintf('  P_horizontal = %.4f N\n', P_values(i));
    fprintf('  P_vertical   = %.4f N\n', n * P_values(i));
    fprintf('  Verified θ_o = %.2f° (target = %.2f°)\n', rad2deg(theta_verify), theta_target_deg(i));
    fprintf('\n');
end

fprintf('\n');
fprintf('SUMMARY TABLE:\n');
fprintf('--------------------------------------\n');
fprintf('n      | θ_target(°) | α²      | P_horiz(N)\n');
fprintf('--------------------------------------\n');
for i = 1:length(n_values)
    alpha_sq = alpha_values(i)^2;
    fprintf('%.1f    | %8.2f    | %7.4f | %9.4f\n', n_values(i), theta_target_deg(i), alpha_sq, P_values(i));
end
fprintf('\n');

%% Save results
save('prb_validity_loads.mat', 'n_values', 'alpha_values', 'P_values', 'theta_target_deg', 'I', 'L', 'E', 'EI');
fprintf('Results saved to prb_validity_loads.mat\n');


%% Helper function: solve for beam end angle given alpha squared
function theta_o = solve_theta_for_alpha(alpha_squared, n, L, EI, max_angle_deg)
    % Given alpha^2 and load ratio n, find the beam end angle theta_o
    % Uses the elliptic integral solution via compute_beam_deflection
    
    if nargin < 5
        max_angle_deg = 80;  % Upper limit in degrees
    end
    
    P = sqrt(alpha_squared * EI / (L^2));  % Compute P from alpha
    
    % Search for the maximum valid angle for this alpha
    theta_search = linspace(0, deg2rad(max_angle_deg), 200);
    
    valid_angles = [];
    for j = 1:length(theta_search)
        try
            [a, b] = compute_beam_deflection(theta_search(j), n, L, EI, P);
            if isreal(a) && isreal(b) && ~isnan(a) && ~isnan(b)
                valid_angles = [valid_angles, theta_search(j)];
            end
        catch
            % Angle exceeded validity range
            break
        end
    end
    
    if ~isempty(valid_angles)
        theta_o = valid_angles(end);  % Return the maximum valid angle
    else
        theta_o = NaN;
    end
end
