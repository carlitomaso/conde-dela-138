clc, clearvars, close all

function A = get_ref(A)
   [m, n] = size(A);
    row = 1;          
    for col = 1:n
        [~, pivotRow] = max(abs(A(row:m, col)));
        pivotRow = pivotRow + row - 1;
        if A(pivotRow, col) ~= 0
            A([row, pivotRow], :) = A([pivotRow, row], :);
            A(row, :) = A(row, :) / A(row, col);
            for i = row + 1:m
                A(i, :) = A(i, :) - A(i, col) * A(row, :);
            end
            row = row + 1;
        end
    end
end

function A = get_rref(A)
    [m, n] = size(A);
    i = n;
    j = m;
    r = m - 1;
    while r > 0
        if A(r + 1,:) == zeros(1,n)
            r = r -1;
            continue
        end
        if A(r+1,i) ~= 0
            i = i -1;
            continue
        end
        for row = 1:r
            A(row, i+2:n) = A(row, i+2:n) - A(row, i+1)*A(r + 1, i+2:n);
            A(row, i+1) = 0;
            %disp(A)
        end
        r = r-1;
        
    end
end

function basis = rrefToBasis(rref)

    ps = rref(1:end, end); % matr that contains particular soln 
    coe = rref(1:end, 1:end-1); % contains the coefficients of the rref 
    % disp(ps);
    % disp(coe);
    [m,n] = size(coe);
    term = ps;

    % determines whether is a leading row (1 if leading, 0 if not)
    is_leading = ones(n, 1); 

    % looks at each col for nonzero and non-one numbers
    for j=1:n %travels each col
        for i=1:m %traverses each elem in the col

            % if we found an element greater than 1 in each row, put it
            % into new term matrix (term matrix shall contain non leading rows)
            % save the indexes of leading columns
            %disp(coe(i,j));
            if (coe(i, j)) > 1 || (coe(i, j)) < 0
                term = [term -1*coe(1:end, j)];
                % disp(term);
                is_leading(j, 1) = 0;
                break;
            end
        end
    end
    
    % creates the basis matrix using the initial basis column
    [~, n_basis] = size(term);
    basis = zeros(n, n_basis);
    % disp(is_leading);
    tdx = 1; % index for the term matrix
    ndx = 2; % index for the non leading term, skip part soln matr, this starting at 2
    for row=1:n
        % is a column with a leading entry
        % disp(is_leading(row, 1));
        if is_leading(row, 1) == 1
            % disp(term(tdx, 1:end));
            basis(row, 1:end) = [term(tdx, 1:end)];
            tdx = tdx + 1;
            continue;
        end
        % if non-leading
        basis(row, ndx) = 1;
        ndx = ndx + 1;

    end
    disp(basis);
end

A = [
    2  -4   6   8  -10  12;
    1   0.5 -3   2   3.5 -4.5;
    3   6   9  -12  15   18;
    5  -10  15  20 -25   30;
    4   8  -12  16  20  -24
];
b = [1 5 4]';
disp("builtin")
disp(rref(A))

A = get_ref(A);
A = get_rref(A);

disp("homemade")
disp(A);
