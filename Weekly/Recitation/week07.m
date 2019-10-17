%% Week 7

%% Problem 1

t = linspace(0,2*pi);
x = (2+cos(2*t)).*cos(3*t);
y = (2+cos(2*t)).*sin(3*t);
z = sin(4*t);

plot3(x,y,z);

%% Fancy up

for i = 1 : 100
    plot3(x,y,z);
    hold on ;
    plot3(x(i),y(i),z(i),'.','markersize',20);
    hold off;
    drawnow;
end

%% Problem 2

[S,T] = meshgrid(linspace(-1,1),linspace(0,2*pi));
X = (2 + S .* cos(T/2)) .* cos(T);
Y = (2 + S .* cos(T/2)) .* sin(T);
Z = S .* sin(T/2);
surf(X,Y,Z);
axis equal;

%% Fancy up

t = linspace(0,4*pi);
x = (2 + cos(t/2)) .* cos(t);
y = (2 + cos(t/2)) .* sin(t);
z = sin(t/2);

for i = 1 : 100
    s = surf(X,Y,Z,'facecolor',[.1,.5,.1], 'edgecolor','none');
    alpha(s,.5);
    axis equal;
    hold on;
    plot3(x(i),y(i),z(i),'.','markersize',40, 'color',[.4,.2,.5]);
    hold off;
    drawnow;
end

%% Problem 3

a = 5; b = 3;
t = linspace(0,2*b*pi);
x = (a-b)*cos(t) + b*cos((a/b-1)*t) ;
y = (a-b)*sin(t) - b*sin((a/b-1)*t);
plot(x,y)
axis equal;

%% Fancy up
theta = linspace(0,2*pi);

for i = 1 : 100
    plot(a*cos(theta), a*sin(theta));
    hold on;
    plot(b*cos(theta) + (a-b)*cos(t(i)), b*sin(theta) + (a-b)*sin(t(i)));
    plot(x(i),y(i),'.','markersize',20);
    plot(x(1:i),y(1:i));
    hold off;
    axis equal;
    drawnow;
end