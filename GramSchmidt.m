function[V] = GramSchmidt(U, threshold)
    
    % due to rounding errors some zero values may end up being very small
    % numbers, the threshold ensures that they are properly zeroed. Default
    % is set to 1e-10
    if nargin < 2
        threshold = 1e-10;
    end
    
    % Create a matrix for the V set that is the same size as the input set
    V = zeros(size(U,1), size(U,2));
    
    % iterate over each of the vectors in the set
    for i = 1 : size(U, 2)
        % only for the first vector
        if i == 1
            V(:, i) = U(:, i) / norm(U(:, i));
            
        % for all other vectors
        else
            % subtract each instance form the currect vector v
            V(:, i) = U(:, i);
            for k = 1 : i-1                
                V(:, i) = V(:, i) - (U(:, i)'*V(:, k))*V(:, k);
            end
            
            % dividing 0/0 will throw up a NaN error affecting all
            % consecutive vectors, so explicitly declare zero vector if
            % this happens
            if abs(V(:,i)) < threshold*ones(size(V,1),1)
                V(:,i) = zeros(size(V,1),1);
            end
            V(:, i) = V(:, i) / norm(V(:,i));
        end
        
        % 0/0 will = NaN which will affect consecutive calculations. This
        % statement ensurs that 0/0 = 0
        if isnan(norm(V(:,i)))
                V(:,i) = zeros(size(V,1),1);
        end   
    end
    
    % remove any zero vectors
    V( :, all(~V,1) ) = [];
    
end