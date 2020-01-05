function [T_out,crowd_out,flow_out,R_out]=Update_M(T_in,crowd_in,flow_in,width,dis,cor,end_s)
%% �ó������ڸ���״̬ת�ƾ��󡢳����ֲ��Լ�Reward
% crowd_in,crowd_out: n*2, C(i,1)�ǵ�i��·�ڵĳ�����, C(i,2)�ǵ�i��·�ڵ�ʻ��������
% flow_out: n*n, flow(i,j)�ǵ�i��·�����j��·�ڼ��·�ĵĳ��������������Ķ�ӦΪinf
% T_in,T_out: n*n, T(i,j)����·��i��·��j֮���ת�Ƹ���
% R_out: n*n, R(i,j)��·��i��·��j��Reward

%% ����ÿ��·�ڵĳ�����
crowd_out=cal_Crowd(T_in,crowd_in,flow_in,width);

%% ������³�����
flow_out=cal_Flow(T_in,crowd_out,width);

%% �������״̬ת�ƾ���
T_out=cal_Transfer(T_in,crowd_out,flow_out,width);

%% ������´���ֵ����
R_out=cal_Reward(T_in,cor,crowd_out,flow_out,dis,width,end_s);