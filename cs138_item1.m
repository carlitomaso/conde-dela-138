%given
matrix = [1 -2 -1 3; 2 -4 1 0; 1 -2 2 -3];
solution = [1; 5; 4];

sample = [10 3 1; 3 10 2; 1 2 10];
sample_source = [19;29;35];

% gets the RREF of a matrix
function aug = naiveGaussJordanCalculator(matr, soln)
    aug = [matr soln]; % augmented matrix
    N = length(soln); % size of the matrix
    disp(aug)

    for col=1:N %for columns
        aug(col,:) = aug(col,:)/aug(col,col);
        for row=1:N %for rows
            if col ~= row
                multiple = aug(row, col);
                aug(row,:) = aug(row, :) - multiple*aug(col,:);
                disp(multiple)
            end
            disp(aug)
        end
    end
end


% gets the RREF of a matrix using gaussian elim. with pivoting
function aug = pivotedGaussJordanCalculator(matr, soln)
    aug = [matr soln]; % augmented matrix
    N = size(matr, 1); % size of the matrix
    disp(aug)

    for col=1:N %for columns

        % obtaining the index of the largest magnitude
        [~,k] = max(abs(aug(col:end, col)));
        k = (col-1)+k(1);

        % ERO 1
        aug([col, k],col:end) = aug([k, col],col:end);

        % ERO 2
        aug(col, col:end) = aug(col,col:end)/aug(col,col);
           
        for row=col+1:N %for rows
            if abs(aug(row, col)) < 1E-10
                aug(col,row) = 0;
                continue;
            end
            
            % ERO 3
            aug(row, col:end)=aug(row, col:end) - aug(row, col) * aug(col, col:end);
        end
    end
    % REF [A|b]
    disp(aug);

    % perform backward sub
    x = aug(:, end);
    for i=N-1:-1:1
        x(i) = x(i) - aug(i, i+1:end-1) * x(i+1:end);
    end
end

disp(matrix);
disp(solution);
disp([matrix solution]);
%x = gaussJordanCalculator(sample, sample_source);
%disp(x);

% x = naiveGaussJordanCalculator(matrix, solution);
x = pivotedGaussJordanCalculator(matrix, solution);
disp(x)


