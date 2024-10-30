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