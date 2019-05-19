function [A,B]=detect_fc(vertices,friction)
A=[];
B=[];
num = size(vertices,1);
centriod = [mean(vertices(1:num-1,1)), mean(vertices(1:num-1,2)), mean(vertices(1:num-1,3))];
C = combnk(1:num-1,2);

for i = 1:size(C,1)
    [pt1, pt2] = force_closure(friction, centriod, vertices(C(i,1),:), vertices(C(i,1)+1,:), vertices(C(i,2),:), vertices(C(i,2)+1,:));
    A=[A;pt1];
    B=[B;pt2];
end 
