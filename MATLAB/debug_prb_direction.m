% debug_prb_direction  Inspect PRB slider displacement direction
r1 = 3.0; Lc = 5.0; offset = 0.5; Kb = 0.85;
phi1_range = linspace(0, 1.00035, 1000);
param_x = @(Theta) Lc * (1 - (2*Kb/pi)*sin(Theta/2)) .* cos(Theta);
param_y = @(Theta) Lc * (1 - (2*Kb/pi)*sin(Theta/2)) .* sin(Theta);
y_tip_func = @(Theta, phi1) offset + r1*sin(phi1) + param_y(Theta);
Theta_sol = zeros(size(phi1_range));
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
end
x_slider = r1*cos(phi1_range) + param_x(Theta_sol);
fileID = fopen('C:/Users/merrifield.12/OneDrive - The Ohio State University/classes/MECHENG 7751 Advanced Kinematics and Mechanics/project 2/MATLAB/prb_debug.txt','w');
fprintf(fileID,'phi1,x_slider\n');
for i = 1:length(phi1_range)
    fprintf(fileID,'%.10f,%.10f\n',phi1_range(i), x_slider(i));
end
fclose(fileID);
disp('Debug file written to prb_debug.txt');
