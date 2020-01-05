function crowd_out=cal_Crowd(T,crowd_in,flow,width)
%% �ú������ڼ������ÿ��·�ڵĳ�����Ϣ
global v_max;
global f_max;
k=0.5;
cross_num=length(T);
crowd_out=zeros(cross_num);
crowd_exchange=zeros(cross_num);
for i=1:cross_num   %����ÿ��·�ڳ�����������
    index=find(T(i,:)~=0);   %Ѱ�Ҹ�·��i�ɴ������·��j
    c_out=0;
    for j=1:length(index)
        a=width(i,index(j));    %Ѱ�Ҷ�Ӧ��·�Ŀ��
        f=flow(i,index(j));  %Ѱ�Ҷ�Ӧ��·���ܶ�
        c_out=c_out+k*a*f*v_max*sig(1-f/max(f,f_max));
    end
    crowd_exchange(i)=c_out;
end
for i=1:cross_num
    index=find(T(:,i)~=0);   %Ѱ�ҵ����·��i������·��j
    new=crowd_in(i)-crowd_exchange(i);
    for j=1:length(index)
        p=T(index(j),i);
        new=new+p*crowd_exchange(index(j));
    end
    crowd_out(i)=max(new,0);
end