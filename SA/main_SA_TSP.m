close all
clear           %���б���ȫ��ɾ��
clc             %��������д����е�����

a = 0.99; %�¶�˥������
t0 = 97; tf = 3; t = t0; %��ʼ�¶� ��ֵ
Markov_length = 10000; %Markov������

coordinates = load('city_location.mat').city_location;
%{
coordinates = [
1 565.0 575.0;
2 25.0 185.0;
3 345.0 750.0;
4 945.0 685.0;
5 845.0 655.0;
6 880.0 660.0;
7 25.0 230.0;
8 525.0 1000.0;
9 580.0 1175.0;
10 650.0 1130.0;
11 1605.0 620.0;
12 1220.0 580.0;
13 1465.0 200.0;
14 1530.0 5.0;
15 845.0 680.0;
16 725.0 370.0;
17 145.0 665.0;
18 415.0 635.0;
19 510.0 875.0;
20 560.0 365.0;
21 300.0 465.0;
22 520.0 585.0;
23 480.0 415.0;
24 835.0 625.0;
25 975.0 580.0;
26 1215.0 245.0;
27 1320.0 315.0;
28 1250.0 400.0;
29 660.0 180.0;
30 410.0 250.0;
31 420.0 555.0;
32 575.0 665.0;
33 1150.0 1160.0;
34 700.0 580.0;
35 685.0 595.0;
36 685.0 610.0;
37 770.0 610.0;
38 795.0 645.0;
39 720.0 635.0;
40 760.0 650.0;
41 475.0 960.0;
42 95.0 260.0;
43 875.0 920.0;
44 700.0 500.0;
45 555.0 815.0;
46 830.0 485.0;
47 1170.0 65.0;
48 830.0 610.0;
49 605.0 625.0;
50 595.0 360.0;
51 1340.0 725.0;
52 1740.0 245.0;
];
%}
% coordinates(:,1) = []; %ȥ����һ�еĳ��б��
amount = size(coordinates,1); %������и���

%ͨ���������ķ������������󣨱�����������֮��ľ��룩
coor_x_tmp1 = coordinates(:,1) * ones(1,amount);
coor_x_tmp2 = coor_x_tmp1';
coor_y_tmp1 = coordinates(:,2) * ones(1,amount);
coor_y_tmp2 = coor_y_tmp1';
dist_matrix = sqrt((coor_x_tmp1 - coor_x_tmp2).^2 + (coor_y_tmp1 - coor_y_tmp2).^2);

%������ʼ��
sol_new = 1:amount;
%sol����ǰ·�� new����ÿ�β������½� current����ǰ�� best������ȴ�����е����Ž�
E_current = inf;
E_best = inf;
%E����Ŀ�꺯����ֵ Ҳ���Ǿ���� new�����½�ı������� best���Ž�
sol_current = sol_new;
sol_best = sol_new;
p = 1; %��ʼ��P

figure;
hold on;
box on;
xlim([tf,t0]);
title('�Ż�����')
xlabel('��ǰ�¶�')
ylabel('��ǰ���Ž�')

while t >= tf %���¶ȴ���ֹͣ�¶�ʱ
    for r = 1:Markov_length %Markov������
        %��������Ŷ�
        if(rand < 0.5) %�����������������������
            %������
            ind1 = 0; ind2 = 0;
            while(ind1 == ind2)
                ind1 = ceil(rand.*amount); %�����������������
                ind2 = ceil(rand.*amount);
            end
            tmp1 = sol_new(ind1);
            sol_new(ind1) = sol_new(ind2);
            sol_new(ind2) = tmp1;
        else
            %������
            ind1 = 0; ind2 = 0; ind3 = 0;
            while(ind1 == ind2) || (ind1 == ind3) || (ind2 == ind3) || (abs(ind1 - ind2) == 1) %���任������֮��û��·��
                ind1 = ceil(rand.*amount);
                ind2 = ceil(rand.*amount);
                ind3 = ceil(rand.*amount);
            end
                %tmp1 = ind1;tmp2 = ind2;tmp3 = ind3;
                %����ind1<ind2<ind3
                ind = [ind1 ind2 ind3];
                ind_sort = sort(ind);
                ind1 = ind_sort(1);
                ind2 = ind_sort(2);
                ind3 = ind_sort(3);
                %���н���
                
                tmplist1 = sol_new((ind1 + 1):(ind2 - 1));
                sol_new((ind1 + 1):(ind1 + ind3 - ind2 + 1)) = sol_new((ind2) : (ind3));
                sol_new((ind1 + ind3 - ind2 + 2):ind3) = tmplist1;
        end
        %����Ƿ�����Լ������
        %����Ŀ�꺯������ֵ����������ܣ�
        E_new = 0;
        for i = 1 : (amount - 1)
            E_new = E_new + dist_matrix(sol_new(i),sol_new(i+1));
        end
        %�������һ������һ���ľ���
        E_new = E_new + dist_matrix(sol_new(amount),sol_new(1)); 
        if E_new < E_current %�����ָ��Ž�ʱ ����Ϊ���Ž��·�ߺ�Ŀ�꺯��ֵ
            E_current = E_new;
            sol_current = sol_new;
            if E_new < E_best
                pre_E_best = E_best;
                E_best = E_new;
                sol_best = sol_new;
            end
        else
        %һ����Χ�ڽ��ܷ��Ž�
            if rand < exp(-(E_new - E_current)./t)
                E_current = E_new;
                sol_current = sol_new;
            else
                sol_new = sol_current;
            end
        end
    end
    pre_t = t;
    t = t.* a;%���¿��Ʋ���tΪԭ����a��
    line([pre_t,t],[pre_E_best,E_best]);
    pause(0.0001);

end

disp('���Ž�Ϊ:')
for i = 1 : amount
fprintf('->%d', sol_best(i));
end
fprintf('\n');
disp('��̾���Ϊ:')
disp(E_best);


