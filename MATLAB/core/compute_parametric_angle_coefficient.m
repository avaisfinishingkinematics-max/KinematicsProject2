function c_e = compute_parametric_angle_coefficient(n)
    % Compute parametric angle coefficient c_e based on load ratio
    % Based on Howell & Midha Table 1
    %
    % Inputs:
    %   n: load ratio
    %
    % Outputs:
    %   c_e: parametric angle coefficient
    
    % Values from Table 1 of the paper
    n_table = [0.0, 0.5, 1.0, 1.5, 2.0, 3.0, 5.0, 10.0];
    c_e_table = [1.2385, 1.2430, 1.2467, 1.2492, 1.2511, 1.2534, 1.2557, 1.2578];
    
    % Linear interpolation for intermediate values
    c_e = interp1(n_table, c_e_table, n, 'linear', 'extrap');
end
