%KNN Classifier function

function accur = knnclassifier(traindata, testdata, K)

dist = zeros(size(traindata, 1), 1);
%Find distance with all training datapoints, sort and poll
for i = 1 : size(testdata)
x = testdata(i,:);
    
for j = 2 : size(traindata, 2)  
dist(:, 1) =  dist(:, 1) + (traindata(:, j) - x(j)) .^ 2;
end

dist(:, 1) = sqrt(dist(:, 1));
classes = traindata(:, 1);
dist(:, 2) = classes;
poll = sortrows(dist, 1);

%For tiebreak in case of even K
if (mod(K, 2) == 1)
expclass(i) = mode(poll(1 : K, 2));
else
    temp = poll(1 : K, 2);
    uniq = unique(temp);
    p = size(uniq);
    bincounts = histc(temp, uniq);
    q = max(bincounts);
    %if number of unique elements = 2 && highest frequency is K/2, then there is tie
    M = (p == 2) & (q == K/2);
    %Alloted the class which is at closest distance
    expclass(i) = mode(poll(1 : K - M, 2));    
end
end

%Error percentage calculation
error = transpose(expclass) - testdata(:, 1);
accur = ((size(error, 1) - nnz(error))/size(error, 1));

end
