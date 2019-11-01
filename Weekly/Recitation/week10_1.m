N     = 5; % Number of subdivisions for total volume
r     = linspace(0,1,N);
theta = linspace(0,pi,N);
phi   = linspace(0,2*pi,N);

i = 3; j = 2; k = 2;  % index of subdivisions
n = 10; % number of subdivisions for subvolume

subplot(1,2,1);
[R,Theta] = meshgrid(linspace(r(i),r(i+1),n), linspace(theta(j),theta(j+1),n));
Phi     = phi(k)*ones(size(R));
surf(R,Theta,Phi,'facealpha', .5, 'facecolor', 'r', 'edgecolor', 'none')
hold on;
subplot(1,2,2);
[X,Y,Z] = sphericalCoordinate(R,Theta,Phi);
surf(X,Y,Z,'facealpha', .5, 'facecolor', 'r', 'edgecolor', 'none')
hold on;
subplot(1,2,1);
Phi     = phi(k+1)*ones(size(R));
surf(R,Theta,Phi,'facealpha', .5, 'facecolor', 'r', 'edgecolor', 'none')
subplot(1,2,2);
[X,Y,Z] = sphericalCoordinate(R,Theta,Phi);
surf(X,Y,Z,'facealpha', .5, 'facecolor', 'r', 'edgecolor', 'none')

subplot(1,2,1)
[Theta,Phi] = meshgrid(linspace(theta(j),theta(j+1),n), linspace(phi(k),phi(k+1),n));
R     = r(i)*ones(size(Theta));
surf(R,Theta,Phi,'facealpha', .5, 'facecolor', 'g', 'edgecolor', 'none')
subplot(1,2,2);
[X,Y,Z] = sphericalCoordinate(R,Theta,Phi);
surf(X,Y,Z,'facealpha', .5, 'facecolor', 'g', 'edgecolor', 'none')
subplot(1,2,1);
R     = r(i+1)*ones(size(R));
surf(R,Theta,Phi,'facealpha', .5, 'facecolor', 'g', 'edgecolor', 'none')
subplot(1,2,2);
[X,Y,Z] = sphericalCoordinate(R,Theta,Phi);
surf(X,Y,Z,'facealpha', .5, 'facecolor', 'g', 'edgecolor', 'none')

subplot(1,2,1)
[Phi,R] = meshgrid(linspace(phi(k),phi(k+1),n), linspace(r(i),r(i+1),n));
Theta     = theta(j)*ones(size(Phi));
surf(R,Theta,Phi,'facealpha', .5, 'facecolor', 'b', 'edgecolor', 'none')
subplot(1,2,2);
[X,Y,Z] = sphericalCoordinate(R,Theta,Phi);
surf(X,Y,Z,'facealpha', .5, 'facecolor', 'b', 'edgecolor', 'none')
subplot(1,2,1)
Theta     = theta(j+1)*ones(size(Phi));
surf(R,Theta,Phi,'facealpha', .5, 'facecolor', 'b', 'edgecolor', 'none')
hold off;
axis equal;
axis([0,1,0,pi,0,2*pi])
title([num2str(k), 'th cube in (r,\theta,\phi)-space'], 'fontsize', 20)
xlabel('r', 'fontsize', 20); 
ylabel('\theta', 'fontsize', 20); 
zlabel('\phi', 'fontsize', 20);
subplot(1,2,2)
[X,Y,Z] = sphericalCoordinate(R,Theta,Phi);
surf(X,Y,Z,'facealpha', .5, 'facecolor', 'b', 'edgecolor', 'none')
hold off;
axis equal;
axis([-1,1,-1,1,-1,1]);
title(['Corresponding volume in (x,y,z)-space'], 'fontsize', 20)
xlabel('x', 'fontsize', 20); 
ylabel('y', 'fontsize', 20); 
zlabel('z', 'fontsize', 20);

function [x,y,z] = sphericalCoordinate(r,theta,phi)
    x = r.*sin(theta).*cos(phi);
    y = r.*sin(theta).*sin(phi);
    z = r.*cos(theta);
end