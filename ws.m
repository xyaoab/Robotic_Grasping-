function [x,y,z] = ws(num,plot,origin)
%input: @num density of workspace samples 
%input: @plot binary indicator to visualize the point cloud 
%output: @x,y,z end-effector position from sampled joint angles
%written by Xinjie Yao
global params;
params = readmodel();

[a,b,c,d,e,f]=ndgrid(...
linspace(params.theta_min(1), params.theta_max(1),num),...
linspace(params.theta_min(2), params.theta_max(2),num),...
linspace(params.theta_min(3), params.theta_max(3),num),...
linspace(params.theta_min(4), params.theta_max(4),num),...
linspace(params.theta_min(5), params.theta_max(5),num),...
linspace(params.theta_min(6), params.theta_max(6),num));
a=a*pi/180;
b=b*pi/180;
c=c*pi/180;
d=d*pi/180;
e=e*pi/180;
f=f*pi/180;
x = origin(1)+69.*cos(a) - 69.*sin(a).*sin(c) - (37429.*sin(d).*(sin(a).*sin(c) + cos(a).*cos(c).*sin(b)))/100 - 10.*sin(e).*(cos(c).*sin(a) - cos(a).*sin(b).*sin(c)) - (3683.*sin(f).*(sin(e).*(cos(c).*sin(a) - cos(a).*sin(b).*sin(c)) + cos(e).*(cos(d).*(sin(a).*sin(c) + cos(a).*cos(c).*sin(b)) + cos(a).*cos(b).*sin(d))))/10 - 10.*cos(e).*(cos(d).*(sin(a).*sin(c) + cos(a).*cos(c).*sin(b)) + cos(a).*cos(b).*sin(d)) - (3683.*cos(f).*(sin(d).*(sin(a).*sin(c) + cos(a).*cos(c).*sin(b)) - cos(a).*cos(b).*cos(d)))/10 + (7287.*cos(a).*cos(b))/20 + (37429.*cos(a).*cos(b).*cos(d))/100 - 69.*cos(a).*cos(c).*sin(b);
y = origin(2)+69.*sin(a) + (37429.*sin(d).*(cos(a).*sin(c) - cos(c).*sin(a).*sin(b)))/100 + 10.*sin(e).*(cos(a).*cos(c) + sin(a).*sin(b).*sin(c)) + (3683.*sin(f).*(sin(e).*(cos(a).*cos(c) + sin(a).*sin(b).*sin(c)) + cos(e).*(cos(d).*(cos(a).*sin(c) - cos(c).*sin(a).*sin(b)) - cos(b).*sin(a).*sin(d))))/10 + 10.*cos(e).*(cos(d).*(cos(a).*sin(c) - cos(c).*sin(a).*sin(b)) - cos(b).*sin(a).*sin(d)) + (3683.*cos(f).*(sin(d).*(cos(a).*sin(c) - cos(c).*sin(a).*sin(b)) + cos(b).*cos(d).*sin(a)))/10 + (7287.*cos(b).*sin(a))/20 + 69.*cos(a).*sin(c) + (37429.*cos(b).*cos(d).*sin(a))/100 - 69.*cos(c).*sin(a).*sin(b);
z = origin(3)+10.*cos(e).*(sin(b).*sin(d) - cos(b).*cos(c).*cos(d)) - (7287.*sin(b))/20 - (3683.*cos(f).*(cos(d).*sin(b) + cos(b).*cos(c).*sin(d)))/10 + (3683.*sin(f).*(cos(e).*(sin(b).*sin(d) - cos(b).*cos(c).*cos(d)) + cos(b).*sin(c).*sin(e)))/10 - 69.*cos(b).*cos(c) - (37429.*cos(d).*sin(b))/100 - (37429.*cos(b).*cos(c).*sin(d))/100 + 10*cos(b).*sin(c).*sin(e) + 5407/20;
if plot==true
    plot3(x(:),y(:),z(:),'b.');
    title("Baxter workspace");
    xlabel("x");
    ylabel("y");
    zlabel("z");
end
    