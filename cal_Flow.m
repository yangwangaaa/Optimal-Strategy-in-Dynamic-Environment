function flow_out=cal_Flow(T,crowd,width)
%% 该函数用于计算更新每个路口的车流信息
cross_num=length(crowd);
flow_out=1./zeros(cross_num,cross_num);
for i=1:cross_num
    i_index=find(T(i,:)~=0);   %寻找第i个路口可达的路口索引
    connect_i=sum(width(i,i_index));    %路口i可达路口索引,用于分配权重
    for j=1:length(i_index)
        j_index=find(T(i_index(j),:)~=0);
        connect_j=sum(width(i_index(j),j_index));    %路口j可达路口索引,用于分配权重
        temp=crowd(i)*width(i,i_index(j))/connect_i+crowd(i_index(j))*width(i,i_index(j))/connect_j;
        flow_out(i,i_index(j))=temp;
    end
end