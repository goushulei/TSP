function SelCh = Reverse(SelCh,D)%������ת����
%���룺
%   SelCh  ��ѡ��ĸ���
%   D  �����еľ������
%�����
%   SelCh  ������ת��ĸ���

[row,col] = size(SelCh);
ObjV = PathLength(D,SelCh);			% ������Ⱥԭʼ·������
SelCh1 = SelCh;			% ����ԭʼ����
for i = 1:row
    r1 = randsrc(1,1,[1:col]);
    r2 = randsrc(1,1,[1:col]);
    mininverse = min([r1 r2]);
    maxinverse = max([r1 r2]);
    SelCh1(i,mininverse:maxinverse) = SelCh1(i,maxinverse:-1:mininverse);			% ��һ�����ݶ��е����ݷ�ת
end
ObjV1 = PathLength(D,SelCh1);			% ��������·�߳���
index = ObjV1<ObjV;
SelCh(index,:)=SelCh1(index,:);
