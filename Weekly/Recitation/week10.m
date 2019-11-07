%% intersection of the sphere with a saddle

clear all

[x,y,z] = sphere(50);
surf(x,y,z,'facealpha',.5); hold on;
[ t, r ] = meshgrid( linspace(0, 2*pi, 50), linspace(0, 1, 50) );
surf( r.*cos(t), r.*sin(t), r.^2.*cos(t).^2 - r.^2.*sin(t).^2 ); 


phi = linspace(0, 2*pi);
theta = acos( ( -1 + sqrt( 1 + 4*cos(2*phi).^2 ) ) ./ ( 2*cos(2*phi) ) );
plot3(sin(theta).*cos(phi), sin(theta).*sin(phi), cos(theta), 'r', 'linewidth', 4 ); hold off;
axis equal;

syms x y z r t p 
F(x,y,z) = [ x^2*y, cos(y)+x^2, y^2+sin(z) ];
X1(r,t,p) = [ r*sin(t)*cos(p), r*sin(t)*sin(p), r*cos(t) ];
X1(t,p) = subs( X1(r,t,p), r, 1 );
FX1(t,p) = subs( F(x,y,z), [x,y,z], X1(t,p) );
f = matlabFunction( dot( FX1(t,p), cross( diff(X1(t,p),t), diff(X1(t,p),p) ) ), 'Vars', [p,t] );
tmax = @(p) acos( ( -1 + sqrt( 1 + 4*cos(2*p).^2 ) ) ./ ( 2*cos(2*p) ) ) ;
a = integral2(f, 0, 2*pi, 0, tmax)

X2(r,t,z) = [ r*cos(t), r*sin(t), z ];
X2(r,t) = subs( X2(r,t,z), z, r^2*cos(2*t) );
FX2(r,t) = subs( F(x,y,z), [x,y,z], X2(r,t) );
f = matlabFunction( dot( FX2(r,t), cross( diff(X2(r,t),r), diff(X2(r,t),t) ) ), 'Vars', [t,r] );
rmax = @(t) sqrt( (sqrt(1+4*cos(2*t).^2) -1) ./ (2*cos(2*t).^2) );
b = integral2(f, 0, 2*pi, 0, rmax)

X(r,t,z) = [ r*cos(t), r*sin(t), z ];
J = simplify( dot( cross(diff(X(r,t,z),r), diff(X(r,t,z),t)), diff(X(r,t,z),z) ) );
f = matlabFunction( subs( divergence(F(x,y,z)), [x,y,z], X(r,t,z) ) * J, 'Vars', [t,r,z] );
zmin = @(t,r) r.^2.*cos(2*t);
zmax = @(t,r) sqrt(1 - r.^2.*cos(t).^2 - r.^2.*sin(t).^2);
zmaxminus = @(t,r) -sqrt(1 - r.^2.*cos(t).^2 - r.^2.*sin(t).^2);
c = real(...
    integral3(f, 0, 2*pi, 0, rmax, zmin, zmax) + ...
    integral3(f, pi/4, 3*pi/4, rmax, 1, zmaxminus, zmax) + ...
    integral3(f, 5*pi/4, 7*pi/4, rmax, 1, zmaxminus, zmax))
a-b
