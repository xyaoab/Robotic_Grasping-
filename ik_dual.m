function [sol,final,joint_plot, result_flag]=ik_dual(pos, iksolver,origin)
%input: @pos position of end effector
%input: @iksolver binary indicator of returning multiple solutions 
%output: @sol set of joint angles from solving nolinear equations
%output: @final end-effector position 
%output: @joint_plot graphic model of the stick figures 
%written by Xinjie Yao
global params;
params = readmodel();
result_flag=false;
x=pos(:,1);
y=pos(:,2);
z=pos(:,3);
disp("IK Dual starts")
%disp("Ideal end effector position");
%disp(pos);
sol=[];
opts = optimoptions(@fsolve,'Algorithm','levenberg-marquardt','Display','off');
num=8;
[a,b,c,d,e,f]=ndgrid(...
linspace(params.theta_min(1), params.theta_max(1),num),...
linspace(params.theta_min(2), params.theta_max(2),num),...
linspace(params.theta_min(3), params.theta_max(3),num),...
linspace(params.theta_min(4), params.theta_max(4),num),...
linspace(params.theta_min(5), params.theta_max(5),num),...
linspace(params.theta_min(6), params.theta_max(6),num));

[ptx,pty,ptz] = ws(num,false,origin);
search_space=[ptx(:),pty(:),ptz(:)];
N = 10; %knn search as starting point
linear_index=knnsearch(search_space,pos,'K',N);
[i,j,k,l,m,n]=ind2sub([num,num,num,num,num,num],linear_index);
x0 = [reshape(a(i,1,1,1,1,1),[N,1]) reshape(b(1,j,1,1,1,1),[N,1]) reshape(c(1,1,k,1,1,1),[N,1]) reshape(d(1,1,1,l,1,1),[N,1]) reshape(e(1,1,1,1,m,1),[N,1]) reshape(f(1,1,1,1,1,n),[N,1])];

for k=1:N
    angle = fsolve(@(theta)equ(theta,x,y,z),x0(k,:),opts);
    if (angle(1)>=params.theta_min(1) && angle(1)<= params.theta_max(1)...
            && angle(2)>=params.theta_min(2) && angle(2)<= params.theta_max(2)...
            && angle(3)>=params.theta_min(3) && angle(3)<= params.theta_max(3)...
            && angle(4)>=params.theta_min(4) && angle(4)<= params.theta_max(4)...
            && angle(5)>=params.theta_min(5) && angle(5)<= params.theta_max(5)...
            && angle(6)>=params.theta_min(6) && angle(6)<= params.theta_max(6))
        if ~isempty(sol)
            if ~isequal(angle,sol(size(sol,1),:))
                sol = [sol;angle];
            end
        else 
            sol = [sol;angle];
        end
       
    end
end 
if ~isempty(sol)
    disp("Solutions found in degrees, wrist roll2 is set to default 0");
    disp(sol);
    result_flag=true;
    for i=1:size(sol,1)
        if iksolver
            figure;
        end
        hold on
        [final,joint_plot] = fk(sol(i,1),sol(i,2),sol(i,3),sol(i,4),sol(i,5),sol(i,6),0,true,origin);

        disp("Position from forward kinematics for solution" + i);
        disp(final(1:3)');
        hold on
        plot3(final(1),final(2),final(3),'rx');
       
        view(3)
        axis equal
        hold on
        xlabel("x");
        ylabel("y");
        zlabel("z");
        title("IK solution")
        
        if iksolver
            plot3(x,y,z,'m*');
            text(x,y,z,"Ground Truth",'VerticalAlignment','top','HorizontalAlignment','left');
            text(final(1),final(2),final(3),"Forward Kinematics",'VerticalAlignment','bottom','HorizontalAlignment','left');
        else
            break;
        end
        hold off
    end 
else 
        disp("Solution not found")
end