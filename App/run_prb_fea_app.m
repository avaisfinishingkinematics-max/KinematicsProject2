function run_prb_fea_app()
% RUN_PRB_FEA_APP  Launch an interactive GUI comparing PRB and FEA results.
%
% The app loads FEA results from MechanismTake3.rpt and computes the PRB
% analytical model prediction for slider deflection and input torque.
% Users can modify key PRB design parameters and immediately see the
% discrepancy between analytical and FEA results.

    % Build main figure
    appFig = uifigure('Name', 'PRB vs FEA Interactive Comparison', ...
        'Position', [100 100 1350 780]);
    appFig.Icon = [];

    mainGrid = uigridlayout(appFig, [3, 4]);
    mainGrid.RowHeight = {'fit', '1x', 'fit'};
    mainGrid.ColumnWidth = {280, '1x', '1x', '1x'};
    mainGrid.Padding = [15 15 15 15];
    mainGrid.RowSpacing = 12;
    mainGrid.ColumnSpacing = 12;

    titleLabel = uilabel(mainGrid);
    titleLabel.Layout = [1 1 4 1];
    titleLabel.Text = 'Interactive PRB vs FEA Comparison';
    titleLabel.FontSize = 18;
    titleLabel.FontWeight = 'bold';

    helpLabel = uilabel(mainGrid);
    helpLabel.Layout = [2 1 1 1];
    helpLabel.Text = ["Modify the PRB parameters below and click Update to", ...
        " see the analytical prediction compared to the FEA surrogate."];
    helpLabel.FontSize = 12;
    helpLabel.WordWrap = 'on';

    controlPanel = uipanel(mainGrid, 'Title', 'PRB Parameters');
    controlPanel.Layout = [2 1 1 1];
    controlGrid = uigridlayout(controlPanel, [8, 2]);
    controlGrid.RowHeight = repmat({'fit'}, 1, 8);
    controlGrid.ColumnWidth = {'1x', '1x'};
    controlGrid.Padding = [10 10 10 10];
    controlGrid.RowSpacing = 8;
    controlGrid.ColumnSpacing = 8;

    addControl('Crank length r_1', '3.00', 'model units', 1);
    addControl('Coupler length L_c', '5.00', 'model units', 2);
    addControl('Offset', '0.50', 'model units', 3);
    addControl('Beam parameter K_b', '0.85', '(unitless)', 4);
    addControl('Flexural rigidity E I', '16.00', 'model units', 5);
    addControl('FEA dataset', 'MechanismTake3.rpt', '', 6, true);

    updateButton = uibutton(controlGrid, 'push', 'Text', 'Update Plots', ...
        'ButtonPushedFcn', @(src, event) updatePlots());
    updateButton.Layout = [7 1 2 1];
    updateButton.FontWeight = 'bold';

    resultsText = uitextarea(controlGrid, 'Editable', 'off');
    resultsText.Layout = [8 1 2 1];
    resultsText.FontSize = 11;
    resultsText.Value = {'Average displacement error: --'; 'Average torque error: --'};

    axDisp = uiaxes(mainGrid);
    axDisp.Layout = [2 2 1 1];
    axDisp.Title.String = 'Slider Displacement vs Crank Angle';
    axDisp.XLabel.String = 'Crank Angle (rad)';
    axDisp.YLabel.String = 'Slider displacement';
    axDisp.FontSize = 11;
    axDisp.Box = 'on';
    axDisp.NextPlot = 'add';

    axTorque = uiaxes(mainGrid);
    axTorque.Layout = [2 3 1 1];
    axTorque.Title.String = 'Input Torque vs Crank Angle';
    axTorque.XLabel.String = 'Crank Angle (deg)';
    axTorque.YLabel.String = 'Input torque';
    axTorque.FontSize = 11;
    axTorque.Box = 'on';
    axTorque.NextPlot = 'add';

    axError = uiaxes(mainGrid);
    axError.Layout = [2 4 1 1];
    axError.Title.String = 'Discrepancy: Percent Error';
    axError.XLabel.String = 'Crank Angle (deg)';
    axError.YLabel.String = '% Error';
    axError.FontSize = 11;
    axError.Box = 'on';
    axError.NextPlot = 'add';

    % Add a small footer note
    footerLabel = uilabel(mainGrid);
    footerLabel.Layout = [3 1 4 1];
    footerLabel.Text = 'FEA data is loaded from the MechanismTake3.rpt file in FEA Model/Working Model Dynamic.';
    footerLabel.FontSize = 10;
    footerLabel.FontAngle = 'italic';
    footerLabel.HorizontalAlignment = 'left';
    footerLabel.WordWrap = 'on';

    % Load the FEA dataset once
    [feaAngle, feaAngleDeg, feaDisp, feaTorque, loadMessage] = loadFEAData();
    resultsText.Value = [loadMessage; resultsText.Value];

    updatePlots();

    % Nested helpers
    function addControl(labelText, defaultValue, suffix, row, isReadOnly)
        if nargin < 5
            isReadOnly = false;
        end
        label = uilabel(controlGrid);
        label.Text = labelText;
        label.FontSize = 11;
        label.Layout = [row 1 1 1];
        if isReadOnly
            field = uilabel(controlGrid);
            field.Text = defaultValue;
            field.FontSize = 11;
            field.Layout = [row 2 1 1];
        else
            field = uieditfield(controlGrid, 'numeric');
            field.Value = str2double(defaultValue);
            field.FontSize = 11;
            field.Layout = [row 2 1 1];
        end
        field.Tooltip = suffix;
        setappdata(appFig, labelText, field);
    end

    function updatePlots()
        appFig.Pointer = 'watch';
        drawnow;

        params.r1 = getappdata(appFig, 'Crank length r_1').Value;
        params.Lc = getappdata(appFig, 'Coupler length L_c').Value;
        params.offset = getappdata(appFig, 'Offset').Value;
        params.Kb = getappdata(appFig, 'Beam parameter K_b').Value;
        params.EI = getappdata(appFig, 'Flexural rigidity E I').Value;

        [prbAngleRad, prbAngleDeg, prbDisp, prbTorque] = computePRBModel(params, feaAngle);

        cla(axDisp);
        plot(axDisp, feaAngle, feaDisp, '-o', 'MarkerSize', 6, 'Color', [0 0.4470 0.7410], 'DisplayName', 'FEA');
        hold(axDisp, 'on');
        plot(axDisp, prbAngleRad, prbDisp, '-', 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], 'DisplayName', 'PRB');
        hold(axDisp, 'off');
        legend(axDisp, 'Location', 'best');
        grid(axDisp, 'on');

        cla(axTorque);
        plot(axTorque, feaAngleDeg, feaTorque, '-o', 'MarkerSize', 6, 'Color', [0 0.4470 0.7410], 'DisplayName', 'FEA');
        hold(axTorque, 'on');
        plot(axTorque, prbAngleDeg, prbTorque, '-', 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], 'DisplayName', 'PRB');
        hold(axTorque, 'off');
        legend(axTorque, 'Location', 'best');
        grid(axTorque, 'on');

        [percentErrorDisp, percentErrorTorque, avgDisp, avgTorque, maxDisp, maxTorque] = ...
            computeDiscrepancy(feaAngle, feaAngleDeg, feaDisp, feaTorque, prbAngleRad, prbAngleDeg, prbDisp, prbTorque);

        cla(axError);
        plot(axError, feaAngleDeg, percentErrorDisp, '-o', 'MarkerSize', 6, 'Color', [0.3010 0.7450 0.9330], 'DisplayName', 'Displacement % Error');
        hold(axError, 'on');
        plot(axError, feaAngleDeg, percentErrorTorque, '-s', 'MarkerSize', 6, 'Color', [0.9290 0.6940 0.1250], 'DisplayName', 'Torque % Error');
        hold(axError, 'off');
        legend(axError, 'Location', 'best');
        grid(axError, 'on');

        resultsText.Value = {
            sprintf('Average displacement error: %.2f%%', avgDisp);
            sprintf('Average torque error: %.2f%%', avgTorque);
            sprintf('Maximum displacement error: %.2f%%', maxDisp);
            sprintf('Maximum torque error: %.2f%%', maxTorque);
            '';
            'Note: FEA data is a validated surrogate from MechanismTake3.rpt.'};
        appFig.Pointer = 'arrow';
    end
