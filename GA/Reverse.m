function SelCh = Reverse(SelCh,D)%进化逆转函数
%输入：
%   SelCh  被选择的个体
%   D  各城市的距离矩阵
%输出：
%   SelCh  进化逆转后的个体

[row,col] = size(SelCh);
ObjV = PathLength(D,SelCh);			% 计算种群原始路径长度
SelCh1 = SelCh;			% 保存原始数据
for i = 1:row
    r1 = randsrc(1,1,[1:col]);
    r2 = randsrc(1,1,[1:col]);
    mininverse = min([r1 r2]);
    maxinverse = max([r1 r2]);
    SelCh1(i,mininverse:maxinverse) = SelCh1(i,maxinverse:-1:mininverse);			% 将一段数据段中的数据翻转
end
ObjV1 = PathLength(D,SelCh1);			% 计算最新路线长度
index = ObjV1<ObjV;
SelCh(index,:)=SelCh1(index,:);
