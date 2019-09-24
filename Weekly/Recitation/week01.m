%% problem 1.

v = [ sqrt(2), log(5) / (1 + tand(50)), asin(.5) ] ;
w = [ exp(cos(sqrt(2))), asinh(1), log(2)/log(5) ] ;

dot(v,w)

%% problem 2.

x1 = [ 1, 2, 0 ];
x2 = [ -2, 5, -1 ];
x3 = [ 2, -3, 1 ];

det([x1;x2;x3])

%% problem 3.

a1 = ones(1, 64);
a1 = [ a1 2*a1 3*a1 4*a1 ];

a2 = ones(1, 16);
a2 = [ a2 2*a2 3*a2 4*a2 ];
a2 = repmat(a2, 1, 4);

a3 = ones(1, 4);
a3 = [ a3 2*a3 3*a3 4*a3 ];
a3 = repmat(a3, 1, 16);

a4 = repmat(1:4, 1, 64);

A = [a1; a2; a3; a4];
A = A'

%% problem 4.

string(char(97:122))