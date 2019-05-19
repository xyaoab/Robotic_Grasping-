function []=plot_dual(pos1_set, pos2_set,vertices)
num = size(vertices,1);
%centriod = [mean(vertices(1:num-1,1)), mean(vertices(1:num-1,2)), mean(vertices(1:num-1,3))];
centriod = [mean([min(vertices(:,1)) max(vertices(:,1))]), mean([min(vertices(:,2)) max(vertices(:,2))]), 0];
for i=1:size(pos1_set,1)
    figure;
    origin1 = [(centriod(1) - max(vertices(:,1))/1.5), centriod(2) - 175,0];
    origin2 = [(centriod(1) - max(vertices(:,1))/1.5), centriod(2) + 175,0];
    disp("Ideal End Position");
    disp(pos1_set(i,:));
    disp(pos2_set(i,:));
    [sol,final,joint_plot, result_flag_1]=ik_dual((pos1_set(i,:)-origin1), false,origin1);
    hold on;
    [sol,final,joint_plot, result_flag_2]=ik_dual((pos2_set(i,:)-origin2), false,origin2);
    hold on;
    if result_flag_1 && result_flag_2
        plot3(vertices(:,1),vertices(:,2),vertices(:,3),'-o','LineWidth',2);
        hold on
        text(pos1_set(i,1),pos1_set(i,2),pos1_set(i,3), "FOUND_1");
        plot3(pos1_set(i,1),pos1_set(i,2),pos1_set(i,3),'m*');
        text(pos2_set(i,1),pos2_set(i,2),pos2_set(i,3), "FOUND_2");
        plot3(pos2_set(i,1),pos2_set(i,2),pos2_set(i,3),'m*');
        break;
    end 
end