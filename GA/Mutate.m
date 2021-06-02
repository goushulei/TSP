function SelCh = Mutate(SelCh,Pm)
%变异操作
%输入：
%   SelCh  被选择的个体
%   Pm  变异概率
%输出：
%   SelCh  变异后的个体

[NSel,L] = size(SelCh);
for i = 1:NSel
    if Pm >= rand
        R = randperm(L);			% 打乱	% randperm(L):其中包含从 1 到 L 没有重复元素的整数随机排列
        SelCh(i,R(1:2)) = SelCh(i,R(2:-1:1));			% 取随机生成的数组前两位作为位置，交换同一种群中这两个位置的数据
    end
end
