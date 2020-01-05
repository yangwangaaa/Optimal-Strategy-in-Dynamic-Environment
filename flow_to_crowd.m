function crowd_out=flow_to_crowd(T,flow,width)
cross_num=length(flow);
crowd_out=zeros(cross_num,2);
for i=1:30
    i_index=find(T(i,:)~=0);    %�ҵ�·��i�Ŀɴ�·������
    count=0; %��¼��i��·�ڵ�crowd
    connect_i=sum(width(i,i_index));    %��·���������е�·�Ŀ���ܺ�
    for j=1:length(i_index)
        count=count+flow(i,i_index(j))*connect_i/(2*width(i,i_index(j)));
    end
    count=count/2; %��Ϊ�ڱ����Ĺ�����flow�ǶԳƾ��󣬱���������
    crowd_out(i,:)=[count,count*0.1];
end