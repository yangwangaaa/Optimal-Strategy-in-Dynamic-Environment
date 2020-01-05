function visualization(T,cor,flow,path,start_s,end_s,new_s,algorithm)
%% ���ӻ�����
    x_len=max(cor(:,1))-min(cor(:,1));  %x����Ŀ��
    y_len=max(cor(:,2))-min(cor(:,2));  %y����Ŀ��
    color=[[0,'g'];[150,'c'];[300,'y'];[450,'m'];[600,'r']]; %�����ͼ������ɫ
    cross_num=length(cor);
    for i=1:cross_num   %����·��
        if i==start_s
            plot(cor(i,1),cor(i,2),'o','color','r');
            text(cor(i,1)+0.01*x_len,cor(i,2)+0.01*y_len,[num2str(i) "start"]);
            hold on;
        elseif i==end_s
            plot(cor(i,1),cor(i,2),'o','color','r');
            text(cor(i,1)+0.01*x_len,cor(i,2)+0.01*y_len,[num2str(i) "end"]);
            hold on;
        else
            plot(cor(i,1),cor(i,2),'o','color','r');
            text(cor(i,1)+0.01*x_len,cor(i,2)+0.01*y_len,num2str(i));
            hold on;
        end
    end
    for i=1:cross_num    %���Ƶ�·
        connect=find(T(i,:)~=0);
        for j=1:length(connect)
            index=max(find(color(:,1)<=flow(i,connect(j))));
            c=color(index,2);
            line([cor(i,1) cor(connect(j),1)],[cor(i,2) cor(connect(j),2)],'color',c,'LineWidth',2);
            hold on;
        end
    end
    set(gca,'XLim',[min(cor(:,1))-0.1*x_len,max(cor(:,1))+0.1*x_len]);%X���������ʾ��Χ
    set(gca,'yLim',[min(cor(:,2))-0.1*y_len,max(cor(:,2))+0.1*y_len]);%X���������ʾ��Χ
    title(algorithm);
    for i=1:length(path)-1
        line([cor(path(i),1) cor(path(i+1),1)],[cor(path(i),2) cor(path(i+1),2)],'color','b','LineWidth',3);
    end
    plot(cor(new_s,1),cor(new_s,2),'o','MarkerFaceColor','r')
end 