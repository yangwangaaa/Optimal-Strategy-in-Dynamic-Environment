function [T_out,crowd_out,flow_out,R_out]=Update_M(T_in,crowd_in,flow_in,width,dis,cor,end_s)
%% 该程序用于更新状态转移矩阵、车流分布以及Reward
% crowd_in,crowd_out: n*2, C(i,1)是第i个路口的车流量, C(i,2)是第i个路口的驶出车流量
% flow_out: n*n, flow(i,j)是第i个路口与第j个路口间道路的的车流量，不相连的对应为inf
% T_in,T_out: n*n, T(i,j)是由路口i到路口j之间的转移概率
% R_out: n*n, R(i,j)是路口i到路口j的Reward

%% 计算每个路口的车流量
crowd_out=cal_Crowd(T_in,crowd_in,flow_in,width);

%% 计算更新车流量
flow_out=cal_Flow(T_in,crowd_out,width);

%% 计算更新状态转移矩阵
T_out=cal_Transfer(T_in,crowd_out,flow_out,width);

%% 计算更新代价值矩阵
R_out=cal_Reward(T_in,cor,crowd_out,flow_out,dis,width,end_s);