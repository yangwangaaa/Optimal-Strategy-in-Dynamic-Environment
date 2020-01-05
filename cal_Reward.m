function R_out=cal_Reward(T,cor,crowd,flow,dis,width,end_s)
%% 该程序用于计算更新Reward矩阵
global v_max;
global f_max;
k1=0.2;  %行驶时间系数
k2=0.2;    %路口车辆系数
k3=1;     %路口到终点的距离系数
cross_num=length(T);
R_out=1./zeros(cross_num,cross_num);     %生成全为inf的数组
for i=1:cross_num
    reach_index=find(T(i,:)~=0);  %寻找可达的路口
    for j=1:length(reach_index)
        r1=k1*dis(i,reach_index(j))/(v_max*(1-flow(i,reach_index(j))/f_max));   %大约在10~40之间
        r2=k2*crowd(reach_index(j));    %大约在100~300之间
        r3=k3*norm(cor(reach_index(j),:)-cor(end_s,:));     %大约在50~400之间
        R_out(i,reach_index(j))=(r1+r2+r3)/width(i,reach_index(j));
    end
end