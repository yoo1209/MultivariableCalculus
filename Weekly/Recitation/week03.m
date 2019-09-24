%% week3 recitation

%% problem 1

% Anonymous
f1 = @(x,y) x.^2 + y.^2;

% Inline
f2 = inline('x.^2 + y.^2');

% Function을 이용한 정의는 스크립드 실행상 맨 마지막에 넣음

%% problem 2

x = linspace(-2,2);
plot(x, x.^2 - x + 1)

%% problem 3

x = linspace(-1,1);
y = x;
[X,Y] = meshgrid(x,y);
Z = X.^2 - Y.^2;
surf(X,Y,Z)

%% problem 4

fimplicit(@(x,y) x.^2 + 2*y.^2 - 1)

%% problem 5


fimplicit3(@(x,y,z) x.^3 + y.^3 + z.^3 - 1)

%% problem 6

A = [ 2 5 ;
      -1 0 ;
      3 1 ] ;
triangle(A)

%%

% Function from problem 1
function z = f3(x,y)
    z = x.^2 + y.^2;
end

% problem 6
function triangle(A)
    A = [A ; A(1,:)];
    plot(A(:,1),A(:,2))
end

function triangle_fill(A)
    A = [A ; A(1,:)];
    fill(A(:,1),A(:,2),'r')
end