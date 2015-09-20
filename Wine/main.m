%Main index file 
clear;
close all;

tic 

filename = 'wine.data.txt';
A = dlmread(filename, ',');
nrows = size(A, 1);
randrows = randperm(nrows);

%Normalization of features
%This doesn't allow one feature to dominate when sorting is done by
%euclidean distance

for i = 2 : size(A, 2)
    A(:, i) = A(:, i) / max(A(:, i));
end

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