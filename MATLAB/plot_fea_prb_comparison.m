function plot_fea_prb_comparison()
% plot_fea_prb_comparison  Load FEA data from ResultsPRB.rpt or MechanismTake3.rpt and
% compare slider displacement and input torque with the PRB model.
%
% When ResultsPRB.rpt is available, the script uses the fixed-pinned beam
% PRB parameters from the PRB Model/New slides (n = 0, φ = 90°).
% Otherwise it falls back to the generic MechanismTake3.rpt comparison.
%
% The FEA report uses RM3 as input torque, U1 as slider displacement, and
% UR3 as crank input angle.

close all; clc;

% Build report path relative to this script
scriptDir = fileparts(mfilename('fullpath'));
defaultRptPath = fullfile(scriptDir, '..', 'FEA Model', 'PRB Assumption', 'Redo', 'ResultsPRB.rpt');
backupRptPath = fullfile(scriptDir, '..', 'FEA Model', 'Working Model Dynamic', 'MechanismTake3.rpt');

if isfile(defaultRptPath)
    rptPath = defaultRptPath;
    modelVariant = 'fixed_pinned';
elseif isfile(backupRptPath)
    rptPath = backupRptPath;
    modelVariant = 'generic';
else
    error('FEA report not found. Checked:\n  %s\n  %s', defaultRptPath, backupRptPath);
end

fprintf('Loading FEA report from:\n  %s\n', rptPath);
fprintf('Using PRB model variant: %s\n', modelVariant);

% Read numeric data using readmatrix
data_matrix = readmatrix(rptPath, 'FileType', 'text', 'NumHeaderLines', 3);
if isempty(data_matrix)
    error('No numeric data found in the FEA report file.');
end

% Remove rows with NaN or Inf values
valid_rows = all(isfinite(data_matrix), 2);
if ~all(valid_rows)
    fprintf('Warning: Removed %d rows with invalid data (NaN/Inf) from FEA report.\n', sum(~valid_rows));
    data_matrix = data_matrix(valid_rows, :);
end

% The report is expected to contain four data columns: X, torque, UR3 angle, displacement.
% Use column 3 for UR3 angle in radians, column 2 for torque, and column 4 for slider displacement.
if size(data_matrix, 2) >= 4
    feaAngle_rad = data_matrix(:, 3);
    feaTorque = data_matrix(:, 2);
    feaDisp = data_matrix(:, 4);
else
    error('Unexpected FEA report format: %s', rptPath);
end

% Sort data by UR3 angle to ensure monotonic order for interpolation
[feaAngle_rad, sort_idx] = sort(feaAngle_rad);
feaTorque = feaTorque(sort_idx);
feaDisp = feaDisp(sort_idx);
feaAngle = feaAngle_rad;  % keep radians for plotting

% PRB model parameters
r1 = 3.0;        % Crank length
Lc = 5.0;        % Coupler length
offset = 0.5;    % Vertical offset from crank pivot to slider ground
EI = 16.0;       % Flexural rigidity

phi1_range = linspace(min(feaAngle_rad), max(feaAngle_rad), 1000);  % Match FEA angle range in radians

prbModels = {'Howell-Midha', 'My PRB'};
prbResults = struct('name', {}, 'prbAngleRad', {}, 'x_slider', {}, 'prbTorque', {}, 'gamma', {}, 'c_e', {}, 'K_theta', {});

for v = 1:length(prbModels)
    variant = prbModels{v};
    if strcmp(variant, 'My PRB')
        gamma = 0.8517;                       % Fixed-pinned beam characteristic radius factor
        c_e = 1.2385;                         % Fixed-pinned beam parametric angle coefficient
        K_theta = gamma * 2.67617 * EI / Lc;  % Fixed-pinned torsional spring constant
        param_x = @(Theta) Lc * (1 - gamma * (1 - cos(Theta)));
        param_y = @(Theta) gamma * Lc * sin(Theta);
    else
        Kb = 0.85;                            % Characteristic beam parameter for Howell-Midha PRB
        gamma = NaN;                          % Not applicable for Howell-Midha
        c_e = 1.2467;                         % Typical coefficient from Howell & Midha Table 1
        K_theta = 12.7 * EI / Lc;             % Torsional spring constant
        param_x = @(Theta) Lc * (1 - (2*Kb/pi)*sin(Theta/2)) .* cos(Theta);
        param_y = @(Theta) Lc * (1 - (2*Kb/pi)*sin(Theta/2)) .* sin(Theta);
    end

    y_tip_func = @(Theta, phi1) offset + r1*sin(phi1) + param_y(Theta);

    % Set Theta grid and initial guess based on model
    if strcmp(variant, 'My PRB')
        Theta_grid = linspace(0, pi, 4001);
        Theta_prev = pi/2;
    else
        Theta_grid = linspace(-pi, pi, 4001);
        Theta_prev = 0.5;
    end

    Theta_sol = zeros(size(phi1_range));
    for i = 1:length(phi1_range)
        phi1 = phi1_range(i);
        try
            Theta_sol(i) = fzero(@(Theta) y_tip_func(Theta, phi1), Theta_prev);
        catch
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
        end
        Theta_prev = Theta_sol(i);
    end

    x_slider = r1*cos(phi1_range) + param_x(Theta_sol);
    x_slider = x_slider - x_slider(1);  % Shift to same start point as FEA

    dTheta_dphi1 = gradient(Theta_sol, phi1_range);
    prbTorque = - K_theta * Theta_sol .* dTheta_dphi1;

    prbResults(v).name = variant;
    prbResults(v).prbAngleRad = phi1_range;
    prbResults(v).x_slider = x_slider;
    prbResults(v).prbTorque = prbTorque;
    prbResults(v).gamma = gamma;
    prbResults(v).c_e = c_e;
    prbResults(v).K_theta = K_theta;
