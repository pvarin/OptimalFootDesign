addpath ..

% test 1
X = [1,1,2,3,4,5];
x = 2.5;
index = 3;

i = get_predecessor_index(X,x);
if  i~= index
    error('test 1 failed expected %i got %i',index,i)
end

% test 2
X = [1,1,2,3,4,5];
x = 2;
index = 3;

i = get_predecessor_index(X,x);
if  i~= index
    error('test 2 failed expected %i got %i',index,i)
end

% test 3
X = [1,2,3,4,5,6,7];
x = 5;
index = 5;

i = get_predecessor_index(X,x);
if  i~= index
    error('test 3 failed expected %i got %i',index,i)
end

% test 4
X = [1,2,3,4,5,6,7];
x = 7;
index = 7;

i = get_predecessor_index(X,x);
if  i~= index
    error('test 4 failed expected %i got %i',index,i)
end

% test 5
X = [1,2,3,4,5,6,7];
x = 1;
index = 1;

i = get_predecessor_index(X,x);
if  i~= index
    error('test 5 failed expected %i got %i',index,i)
end

% test 6
X = [1,2,3,4,5,6,7];
x = 0;
index = 0;

i = get_predecessor_index(X,x);
if  i~= index
    error('test 6 failed expected %i got %i',index,i)
end

% test 7
X = [1,2,3,4,5,6,7];
x = 8;
index = 7;

i = get_predecessor_index(X,x);
if  i~= index
    error('test 7 failed expected %i got %i',index,i)
end

disp('all tests passed')