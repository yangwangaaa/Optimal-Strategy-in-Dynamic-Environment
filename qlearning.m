function [Q_out,decision]=qlearning(Q_in,R,start_s,end_s)
%% 该程序用于求解qlearning的Q值矩阵，并返回当下状态的决策动作
% Q_in: n*n,Q(i,j)是由状态i到状态j的q值,不可达的位置设置为inf
% T: n*n,T(i,j)是由状态i到状态j的概率
% R: n*n, R(i,j)是由状态i到状态j的Reward
% start_s,end_s: 开始位置与终点位置的对应节点id
% qlearning相关参数
gamma = 0.5;    %折扣因子
alpha = 0.5;    % 学习率
epsilon = 0.9;  %探索率,epsilon的概率进行explore,1-epsilon的概率进行exploit
cross_num=length(Q_in);
state = 1:cross_num;%定义state
action = 1:cross_num;% 定义action(对应是不同的next_state)
Q = Q_in;   % 初始化Q值矩阵
state_idx = start_s;  %状态索引id
iter_count=1;   %迭代计数器
iter_max=5000; %迭代上限
ratio_max=0.1; %Q矩阵元素变化上限
q_vector1=[];    %将Q矩阵中的非inf值以行向量形式存储
for i=1:cross_num
    index=find(Q(i,:)~=inf);
    for j=1:length(index)
        q_vector1=[q_vector1,Q(i,index(j))];
    end
end

%% the main loop of the algorithm
while true
    %生成随机数，用于决定是exploration还是exploitation
    r=rand; % (0,1)区间均匀分布采样的随机数，用于指示explore/exploit
    x=sum(r>=cumsum([0, 1-epsilon, epsilon])); % x=1对应1-e(exploitation),x=2对应e(exploration)
    if x == 1   % exploitation,选择当下最大Q值对应的action
        [~,umin]=min(Q(state_idx,:));   %寻找当下state对应的最大action索引
        current_action = action(umin);
    else        % explortion,随机选择接下来的action
        action_value=inf;
        while action_value==inf    %当随机采样未采到可行state时
            current_action=datasample(action,1); % 均匀分布随机选取一个state
            action_value=Q_in(state_idx,current_action); % 计算对应采样状态的Q值
        end
    end
    
    action_idx = find(action==current_action); % 寻找选择action对应的索引
    % 根据当下的状态和选择的动作决定下一时刻的状态
    [next_state,next_reward] = model(state(state_idx),action(action_idx),R);
    next_state_idx = find(state==next_state);  %寻找下一个状态的id
    % 根据Q-learning更新Q值矩阵
    Q(state_idx,action_idx) = Q(state_idx,action_idx) + alpha * (next_reward + gamma* min(Q(next_state_idx,:)) - Q(state_idx,action_idx));
    % 当agent锁在起始位置或是终点位置时，重新选择状态
    while(next_state_idx == end_s || next_state_idx == start_s)
        next_state_idx = datasample(1:length(state),1);
    end
    state_idx = next_state_idx;
    q_vector2=[];    %将Q矩阵中的非inf值以行向量形式存储
    for i=1:cross_num
        index=find(Q(i,:)~=inf);
        for j=1:length(index)
            q_vector2=[q_vector2,Q(i,index(j))];
        end
    end
    d_ratio=abs(q_vector1-q_vector2)./abs(q_vector1);   %计算每个元素的变化比例
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
[C,I]=min(Q,[],2); % 寻找Q值表中的最大值,C(n*1)为不同state的最大Q值,I(n*1)为最大Q值对应的action
Q_out=Q;
decision=action(I(start_s));
end

%% 该函数用于根据当下状态及决策返回对应下时刻的状态与Reward
function [next_state,r] = model(x1,x2,R)
next_state=x2;
r=R(x1,x2);
end