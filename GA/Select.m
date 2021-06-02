function SelCh = Select(Chrom,FitnV,GGAP)
%输入：
%   Chrom 种群
%   FitnV 适应度值
%   GGAP 选择概率
%输出：
%   SelCh 子代种群

NIND = size(Chrom,1);			% 种群个体总数
% 确定子代种群的个体数，如果不足二个就计为二个
NSel = max(floor(NIND * GGAP+.5),2);			% floor()朝负无穷大方向取整
ChrIx = Sus(FitnV,NSel);
SelCh = Chrom(ChrIx,:);
