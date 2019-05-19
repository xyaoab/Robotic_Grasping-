%written by Xinjie Yao
%For demo usage 
%ELEC4010MMECH4000J Project#2
%May 17th 2019
%% IMPORTANT: Please comment irrelevant sections to run tasks individually
%% Clear all graphs
clc, close all;
%% Ask for vertices and visuallize polygon
%example: [0, 0; 600, 100; 900, 300; 300, 200]
vertices = input("Please enter a list of vertices");
vertices = poly(vertices);

%% Ask for fraction coefficient
%example: 1
friction = input("Please enter the coefficient of friction");

%% Detect force closure 
clc, close all;
[pt1_set, pt2_set] = detect_fc(vertices,friction);

%% Plot the reachable grasping configuration of the dual-arm robot
clc, close all;
plot_dual(pt1_set,pt2_set,vertices);