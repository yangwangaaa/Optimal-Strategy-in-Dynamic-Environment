function T_out=cal_Transfer(T_in,crowd,flow,width)
%% �ú������ڸ��¼���״̬ת�ƾ���
global f_max;
b1=0.25;
b2=0.25;
b3=0.25;
b4=0.25;
cross_num=length(crowd);
T_out=zeros(cross_num,cross_num);
for i=1:cross_num
    index=find(T_in(i,:)~=0);
    temp=zeros(length(index));
    for j=1:length(index)
        a=width(i,index(j));
        f=flow(i,index(j));
        p1=f/max(f_max,f);
        p2=1-f/max(f_max,f);
        p3=crowd(i)-crowd(index(j));    %��������·�ڵĳ�����
        temp(j)=a*(b1*sig(p1)+b2*sig(p2)+b3*sig(p3)+b4*rand(1));
    end
    temp=temp/sum(temp);   %���ʹ�һ��
    for j=1:length(index)
        T_out(i,index(j))=temp(j);
    end
end
