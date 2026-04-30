function gamma = compute_characteristic_radius_factor(n, max_error_percent, delta_theta_step)
    % Optimize characteristic radius factor gamma using Golden Section method
    % Based on Howell & Midha Section "One-Dimensional Optimization"
    %
    % Inputs:
    %   n: load ratio
    %   max_error_percent: maximum allowed relative error (default 0.5%)
    %   delta_theta_step: angular deflection step size in degrees (default 0.1)
    %
    % Outputs:
    %   gamma: optimized characteristic radius factor
    
    if nargin < 2
        max_error_percent = 0.5;
    end
    if nargin < 3
        delta_theta_step = 0.1;
    end
    
    % Golden Section method parameters
    c = (sqrt(5) - 1) / 2;  % Golden ratio conjugate ≈ 0.382
    
    % Initial interval of uncertainty for gamma
    gamma_left = 0.5;
    gamma_right = 1.0;
    L_interval = gamma_right - gamma_left;
    
    % Tolerance for convergence
    tol = 1e-6;
    max_iterations = 100;
    iteration = 0;
    
    while L_interval > tol && iteration < max_iterations
        iteration = iteration + 1;
        
        % Compute test points
        gamma_1 = gamma_right - c * L_interval;
        gamma_2 = gamma_left + c * L_interval;
        
        % Evaluate objective function at test points
        f1 = objective_function_gamma(gamma_1, n, max_error_percent, delta_theta_step);
        f2 = objective_function_gamma(gamma_2, n, max_error_percent, delta_theta_step);
        
        % Eliminate portion of interval
        if f1 > f2
            gamma_left = gamma_1;
        else
            gamma_right = gamma_2;
        end
        
        L_interval = gamma_right - gamma_left;
    end
    
    gamma = (gamma_left + gamma_right) / 2;
end

function theta_o_max = objective_function_gamma(gamma, n, max_error_percent, delta_theta_step)
    % Objective function for gamma optimization
    % Finds maximum theta_o for given gamma that satisfies error constraint
    
    theta_o = 0;
    delta_theta = delta_theta_step * pi / 180;  % Convert to radians
    max_error_relative = max_error_percent / 100;
    
    while theta_o < 2  % Up to ~115 degrees
        theta_o = theta_o + delta_theta;
        
        % Compute beam end coordinates using elliptic integral
        [a_exact, b_exact] = compute_beam_deflection(theta_o, n, 1, 1, 1);
        
        % Compute pseudo-rigid-body angle
        theta_prb = atan2(b_exact, a_exact - gamma * (1 - cos(theta_o)));
        
        % Compute PRB coordinates
        a_prb = gamma * (1 - cos(theta_prb));
        b_prb = gamma * sin(theta_prb);
        
        % Compute error
        b_e = sqrt(a_exact^2 + b_exact^2);
        b_a = sqrt(a_prb^2 + b_prb^2);
        
        error_deflection = abs(b_e - b_a);
        
        % Relative error
        if b_e > 0
            error_relative = error_deflection / b_e;
        else
            error_relative = 0;
        end
        
        % Check if error exceeds maximum
        if error_relative > max_error_relative
            break
        end
    end
    
    theta_o_max = theta_o;
end

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
    theta_o_max_deg = 0.85 * atand(-1/n);  % in degrees
    theta_o_max_fit = deg2rad(theta_o_max_deg);
end

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

function [x, y, theta_o_param, omega_squared] = prb_parametric_model(theta_prb, gamma, L, EI, P, n)
    % Compute PRB parametric approximation coordinates
    % Based on Howell & Midha equations (28), (29)
    %
    % Inputs:
    %   theta_prb: pseudo-rigid-body angle (rad)
    %   gamma: characteristic radius factor
    %   L: beam length
    %   EI: flexural rigidity
    %   P: horizontal load
    %   n: load ratio (vertical/horizontal)
    %
    % Outputs:
    %   x: horizontal displacement
    %   y: vertical displacement
    %   theta_o_param: beam end angular deflection (parameterized)
    %   omega_squared: load index squared
    
    % Parametric coordinates (Eq 28, 29)
    x = L * gamma * (1 - cos(theta_prb));
    y = L * gamma * sin(theta_prb);
    
    % Parameterized beam end angular deflection
    c_e = compute_parametric_angle_coefficient(n);
    theta_o_param = theta_prb / c_e;
    
    % Load index (Eq 9)
    omega_squared = (P^2) / (EI);
end
