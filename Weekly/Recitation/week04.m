%% week 4
%% exercise 1
f = @(x,y) x.^2 + y.^2;
n1 = 10000; n2 = 10000;
x = linspace(0,1,n1); 
y = linspace(0,1,n2);
[X,Y] = meshgrid(x,y);
sum = 0;
for i = 1 : size(X,1)-1
    for j = 1 : size(X,2)-1
        sum = sum + f(X(i,j),Y(i,j))*(1/(n1-1))*(1/(n2-1));
    end
end
sum
integral2(f,0,1,0,1)

%% exercise 2
f = @(x,y) x.*y;
g1 = @(x) x; g2 = @(x) 2*x;
n1 = 1000; n2 = 1000;
x = linspace(0,1,n1); y = linspace(0,2,n2);
[X,Y] = meshgrid(x,y);
sum = 0;
for i = 1 : size(X,1)-1
    for j = 1 : size(X,1)-1
        if Y(i,j) >= g1(X(i,j)) & Y(i,j) <= g2(X(i,j))
            sum = sum + f(X(i,j),Y(i,j))*(1/(n1-1))*(2/(n2-1));
        end
    end
end
sum
integral2(f,0,1,g1,g2)

%% exercise 3
f = @(x,y) x.*y.*sqrt((2*x).^2+(-2*y).^2+1);
integral2(f,-1,1,-1,1)

syms x y
f = x*y;
h = x^2-y^2;
hx = diff(h,x); hy = diff(h,y);
int(int(f*sqrt(hx^2+hy^2+1), x, -1, 1), y, -1, 1)

%% exercise 4

A = [ 0 1 ; 1 1 ; 1 0 ] ;
v = [ 0 0 ];
inner_tri(A,v)

function check = inner_tri(A, v)
    check = 1;
    for i = 0 : 2
        v1 = A(mod(i+1,3)+1,:) - A(i+1,:);
        v2 = A(mod(i+2,3)+1,:) - A(i+1,:);
        vv = v - A(i+1,:);
        T = [v1 ; v2]; T = T';
        t = T \ vv';
        if ~(t(1) >= 0 & t(2) >= 0)
            check = 0;
        end
    end
end


