function SelCh = Mutate(SelCh,Pm)
%�������
%���룺
%   SelCh  ��ѡ��ĸ���
%   Pm  �������
%�����
%   SelCh  �����ĸ���

[NSel,L] = size(SelCh);
for i = 1:NSel
    if Pm >= rand
        R = randperm(L);			% ����	% randperm(L):���а����� 1 �� L û���ظ�Ԫ�ص������������
        SelCh(i,R(1:2)) = SelCh(i,R(2:-1:1));			% ȡ������ɵ�����ǰ��λ��Ϊλ�ã�����ͬһ��Ⱥ��������λ�õ�����
    end
end