end

function [feaAngle, feaAngleDeg, feaDisp, feaTorque, message] = loadFEAData()
    scriptDir = fileparts(mfilename('fullpath'));
    rptPath = fullfile(scriptDir, '..', 'FEA Model', 'Working Model Dynamic', 'MechanismTake3.rpt');
    if ~isfile(rptPath)
        error('FEA report file not found: %s', rptPath);
    end

    dataMatrix = readmatrix(rptPath, 'FileType', 'text', 'NumHeaderLines', 2, 'Delimiter', ' ');
    if isempty(dataMatrix)
        error('No numeric data could be read from %s', rptPath);
    end

    feaAngle = dataMatrix(:, 4);
    feaTorque = dataMatrix(:, 2);
    feaDisp = dataMatrix(:, 3);
    feaAngleDeg = rad2deg(feaAngle);
    message = {sprintf('Loaded %d FEA data points from:', numel(feaAngle)); rptPath};
end

function [prbAngleRad, prbAngleDeg, x_slider, prbTorque] = computePRBModel(params, feaAngle)
    r1 = params.r1;
    Lc = params.Lc;
    offset = params.offset;
    Kb = params.Kb;
    EI = params.EI;
    K_theta = 12.7 * EI / Lc;

    phi1_range = linspace(min(feaAngle), max(feaAngle), 500);

    param_x = @(Theta) Lc * (1 - (2*Kb/pi)*sin(Theta/2)) .* cos(Theta);
    param_y = @(Theta) Lc * (1 - (2*Kb/pi)*sin(Theta/2)) .* sin(Theta);
    y_tip_func = @(Theta, phi1) offset + r1*sin(phi1) + param_y(Theta);

    Theta_sol = zeros(size(phi1_range));
    Theta_prev = 0.5;
    Theta_grid = linspace(-pi, pi, 2001);
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
    end

    x_slider = r1*cos(phi1_range) + param_x(Theta_sol);
    x_slider = x_slider - x_slider(1);
    prbTorque = -K_theta * Theta_sol .* gradient(Theta_sol, phi1_range);

    prbAngleRad = phi1_range;
    prbAngleDeg = rad2deg(prbAngleRad);
end

function [pctDisp, pctTorque, avgDisp, avgTorque, maxDisp, maxTorque] = computeDiscrepancy(feaAngle, feaAngleDeg, feaDisp, feaTorque, prbAngleRad, prbAngleDeg, prbDisp, prbTorque)
    prbDispInterp = interp1(prbAngleRad, prbDisp, feaAngle, 'linear', 'extrap');
    prbTorqueInterp = interp1(prbAngleDeg, prbTorque, feaAngleDeg, 'linear', 'extrap');

    pctDisp = abs(feaDisp - prbDispInterp) ./ max(abs(prbDispInterp), eps) * 100;
    pctTorque = abs(feaTorque - prbTorqueInterp) ./ max(abs(prbTorqueInterp), eps) * 100;

    avgDisp = mean(pctDisp);
    avgTorque = mean(pctTorque);
    maxDisp = max(pctDisp);
    maxTorque = max(pctTorque);
end