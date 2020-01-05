function new_s=A_star(T,R,start_s,end_s)
%T  可达矩阵    R 代价(动作值)矩阵
step=start_s;
[n,~]=size(T);
h_list=navigation(end_s,R); % 反向传播
q_list=zeros(n,3);   % 每一行：【q    前节点    是否加入closelist】
q_list(q_list==0)=inf;  
q_list(start_s,:)=[0,0,1];
while step~=end_s
    [~,list]=find(T(step,:)>0);
    [~,l_list]=size(list);
    for k=1:1:l_list
        if q_list(step,1)+R(step,list(k))<q_list(list(k),1) && q_list(list(k),3)~=1
           q_list(list(k),1)=q_list(step,1)+R(step,list(k));
           q_list(list(k),2)=step;
        end
    end
    q_list(step,1)=inf;   % 排除当前节点 
    f_list=q_list;
    f_list(:,1)=f_list(:,1)+h_list;  % 计算f_list
    [~,new_step]=min(f_list(:,1));
    q_list(new_step,3)=1;   % 加入closelist
    step=new_step;
end 
path=end_s;   
while end_s~=start_s   % 逆向求得路径
    path=[q_list(end_s,2) path];
    end_s=q_list(end_s,2);
end
new_s=path(2);


function dis=navigation(end_s,map)
    [~,n0]=size(map);
    dis=zeros(n0,1);
    dis(dis==0)=inf;
    dis(end_s)=0;
    dis=back_pro(end_s,map,dis);
    
function dis=back_pro(point,map,dis)
    %反向传播函数
    fopoint=find(map(:,point)<inf);
    [m,~]=size(fopoint);
    for i=1:1:m
        if  dis(fopoint(i))>dis(point)+map(fopoint(i),point)
            dis(fopoint(i))=dis(point)+map(fopoint(i),point);
            dis=back_pro(fopoint(i),map,dis);
        end 
    end 