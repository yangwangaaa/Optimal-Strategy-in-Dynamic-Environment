function Q_out=init_Q(T)
%% ≥ı ºªØQ÷µæÿ’Û
cross_num=length(T);
Q_out=1./zeros(cross_num,cross_num);
for i=1:cross_num
    index=find(T(i,:)~=0);
    for j=1:length(index)
        Q_out(i,index(j))=0;
    end
end