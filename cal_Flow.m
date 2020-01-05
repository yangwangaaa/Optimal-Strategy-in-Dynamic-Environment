function flow_out=cal_Flow(T,crowd,width)
%% �ú������ڼ������ÿ��·�ڵĳ�����Ϣ
cross_num=length(crowd);
flow_out=1./zeros(cross_num,cross_num);
for i=1:cross_num
    i_index=find(T(i,:)~=0);   %Ѱ�ҵ�i��·�ڿɴ��·������
    connect_i=sum(width(i,i_index));    %·��i�ɴ�·������,���ڷ���Ȩ��
    for j=1:length(i_index)
        j_index=find(T(i_index(j),:)~=0);
        connect_j=sum(width(i_index(j),j_index));    %·��j�ɴ�·������,���ڷ���Ȩ��
        temp=crowd(i)*width(i,i_index(j))/connect_i+crowd(i_index(j))*width(i,i_index(j))/connect_j;
        flow_out(i,i_index(j))=temp;
    end
end