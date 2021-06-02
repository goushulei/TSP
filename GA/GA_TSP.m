clear
clc
close all

%加载数据
load('city_location.mat');

%可视化数据
location = load('city_location.mat');
x = location.city_location(:,1);
y = location.city_location(:,2);
plot(x,y,'ko');
xlabel('城市横坐标x');
ylabel('城市纵坐标y');
grid on;

NIND = 500;         % 种群大小
MAXGEN = 10000;      % 最大迭代次数
Pc = 0.9;           % 交叉概率，相当于基因遗传的时候染色体交叉
Pm = 0.1;          % 染色体变异
GGAP = 0.9;         % 这个是代沟，通过遗传方式得到的子代数为父代数 * GGAP

D = Distance(city_location);	% 通过这个函数可以计算i,j两点之间的距离
N = size(D,1);                  %计算有多少个坐标点
%%初始化种群
Chrom = InitPop(NIND,N);        %Chrome代表的种群

%%画出随机解得路线图
DrawPath(Chrom(1,:),city_location)
pause(0.0001)
%输出随机解的路线和总距离
disp('初始种群中的一个随机值')
OutputPath(Chrom(1,:));%其中一个个体
Rlength = PathLength(D,Chrom(1,:));
disp(['总距离;',num2str(Rlength)]);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

%优化
gen = 0;            % 迭代次数初始为0
figure;
hold on;
box on;
xlim([0,MAXGEN])
title('优化过程')
xlabel('迭代次数')
ylabel('当前最优解')
ObjV = PathLength(D,Chrom);         % 计算当前路线长度，即上面随机产生的那些个体路径
preObjV = min(ObjV);            % 当前最优解
while gen < MAXGEN
    %%计算适应度
    ObjV = PathLength(D,Chrom);     %计算路线长度
    line([gen - 1,gen],[preObjV,min(ObjV)]);			% 在新的最优解坐标与上次最优解坐标之间画条线
    pause(0.0001);			% 暂停0.0001秒
    preObjV = min(ObjV);			% 更新当前最优解
    FitnV = Fitness(ObjV);			% 计算染色体适应度
    %选择
    SelCh = Select(Chrom,FitnV,GGAP);
    %交叉操作
    SelCH = Recombin(SelCh,Pc);
    %变异
    SelCh = Mutate(SelCh,Pm);
    %逆转操作
    SelCh = Reverse(SelCh,D);
    %重插入子代的新种群
    Chrom = Reins(Chrom,SelCh,ObjV);
    %更新迭代次数
    gen = gen + 1;
end

%画出最优解的路线图
ObjV = PathLength(D,Chrom);     %计算路线长度
[minObjV,minInd] = min(ObjV);
DrawPath(Chrom(minInd(1),:),city_location)
%%输出最优解的路线和距离
disp('最优解:')
p = OutputPath(Chrom(minInd(1),:));
disp(['旅行商走过的总距离：',num2str(ObjV(minInd(1)))]);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
