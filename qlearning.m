function [Q_out,decision]=qlearning(Q_in,R,start_s,end_s)
%% �ó����������qlearning��Qֵ���󣬲����ص���״̬�ľ��߶���
% Q_in: n*n,Q(i,j)����״̬i��״̬j��qֵ,���ɴ��λ������Ϊinf
% T: n*n,T(i,j)����״̬i��״̬j�ĸ���
% R: n*n, R(i,j)����״̬i��״̬j��Reward
% start_s,end_s: ��ʼλ�����յ�λ�õĶ�Ӧ�ڵ�id
% qlearning��ز���
gamma = 0.5;    %�ۿ�����
alpha = 0.5;    % ѧϰ��
epsilon = 0.9;  %̽����,epsilon�ĸ��ʽ���explore,1-epsilon�ĸ��ʽ���exploit
cross_num=length(Q_in);
state = 1:cross_num;%����state
action = 1:cross_num;% ����action(��Ӧ�ǲ�ͬ��next_state)
Q = Q_in;   % ��ʼ��Qֵ����
state_idx = start_s;  %״̬����id
iter_count=1;   %����������
iter_max=5000; %��������
ratio_max=0.1; %Q����Ԫ�ر仯����
q_vector1=[];    %��Q�����еķ�infֵ����������ʽ�洢
for i=1:cross_num
    index=find(Q(i,:)~=inf);
    for j=1:length(index)
        q_vector1=[q_vector1,Q(i,index(j))];
    end
end

%% the main loop of the algorithm
while true
    %��������������ھ�����exploration����exploitation
    r=rand; % (0,1)������ȷֲ������������������ָʾexplore/exploit
    x=sum(r>=cumsum([0, 1-epsilon, epsilon])); % x=1��Ӧ1-e(exploitation),x=2��Ӧe(exploration)
    if x == 1   % exploitation,ѡ�������Qֵ��Ӧ��action
        [~,umin]=min(Q(state_idx,:));   %Ѱ�ҵ���state��Ӧ�����action����
        current_action = action(umin);
    else        % explortion,���ѡ���������action
        action_value=inf;
        while action_value==inf    %���������δ�ɵ�����stateʱ
            current_action=datasample(action,1); % ���ȷֲ����ѡȡһ��state
            action_value=Q_in(state_idx,current_action); % �����Ӧ����״̬��Qֵ
        end
    end
    
    action_idx = find(action==current_action); % Ѱ��ѡ��action��Ӧ������
    % ���ݵ��µ�״̬��ѡ��Ķ���������һʱ�̵�״̬
    [next_state,next_reward] = model(state(state_idx),action(action_idx),R);
    next_state_idx = find(state==next_state);  %Ѱ����һ��״̬��id
    % ����Q-learning����Qֵ����
    Q(state_idx,action_idx) = Q(state_idx,action_idx) + alpha * (next_reward + gamma* min(Q(next_state_idx,:)) - Q(state_idx,action_idx));
    % ��agent������ʼλ�û����յ�λ��ʱ������ѡ��״̬
    while(next_state_idx == end_s || next_state_idx == start_s)
        next_state_idx = datasample(1:length(state),1);
    end
    state_idx = next_state_idx;
    q_vector2=[];    %��Q�����еķ�infֵ����������ʽ�洢
    for i=1:cross_num
        index=find(Q(i,:)~=inf);
        for j=1:length(index)
            q_vector2=[q_vector2,Q(i,index(j))];
        end
    end
    d_ratio=abs(q_vector1-q_vector2)./abs(q_vector1);   %����ÿ��Ԫ�صı仯����
    if ~sum(~(d_ratio<ratio_max))
        disp('ratio_break')
        break;
    end
%     ratio=norm(q_vector1-q_vector2)/norm(q_vector1);
%     if ratio<ratio_max
%         disp('ratio_break')
%         break;
%     end
    q_vector1=q_vector2;
    iter_count=iter_count+1;
    if iter_count>iter_max
%         disp('iter_break')
        break;
    end
end
[C,I]=min(Q,[],2); % Ѱ��Qֵ���е����ֵ,C(n*1)Ϊ��ͬstate�����Qֵ,I(n*1)Ϊ���Qֵ��Ӧ��action
Q_out=Q;
decision=action(I(start_s));
end

%% �ú������ڸ��ݵ���״̬�����߷��ض�Ӧ��ʱ�̵�״̬��Reward
function [next_state,r] = model(x1,x2,R)
next_state=x2;
r=R(x1,x2);
end