clear
clc
method='qlearning'; %选择q-learning算法取消此行注释
% method='A*';  %选择A*算法取消此行注释
start_s=30; %起点状态
end_s=11;   %终点状态
global v_max;
global f_max;
v_max=0.5;
f_max=1000;
T=xlsread('T_init.xlsx');   %初始状态转移矩阵
cor=xlsread('coordinate.xlsx.');    %坐标值矩阵
flow=xlsread('flow_init.xlsx');   %道路密度矩阵
width=xlsread('width.xlsx');    %道路宽度矩阵
dis=xlsread('distance.xlsx');   %距离矩阵
crowd=flow_to_crowd(T,flow,width);  %路口车流量矩阵
flow=cal_Flow(T,crowd,width);
new_s=start_s;
Q=init_Q(T);
path=[start_s];
count_reward=0;
while new_s~=end_s
    [T,crowd,flow,R]=Update_M(T,crowd,flow,width,dis,cor,end_s);
    if strcmp(method,'qlearning')
        last_s=new_s;
        [Q,new_s]=qlearning(Q,R,new_s,end_s);
    else
        last_s=new_s;
        new_s=A_star(T,R,new_s,end_s);
    end
    count_reward=count_reward+R(last_s,new_s);
    path=[path;new_s];
    figure(1);
    disp(new_s);
    visualization(T,cor,flow,path,start_s,end_s,new_s,method);
end
disp('Final cost:');
disp(count_reward);