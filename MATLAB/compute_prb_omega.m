% compute_prb_omega.m
% Estimate required load index omega^2 for PRB validity at n=0.5,1.0,2.0

n_vals = [0.5, 1.0, 2.0];
c_e_vals = [1.2430, 1.2467, 1.2511];

theta_o_max = 0.85 * atand(1 ./ n_vals);

omega_sq_target = zeros(size(n_vals));
for i = 1:length(n_vals)
    n = n_vals(i);
    c_e = c_e_vals(i);
    theta_prb_target = deg2rad(theta_o_max(i) / c_e);
    f = @(omega_sq) load_deflection_flexibility(omega_sq, n) - theta_prb_target;
    omega0 = 0.5;
    omega_sq_target(i) = fzero(f, omega0);
    fprintf('n=%.1f: theta_o_max=%.2f deg, theta_prb_target=%.4f rad, omega_sq=%.4f\n', n, theta_o_max(i), theta_prb_target, omega_sq_target(i));
end

save('prb_omega_target.mat','n_vals','theta_o_max','omega_sq_target');
