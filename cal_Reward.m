function R_out=cal_Reward(T,cor,crowd,flow,dis,width,end_s)
%% �ó������ڼ������Reward����
global v_max;
global f_max;
k1=0.2;  %��ʻʱ��ϵ��
k2=0.2;    %·�ڳ���ϵ��
k3=1;     %·�ڵ��յ�ľ���ϵ��
cross_num=length(T);
R_out=1./zeros(cross_num,cross_num);     %����ȫΪinf������
for i=1:cross_num
    reach_index=find(T(i,:)~=0);  %Ѱ�ҿɴ��·��
    for j=1:length(reach_index)
        r1=k1*dis(i,reach_index(j))/(v_max*(1-flow(i,reach_index(j))/f_max));   %��Լ��10~40֮��
        r2=k2*crowd(reach_index(j));    %��Լ��100~300֮��
        r3=k3*norm(cor(reach_index(j),:)-cor(end_s,:));     %��Լ��50~400֮��
        R_out(i,reach_index(j))=(r1+r2+r3)/width(i,reach_index(j));
    end
end