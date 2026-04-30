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
    if n == 0
        theta_o_max_deg = 90;
    else
        theta_o_max_deg = 0.85 * atand(1 / abs(n));  % in degrees
    end
    theta_o_max_fit = deg2rad(theta_o_max_deg);
end
