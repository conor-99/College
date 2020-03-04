% calculate the inverse of a matrix A
function [Ainv] = Inverse(A)
    
    [N, ~] = size(A);   % get the size of the matrix
    Ainv = Identity(N); % construct the identity matrix
    
    % for each row in the (augmented) matrix
    for i = 1:N
        
        % make diagonal column 1
        u = A(i, i);
        for j = 1:N
            A(i, j) = A(i, j) / u;
            Ainv(i, j) = Ainv(i, j) / u;
        end
        
        % make non-diagonal columns 0
        for j = 1:N
            if j ~= i
                v = A(j, i);
                for k = 1:N
                    A(j, k) = A(j, k) - (A(i, k) * v);
                    Ainv(j, k) = Ainv(j, k) - (Ainv(i, k) * v);
                end
            end
        end
        
    end
    
    disp(Ainv);
    
end

% return the identity matrix of size N
function [Imat] = Identity(N)
    Imat = zeros(N, N);
    for i = 1:N
        Imat(i, i) = 1;
    end
end
