%% week 09
clear all
sf = @(x,y) x.^2 + y^2;
vx = @(x,y,z) x;
vy = @(x,y,z) y;
vz = @(x,y,z) z;
vf = {vx, vy, vz};
lim = [0 1 0 1];
flux(vf, sf, lim)

%% compare with symbolic value
syms x y z 
f(x,y) = x^2 + y^2;
fx(x,y) = diff(f,x); fy(x,y) = diff(f,y);
F(x,y,z) = [ x y z ];
F(x,y) = subs(F,[x,y,z],[x,y,f(x,y)]);
int(int(dot(F(x,y), [fx(x,y),fy(x,y),-1]),x,0,1),y,0,1)

%% function FLUX
function v = flux(vf, sf, lim)
    n = 100;
    [x y] = meshgrid(linspace(lim(1),lim(2),n), linspace(lim(3),lim(4),n) );
    v = 0; dx = (lim(2)-lim(1))/(n-1); dy = (lim(4)-lim(3))/(n-1);
    for i = 1 : n-1
        for j = 1 : n-1
            f = [vf{1}(x(i,j),y(i,j),sf(x(i,j),y(i,j))), ...
                 vf{2}(x(i,j),y(i,j),sf(x(i,j),y(i,j))), ... 
                 vf{3}(x(i,j),y(i,j),sf(x(i,j),y(i,j)))];
            ds = [ (sf(x(i,j+1),y(i,j+1)) - sf(x(i,j),y(i,j))) / dx, ...
                   (sf(x(i+1,j),y(i+1,j)) - sf(x(i,j),y(i,j))) / dy, -1 ];
            v = v + dot(f,ds)*dx*dy;
        end
    end
end