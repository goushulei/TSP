function [a,b] = intercross(a,b)
%���룺
%   a��bΪ����������ĸ���
%�����
%   a��bΪ�����õ�����������
L = length(a);
r1 = randsrc(1,1,[1:L]);			% ʹ��[1:L]�е���������һ��1 * 1����
r2 = randsrc(1,1,[1:L]);
if r1~=r2
    a0 = a;
    b0 = b;
    s = min([r1,r2]);
    e = max([r1,r2]);
    for i =s:e			% ��������ɵ���������֮������ݶζ���������
        a1 = a;
        b1 = b;
        a(i) = b0(i);			% ������Ⱥ֮�䣬ͬλ�ý�����һ��	% �����һ���ظ�
        b(i) = a0(i);
        x = find(a==a(i));			% �ҵ��ظ�λ�õ��±�
        y = find(b==b(i));
        i1 = x(x~=i);			% ��ȥ��һ�ν�������λ��
        i2 = y(y~=i);
        if ~isempty(i1)			% ��ɵڶ��ν���
            a(i1)=a1(i);
        end
        if ~isempty(i2)
            b(i1)=b1(i);
        end
    end
end
