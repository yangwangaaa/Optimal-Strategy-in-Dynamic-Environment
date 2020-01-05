function new_s=A_star(T,R,start_s,end_s)
%T  �ɴ����    R ����(����ֵ)����
step=start_s;
[n,~]=size(T);
h_list=navigation(end_s,R); % ���򴫲�
q_list=zeros(n,3);   % ÿһ�У���q    ǰ�ڵ�    �Ƿ����closelist��
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
    q_list(step,1)=inf;   % �ų���ǰ�ڵ� 
    f_list=q_list;
    f_list(:,1)=f_list(:,1)+h_list;  % ����f_list
    [~,new_step]=min(f_list(:,1));
    q_list(new_step,3)=1;   % ����closelist
    step=new_step;
end 
path=end_s;   
while end_s~=start_s   % �������·��
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
    %���򴫲�����
    fopoint=find(map(:,point)<inf);
    [m,~]=size(fopoint);
    for i=1:1:m
        if  dis(fopoint(i))>dis(point)+map(fopoint(i),point)
            dis(fopoint(i))=dis(point)+map(fopoint(i),point);
            dis=back_pro(fopoint(i),map,dis);
        end 
    end 