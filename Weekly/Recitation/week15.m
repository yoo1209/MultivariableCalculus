%% Exercise 3

%% #1(a)
clear all
[x,y,z] = sphere(50);
surf(x,y,z); hold on;
[x,y] = meshgrid(linspace(-1,1,50));
surf(x,y,x.^2-y.^2+1/2); 
p = linspace(0,2*pi);
t = acos((-1+sqrt(1+4*cos(2*p).*(1/2+cos(2*p))))./(2*cos(2*p)));
plot3(sin(t).*cos(p),sin(t).*sin(p),cos(t),'r','linewidth',2); hold off;
axis equal;

%% #1(c)
clear all
rmin = @(p,t) (cos(t)-sqrt(cos(t).^2-4/2*sin(t).^2.*cos(2*p)))./(2*sin(t).^2.*cos(2*p));
tmax = @(p) acos((-1+sqrt(1+4*cos(2*p).*(1/2+cos(2*p))))./(2*cos(2*p)));
f = @(p,t,r) 2*sin(t) + cos(t)./r;
integral3(f,0,2*pi,0,tmax,rmin,1)

%% #2(b)
clear all
syms x y l
f(x,y) = -x^2+3*x*y-2*y^2;
g(x,y) = 2*x^2-6*x*y+5*y^2;
eqn = [g(x,y)==1; gradient(f)==l*gradient(g)];
sol = solve(eqn,[x,y,l]);
[sol.x,sol.y,f(sol.x,sol.y)]

f = matlabFunction(f,'vars',[x,y]);
t = linspace(0,2*pi);
A = [ 1 -3/2 ; 0 1 ];
X = inv(A)*[cos(t)/sqrt(2); sqrt(2)*sin(t)];
plot3(X(1,:),X(2,:),f(X(1,:),X(2,:)),'r','linewidth',2); hold on;
[r,t] = meshgrid(linspace(0,1,20),linspace(0,2*pi,50));
x = r.*cos(t)/sqrt(2) + 3/2*sqrt(2)*r.*sin(t);
y = sqrt(2)*r.*sin(t);
z = f(x,y);
surf(x,y,z); hold off;

%% #2(c)
clear all
fimplicit3(@(x,y,z)x.^3+y.^2+z-2); hold on;
[x,y,z] = sphere(50);
surf(x,y,z); 
axis equal;

f = @(x,y,z) x.^2+y.^2+z.^2;
lambda = fzero(@(t)27*t^4-54*t^3+16,.2);
X = [ 0, 0, 2, 4 ;
    2/3/lambda, 0, 2-(2/3/lambda)^2, lambda ;
    2/3, -sqrt(65/54), 1/2, 1 ;
    2/3, sqrt(65/54), 1/2, 1 ;
    0, -sqrt(3/2), 1/2, 1;
    0, sqrt(3/2), 1/2, 1 ]; % This is minimum point
sqrt(f(X(:,1),X(:,2),X(:,3)))
plot3(X(1:4,1),X(1:4,2),X(1:4,3),'.b','markersize',20); 
plot3(X(5:6,1),X(5:6,2),X(5:6,3),'.r','markersize',20); hold off;
xlabel('x');