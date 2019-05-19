function [pos,joint_plot] = fk(theta1,theta2,theta3,theta4,theta5,theta6,theta7,plot, origin)
%input: @theta angles of each joint
%input: @plot binary indicator of plotting fk as stick figures 
%output: @pos end-effector position 
%output: @joint_plot graphic model of the stick figures 
%written by Xinjie Yao
global params; 
params = readmodel();
p=[0,0,0, 1]';
if (theta1< params.theta_min(1) || theta1> params.theta_max(1)...
            || theta2<params.theta_min(2) || theta2> params.theta_max(2)...
            || theta3<params.theta_min(3) || theta3> params.theta_max(3)...
            || theta4<params.theta_min(4) || theta4> params.theta_max(4)...
            || theta5<params.theta_min(5) || theta5> params.theta_max(5)...
            || theta6<params.theta_min(6) || theta6> params.theta_max(6)...
            || theta7<params.theta_min(7) || theta7> params.theta_max(7))
        disp("Check your entries. Invalid angles")
        return;
end
theta1 = (theta1*pi)/180;
theta2 = (theta2*pi)/180;
theta3 = (theta3*pi)/180;
theta4 = (theta4*pi)/180;
theta5 = (theta5*pi)/180;
theta6 = (theta6*pi)/180;
theta7 = (theta7*pi)/180;
T01=[cos(theta1) -sin(theta1) 0 0;...
    sin(theta1) cos(theta1) 0 0;...
    0 0 1 params.l0;...
    0 0 0 1];
T12=[-sin(theta2) -cos(theta2) 0 params.l1;...
    0 0 1 0;...
    -cos(theta2) sin(theta2) 0 0;...
    0 0 0 1];
T23=[cos(theta3) -sin(theta3) 0 0;...
    0 0 -1 -params.l2;...
    sin(theta3) cos(theta3) 0 0;...
    0 0 0 1];
T34=[cos(theta4) -sin(theta4) 0 params.l3;...
    0 0 1 0;...
    -sin(theta4) -cos(theta4) 0 0;...
    0 0 0 1];
T45=[cos(theta5) -sin(theta5) 0 0;...
    0 0 -1 -params.l4;...
    sin(theta5) cos(theta5) 0 0;...
    0 0 0 1];
T56=[cos(theta6) -sin(theta6) 0 params.l5;...
    0 0 1 0 ;...
    -sin(theta6) -cos(theta6) 0 0;...
    0 0 0 1];
T67=[cos(theta7) -sin(theta7) 0 0;...
    0 0 -1 -params.l6 ;...
    sin(theta7) cos(theta7) 0 0;...
    0 0 0 1];
p1=T01*p + [origin 0]';
p2=T01*T12*p + [origin 0]';
p3=T01*T12*T23*p + [origin 0]';
p4=T01*T12*T23*T34*p + [origin 0]';
p5=T01*T12*T23*T34*T45*p + [origin 0]';
p6=T01*T12*T23*T34*T45*T56*p + [origin 0]';
p7=T01*T12*T23*T34*T45*T56*T67*p + [origin 0]';
x=[p(1)+origin(1) p1(1) p2(1) p3(1) p4(1) p5(1) p6(1) p7(1)];
y=[p(2)+origin(2) p1(2) p2(2) p3(2) p4(2) p5(2) p6(2) p7(2)];
z=[p(3)+origin(3) p1(3) p2(3) p3(3) p4(3) p5(3) p6(3) p7(3)];

if plot==true

    joint_plot=plot3(x,y,z,'Linewidth',3);
    hold on;
    plot3(p(1),p(2),p(3),'r*');
    hold off;
    title("Forward Kinematics")
    xlabel("x");
    ylabel("y");
    zlabel("z");
    grid on
end 
pos=p7;
end
