%Main index file 
clear;
close all;

%Calculation of time of execution
tic

filename = 'ionosphere.data.txt';
A = dataset('File', filename, 'Delimiter', ',', 'ReadVarNames', false);
l = size(A, 2); 

%Assigning classes a unique number for conversion from dataset to matrix
%Even if classes are more in number with randomly arranged datapoints, this method would work

u = unique(A(:, l));
u = dataset2cell(u);
u = u(2 : end, :);
p = [1 : size(u, 1)];
C = containers.Map(u, p);
t = A(:, l);
t = dataset2cell(t);
t = t(2 : end);
A.Var35 = C.values(t);
z = A(:, l);
z = dataset2cell(z);
z = z(2 : end);
z = cell2mat(z);
z = mat2dataset(z);
A(:, l) = z;
A = double(A);

%Generating random permutation for division into test and train data
nrows = size(A, 1);
randrows = randperm(nrows);

%meanaccuracy contains the accuracy data
%rows in meanaccuracy denote fold
%and column denote the corresponding value of K

meanaccuracy = zeros(4, 5);
X = A;
k = [2, 3, 4, 5];
e = zeros(4, 1);
for K = 1 : 5
for fold = 2 : 5
        for chunk = 1 : fold
            chunksize = floor(nrows/fold);
            x = (chunk - 1) * chunksize + 1;
            y = chunk * chunksize;
            testdata = X(randrows(x:y), :);
            if chunk == 1
                traindata = X(randrows(y + 1:end), :);
            elseif chunk == fold
                traindata = X(randrows(1 : x-1), :);
            else
                traindata = X(randrows(1, x-1:y+1, end), :);
            end
            currentacc = knnclassifier(traindata, testdata, K);
            s(chunk) = currentacc;
        end
        meanaccuracy(fold - 1, K) = mean(s);
         out(fold - 1) = mean(s);
         e(fold - 1) = std(s);      
    end
    subplot(3,3, K);
    errorbar(k, out, e); 
    title(['Plot for K = ', num2str(K)])
end

toc
