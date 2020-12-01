function rowAdd(filename)
    data = csvread(filename, 1, 0);
    indexFile = 1;
    indexNew = 1;
    while indexFile <= length(data)
        if indexNew ~= 1 && newData(indexNew-1,2) == 10
            newData(indexNew,:) = [newData(indexNew-1,1),11,0,0,0,0,0];
            indexNew = indexNew + 1;
        else
            newData(indexNew,:) = data(indexFile,:);
            indexNew = indexNew + 1;
            indexFile = indexFile + 1;
        end
    end
    csvwrite("new.csv",newData);
end