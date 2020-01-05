clear
clc
method='qlearning'; %ѡ��q-learning�㷨ȡ������ע��
% method='A*';  %ѡ��A*�㷨ȡ������ע��
start_s=30; %���״̬
end_s=11;   %�յ�״̬
global v_max;
global f_max;
v_max=0.5;
f_max=1000;
T=xlsread('T_init.xlsx');   %��ʼ״̬ת�ƾ���
cor=xlsread('coordinate.xlsx.');    %����ֵ����
flow=xlsread('flow_init.xlsx');   %��·�ܶȾ���
width=xlsread('width.xlsx');    %��·��Ⱦ���
dis=xlsread('distance.xlsx');   %�������
crowd=flow_to_crowd(T,flow,width);  %·�ڳ���������
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