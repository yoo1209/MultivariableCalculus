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

%% Confirm Stokes' theorem
X1(r,t,p) = [ r*sin(t)*cos(p), r*sin(t)*sin(p), r*cos(t) ]; 
X1sub(t,p) = subs( X1(r,t,p), r, 1 ); % Parametrize sphere
curlFX1(t,p) = subs( curl(F(x,y,z)), [x,y,z], X1sub(t,p) );
Integrand(t,p) = dot( curlFX1(t,p), cross( diff(X1sub(t,p),t), diff(X1sub(t,p),p) ) );
tMax(p) = acos( ( -1 + sqrt( 1 + 4*cos(2*p)^2 ) ) / ( 2*cos(2*p) ) ) ;

integrand = matlabFunction( Integrand(t,p), 'Vars', [p,t] );
tmax = matlabFunction( tMax(p) );
curlFluxS1 = integral2(integrand, 0, 2*pi, 0, tmax) % Compute flux of curl over sphere

X2(r,t,z) = [ r*cos(t), r*sin(t), z ];
X2sub(r,t) = subs( X2(r,t,z), z, r^2*cos(2*t) );
curlFX2(r,t) = subs( curl(F(x,y,z)), [x,y,z], X2sub(r,t) );
Integrand = dot( curlFX2(r,t), cross( diff(X2sub(r,t),r), diff(X2sub(r,t),t) ) );
rMax(t) = sqrt( (sqrt(1+4*cos(2*t)^2)-1) / (2*cos(2*t)^2) );
integrand = matlabFunction( Integrand, 'Vars', [t,r] );
rmax = matlabFunction( rMax(t) );
curlFluxS2 = integral2(integrand, 0, 2*pi, 0, rmax) % Compute flux of curl over saddle

C(p) = subs( X1sub(t,p), t, tMax(p) );
Fp(p) = subs(F(x,y,z), [x,y,z], C(p));
Integrand = dot( Fp(p), diff(C(p),p) );
integrand = matlabFunction( Integrand );
lineIntC = integral(integrand, 0, 2*pi) % Compute line integral along intersection

%% Confirm Divergence theorem
FX1(t,p) = subs( F(x,y,z), [x,y,z], X1sub(t,p) );
Integrand(t,p) = dot( FX1(t,p), cross( diff(X1sub(t,p),t), diff(X1sub(t,p),p) ) );
tMax(p) = acos( ( -1 + sqrt( 1 + 4*cos(2*p)^2 ) ) / ( 2*cos(2*p) ) ) ;
integrand = matlabFunction( Integrand(t,p), 'Vars', [p,t] );
tmax = matlabFunction( tMax(p) );
fluxS1 = integral2(integrand, 0, 2*pi, 0, tmax) % Compute flux over sphere

FX2(r,t) = subs( F(x,y,z), [x,y,z], X2sub(r,t) );
Integrand(r,t) = dot( FX2(r,t), cross( diff(X2sub(r,t),t), diff(X2sub(r,t),r) ) );
rMax(t) = sqrt( (sqrt(1+4*cos(2*t)^2) -1) / (2*cos(2*t)^2) );
integrand = matlabFunction( Integrand, 'Vars', [t,r] );
rmax = matlabFunction( rMax(t) );
fluxS2 = integral2(integrand, 0, 2*pi, 0, rmax) % Compute flux over saddle

Integrand = subs( divergence(F(x,y,z)), [x,y,z], X1(r,t,p) ) * abs(det(jacobian(X1)));
integrand = matlabFunction( Integrand, 'Vars', [p,r,t] );
tMax(p,r) = acos( ( -1 + sqrt( 1 + 4*cos(2*p)^2 ) ) / ( 2*cos(2*p) ) ) ;
tmax = matlabFunction( tMax(p,r), 'Vars', [p,r] );
volDiv = integral3( integrand, 0, 2*pi, 0, 1, 0, tmax)
fluxS1 + fluxS2