end

resultsDir = fullfile(scriptDir, 'results');
if ~isfolder(resultsDir)
    mkdir(resultsDir);
end

% Normalize slider displacements so the minimum becomes 0 and the maximum becomes 1
norm_fea_disp = (feaDisp - min(feaDisp)) / (max(feaDisp) - min(feaDisp));

fig1 = figure('Name', 'Normalized Slider Displacement vs Crank Angle', 'NumberTitle', 'off');
plot(feaAngle, norm_fea_disp, '-o', 'MarkerSize', 6, 'DisplayName', 'FEA');
hold on;
for v = 1:length(prbResults)
    norm_prb_disp = (prbResults(v).x_slider - min(prbResults(v).x_slider)) / (max(prbResults(v).x_slider) - min(prbResults(v).x_slider));
    plot(prbResults(v).prbAngleRad, norm_prb_disp, '-', 'LineWidth', 2, 'DisplayName', prbResults(v).name);
end
xlabel('Crank Angle UR3 (rad)');
ylabel('Normalized Slider Displacement');
title('Normalized Slider Displacement vs Crank Angle');
legend('Location', 'best');
grid on;
exportgraphics(fig1, fullfile(resultsDir, 'normalized_slider_displacement_vs_crank_angle.png'), 'Resolution', 300);

% Plot input torque vs crank angle
fig2 = figure('Name', 'Input Torque vs Crank Angle', 'NumberTitle', 'off');
plot(feaAngle, feaTorque, '-o', 'MarkerSize', 6, 'DisplayName', 'FEA');
hold on;
for v = 1:length(prbResults)
    plot(prbResults(v).prbAngleRad, prbResults(v).prbTorque, '-', 'LineWidth', 2, 'DisplayName', prbResults(v).name);
end
xlabel('Crank Angle UR3 (rad)');
ylabel('Input Torque RM3 (units)');
title('Input Torque vs Crank Angle');
legend('Location', 'best');
grid on;
exportgraphics(fig2, fullfile(resultsDir, 'input_torque_vs_crank_angle.png'), 'Resolution', 300);

fprintf('Saved figures to %s\n', resultsDir);
fprintf('Loaded %d FEA data points from:\n  %s\n', numel(feaAngle), rptPath);
fprintf('FEA angle range: [%.4f, %.4f] rad\n', min(feaAngle), max(feaAngle));
fprintf('FEA displacement range: [%.6g, %.6g]\n', min(feaDisp), max(feaDisp));
fprintf('FEA torque range: [%.6g, %.6g]\n', min(feaTorque), max(feaTorque));

% Calculate average percentage errors for each PRB model
for v = 1:length(prbResults)
    prb_disp_interp = interp1(prbResults(v).prbAngleRad, prbResults(v).x_slider, feaAngle_rad);
    valid_disp = abs(prb_disp_interp) > 1e-10;
    percent_error_disp = abs(feaDisp(valid_disp) - prb_disp_interp(valid_disp)) ./ abs(prb_disp_interp(valid_disp)) * 100;
    avg_error_disp = mean(percent_error_disp, 'omitnan');

    prb_torque_interp = interp1(prbResults(v).prbAngleRad, prbResults(v).prbTorque, feaAngle);
    valid_torque = abs(prb_torque_interp) > 1e-10;
    percent_error_torque = abs(feaTorque(valid_torque) - prb_torque_interp(valid_torque)) ./ abs(prb_torque_interp(valid_torque)) * 100;
    avg_error_torque = mean(percent_error_torque, 'omitnan');

    fprintf('Average %% error for %s:\n', prbResults(v).name);
    fprintf('  Slider displacement: %.2f%%\n', avg_error_disp);
    fprintf('  Input torque:       %.2f%%\n', avg_error_torque);
end
end
