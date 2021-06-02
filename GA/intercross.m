function [a,b] = intercross(a,b)
%输入：
%   a和b为两个待交叉的个体
%输出：
%   a和b为交叉后得到的两个个体
L = length(a);
r1 = randsrc(1,1,[1:L]);			% 使用[1:L]中的数据生成一个1 * 1矩阵
r2 = randsrc(1,1,[1:L]);
if r1~=r2
    a0 = a;
    b0 = b;
    s = min([r1,r2]);
    e = max([r1,r2]);
    for i =s:e			% 将随机生成的两个数据之间的数据段都发生交换
        a1 = a;
        b1 = b;
        a(i) = b0(i);			% 两个种群之间，同位置交换第一次	% 会产生一个重复
        b(i) = a0(i);
        x = find(a==a(i));			% 找到重复位置的下标
        y = find(b==b(i));
        i1 = x(x~=i);			% 除去第一次交换所在位置
        i2 = y(y~=i);
        if ~isempty(i1)			% 完成第二次交换
            a(i1)=a1(i);
        end
        if ~isempty(i2)
            b(i1)=b1(i);
        end
    end
end
