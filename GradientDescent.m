function [c0,c1] = ...
    GradientDescent(x, y, c0, c1, learning_rate_c0, learning_rate_c1)
    
    % Default Learning rates
    if nargin < 5
        learning_rate_c0 = 1e-9;
        learning_rate_c1 = 1e-12;
    elseif nargin < 6
        learning_rate_c1 = 1e-12;
    end
    
    % set arbitatry initials
    R2_ = 1e100;
    R2_diff = 1;

    % start timer
    tic
    
    % begin iteration counter
    iterations = 0;
    
    % run loop whilst old sum R^2 minus new sum R^2 is still positive
    while R2_diff > 0
        
        % increment interation count
        iterations = iterations + 1;
        
        R2 = 0;         % Reset sum of R^2
        df_dc0 = 0;     % Reset sum of df/dc0
        df_dc1 = 0;     % Reset sum of df/dc1

        % Conduct new R^2, df/dc0 and df/dc2 summations
        for i = 1:length(x)
            R2 = R2 + 0.5 * (y(i) - c0*exp(c1*x(i)))^2;
            df_dc0 = df_dc0 - exp(c1*x(i))*(y(i) - c0*exp(c1*x(i)));
            df_dc1 = df_dc1 - c0*exp(c1*x(i))*x(i)*(y(i) - c0*exp(c1*x(i)));
        end
        
        % Find the difference between the old R^2 and new R^2
        R2_diff = R2_ - R2;

        % Calculate the new step size for c0 and c1
        step_size_c0 = df_dc0 * learning_rate_c0;
        step_size_c1 = df_dc1 * learning_rate_c1;

        % compute new values of c0 and c1
        c0 = c0 - step_size_c0;
        c1 = c1 - step_size_c1;

        % set the current R^2 value as the old R^2 value
        R2_ = R2;
    end
    
    disp(['TIME TAKEN: ', num2str(toc), ' s']);
    disp(['ITERATIONS: ', num2str(iterations)]);
    disp(['MIN SUM R^2: ', num2str(R2)]);
    disp(['c0: ', num2str(c0)]);
    disp(['c1: ', num2str(c1)]);
end
