%% COMPUTE TARGET LOADS FOR PRB VALIDITY
% Simple approach using paper's load-deflection polynomials

clear; clc;

%% Geometry
L = 200e-3;                  % Beam length (m)
E = 1.84e9;                  % Young's modulus (Pa)
width = 10e-3;               % Width (m)
thickness = 2e-3;            % Thickness (m)
I = (width * thickness^3) / 12;
EI = E * I;

fprintf('TARGET LOADS FOR PRB VALIDITY REGIME\n');
fprintf('===================================\n\n');

%% PRB validity and target angles
n_vals = [0.5, 1.0, 2.0];
theta_o_max_deg = 0.85 * atand(1 ./ n_vals);  % PRB limits
c_e_vals = [1.2430, 1.2467, 1.2511];

% Target: 75% of PRB max
target_percent = 0.75;
theta_o_target_deg = target_percent * theta_o_max_deg;
theta_o_target_rad = deg2rad(theta_o_target_deg);

fprintf('PRB VALIDITY LIMITS:\n');
fprintf('%-5s  %-12s  %-12s\n', 'n', 'θ_o_max(°)', 'θ_o_target(°)');
fprintf('%-5.1f  %-12.2f  %-12.2f\n', [n_vals; theta_o_max_deg; theta_o_target_deg]);
fprintf('\n');

%% Compute omega^2 from target angles using paper's polynomial fits
% From Howell & Midha Table 2: omega^2 = sum(a_i * theta^i)

coeffs_stiffness = {
    [4.14190e+00, -2.49660e+01, 5.22990e+01, -4.52570e+01, 1.89730e+01],  % n=0.5
    [2.67390e+00, -2.92870e+01, 4.15670e+01, -2.81210e+01, 9.13740e+00],  % n=1.0
    [2.36400e+00, -3.46440e+01, 3.85830e+01, -2.08780e+01, 5.04310e+00]   % n=2.0
};

fprintf('TARGET LOADS:\n');
fprintf('%-5s  %-10s  %-12s  %-12s  %-12s\n', 'n', 'θ_prb(°)', 'ω²', 'P_h(N)', 'P_v(N)');
fprintf('%-5s  %-10s  %-12s  %-12s  %-12s\n', '---', '---', '---', '---', '---');

P_h_vals = [];
P_v_vals = [];

for i = 1:length(n_vals)
    n = n_vals(i);
    c_e = c_e_vals(i);
    theta_o_target = theta_o_target_rad(i);
    theta_prb_target = theta_o_target / c_e;  % Parametric angle
    
    % Compute omega^2 from theta_prb using polynomial fit
    coeff = coeffs_stiffness{i};
    theta = theta_prb_target;
    omega_sq = coeff(1)*theta + coeff(2)*theta^2 + coeff(3)*theta^3 + coeff(4)*theta^4 + coeff(5)*theta^5;
    
    % Compute P from omega^2 = P^2 / EI
    P_squared = omega_sq * EI;
    P_h = sqrt(P_squared);
    P_v = n * P_h;
    
    P_h_vals = [P_h_vals, P_h];
    P_v_vals = [P_v_vals, P_v];
    
    fprintf('%-5.1f  %-10.2f  %-12.4f  %-12.4f  %-12.4f\n', n, rad2deg(theta_prb_target), omega_sq, P_h, P_v);
end

fprintf('\n');
fprintf('RECOMMENDED FEA LOADS:\n');
fprintf('===================================\n');
fprintf('Case          P_horizontal (N)    P_vertical (N)\n');
fprintf('---           ----------------    ---------------\n');
for i = 1:length(n_vals)
    fprintf('n = %.1f        %.4f               %.4f\n', n_vals(i), P_h_vals(i), P_v_vals(i));
end

fprintf('\n');
fprintf('COMPARISON TO CURRENT LOADS:\n');
fprintf('=============================\n');
current_PH = [0.96, 1.92, 3.83];
current_PV = [1.92, 1.92, 1.92];

fprintf('Case          Current P_h (N)   Recommended P_h (N)   Reduction Factor\n');
fprintf('---           ---------------   -------------------   ----------------\n');
for i = 1:length(n_vals)
    ratio = current_PH(i) / P_h_vals(i);
    fprintf('n = %.1f        %.4f             %.4f                 %.2f×\n', n_vals(i), current_PH(i), P_h_vals(i), ratio);
end

save('target_loads_prb.mat', 'n_vals', 'P_h_vals', 'P_v_vals', 'theta_o_target_deg');
fprintf('\nResults saved to target_loads_prb.mat\n');
