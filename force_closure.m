function [pt1, pt2] = force_closure(friction, centriod, v1, v2, v3, v4)
fc_angle = rad2deg(atan(friction));
figure;
plot3([v1(1);v2(1)],[v1(2);v2(2)],[v1(3);v2(3)]);
hold on
plot3([v3(1);v4(1)],[v3(2);v4(2)],[v3(3);v4(3)]);
hold on
%disp("fc_angle");
%disp(fc_angle);
npoints=10;
pt1=[];
pt2=[];
normal1 = [(v1(2)-v2(2)), (v2(1)-v1(1)), 0];
normal2 = [(v3(2)-v4(2)), (v4(1)-v3(1)), 0];
center1 = centriod - v1;
center2 = centriod - v3;
normal1 = -normal1*sign(dot(center1,normal1));
normal2 = -normal2*sign(dot(center2,normal2));
x = (linspace(0,1,npoints+2)); 
x = x(2:length(x)-1); % excluding 0, 1
x = x';
x = [x x x];
pt1_list = v1 + x.*(v2 - v1);
pt2_list = v3 + x.*(v4 - v3); 

for i = 1:npoints
    for j = 1:npoints
        disp("points1 are ");
        disp(pt1_list(i,:)); 
        disp("points2 are ");
        disp(pt2_list(j,:)); 
        vector = pt2_list(j,:) - pt1_list(i,:);
        angle1 = atan2d(norm(cross(normal1,-vector)),dot(normal1,-vector));
        angle2 = atan2d(norm(cross(normal2,vector)),dot(normal2,vector));
        %disp("angles are");
        %disp(angle1);
        %disp(angle2);
        if (angle1<fc_angle) && (angle2<fc_angle)
            disp("force closure");
            plot3([pt1_list(i,1);pt2_list(j,1)], ...
            [pt1_list(i,2);pt2_list(j,2)], ...
            [pt1_list(i,3);pt2_list(j,3)]);
            hold on
            pt1 = [pt1;pt1_list(i,:)];
            pt2 = [pt2;pt2_list(j,:)];
        else 
            disp("no force closure");
        end
    end 
end 
