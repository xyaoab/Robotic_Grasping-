function [vertices]=poly(vertices_)
disp("vertices are" );
disp(vertices_);
vertices = [vertices_ zeros(size(vertices_,1),1)];
vertices = [vertices ; vertices(1,:)];
plot3(vertices(:,1),vertices(:,2),vertices(:,3),'-o','LineWidth',2);
axis equal;
center = mean(vertices_);
axis([(min(vertices(:,1)) - center(1)) (max(vertices(:,1))+ center(1)) (min(vertices(:,2))- center(2)) (max(vertices(:,2))+ center(2))]);
end

