function SelCh = Select(Chrom,FitnV,GGAP)
%���룺
%   Chrom ��Ⱥ
%   FitnV ��Ӧ��ֵ
%   GGAP ѡ�����
%�����
%   SelCh �Ӵ���Ⱥ

NIND = size(Chrom,1);			% ��Ⱥ��������
% ȷ���Ӵ���Ⱥ�ĸ������������������ͼ�Ϊ����
NSel = max(floor(NIND * GGAP+.5),2);			% floor()�����������ȡ��
ChrIx = Sus(FitnV,NSel);
SelCh = Chrom(ChrIx,:);
