function NewChrIx = Sus(FitnV,Nsel)
%���룺
%   FitnV ���������Ӧ��ֵ
%   Nsel ��ѡ�������Ŀ
%�����
%   NewChrIx ��ѡ������������

[Nind,ans] = size(FitnV);			% NindΪFitnV������Ҳ���Ǹ����� ansΪ����1
cumfit = cumsum(FitnV);			% ����Ӧ���ۼ� ���� 1 2 3 �ۼӺ� 1 3 6 ���������ۻ�����
trials = cumfit(Nind)/Nsel * (rand + (0:Nsel-1)');			% cumfit(Nind)��ʾ���Ǿ���cumfit���һ��Ԫ��	% cumfit(Nind)/Nselƽ����Ӧ��	% A.'��һ��ת��	% A'�ǹ���ת��	% rand����һ�������� (0,1) �ھ��ȷֲ��������
Mf = cumfit(:,ones(1,Nsel));            % �� ��Ӧ���ۼӺ� ����һ��Nind * Nsel�ľ���
Mt = trials(:,ones(1,Nind))';			% �����ɵ� �ۻ����� ����һ��Nind * Nsel�ľ��� 
[NewChrIx,ans] = find([zeros(1,Nsel);Mf(1:Nind-1,:)] <= Mt & Mt < Mf);			% Ѱ�ҷ���Ԫ��
[ans,shuf] = sort(rand(Nsel,1));			% ����Nsel*1�����������  ������� A ��Ԫ�ؽ������� ����ѡ���shuf
NewChrIx = NewChrIx(shuf);			% ��shuf����
