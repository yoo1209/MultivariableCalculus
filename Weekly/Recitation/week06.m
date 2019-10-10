
%% Computing surface integrals
%% Problem 1 
clear all
syms x y z u v
f(x,y,z) = x-z+sin(y);
X(u,v) = [ sin(u)*cos(v), sin(u)*sin(v), cos(u) ];
Xu = diff(X,u);
Xv = diff(X,v);
F(u,v) = subs(f,[x,y,z],X(u,v));
aF = matlabFunction(F(u,v)*norm(cross(Xu,Xv)));
integral2(aF, pi/2-acos(1/2), pi/2+acos(1/2), 0, 2*pi)

%% Problem2
clear all
syms x y z u v
[X,Y] = meshgrid(linspace(-1,1,10));
surf(X,Y,X.^2-Y.^2); hold on;
quiver3(X,Y,X.^2-Y.^2,X.*Y,exp(Y),X.^2+Y); hold off;

clear X Y
F(x,y,z) = [x*y, exp(y), x^2+y];
X(u,v) = [u, v, u^2-v^2];
FX(u,v) = subs(F,[x,y,z],X);
FXu = diff(FX, u);
FXv = diff(FX, v);
f = matlabFunction(dot(FX(u,v), cross(FXu(u,v),FXv(u,v))));
integral2(f, -1, 1, -1, 1)

%% Computing line integrals


%% Problem 1
function V = sort_vert(v)
    x0 = mean(v(:,1));
    y0 = mean(v(:,2));
    theta = zeros(size(v,1),1);
    for i = 1 : size(v,1)
        theta(i) = find_theta(v(i,:),[x0,y0]);
    end
    [~, ind] = sort(theta);
    V = v(ind,:);
end

function theta = find_theta(v,p)
    x = v-p;
    theta = acos(x(1)/norm(x));
    if x(2) < 0
        theta = 2*pi - theta;
    end
end


%% Problem 2
function A = area_conv(v)
    A = 0;
    if size(v, 1) < 3
        return
    end
    for i = 3 : size(v, 1)
        A = A + area_tri([ v(1,:); v(i-1,:); v(i,:) ]);
    end
end
    
function A = area_tri(v)
    v1 = v(2,:) - v(1,:);
    v2 = v(3,:) - v(1,:);
    A = sqrt(norm(v1)^2*norm(v2)^2 - dot(v1,v2)^2)/2;
end

