clear all;

% M 质量， B 阻尼， K 刚度
M=1;  B=20;  K=32;

x = linspace(0,2*pi,100);
y = sin(x);

% for simple test
b=5*ones(100,1);
% for sin test
%b=5*y';

a=zeros(100,2);   c=zeros(100,3); d=zeros(100,6);
Fe=[a,b,c;d];     %产生的100行6列的矩阵,且只在前半段时间z轴方向有向下的力，后50行无力，后期得改为六维力的数据
Fxe=Fe(:,1);Fye=Fe(:,2);Fze=Fe(:,3);Txe=Fe(:,4);Tye=Fe(:,5);Tze=Fe(:,6);
Fd = zeros(200,1);

dt=0.01 ;  %时间间隔0.01

ze(1)=0;  dze(1)=0;  ddze(1)=0; 
Tze(1)=0;  dTze(1)=0;  ddTze(1)=0; 

for i=1:199
    %x = [(Fze(i+1) - Fd(i+1))];
    %y = -B*dze(i)-K*ze(i);
    %ddze(i+1)=x-y;
    ddze(i+1) = Fze(i)-B*dze(i)-K*ze(i);
    dze(i+1)=dt*ddze(i+1)+dze(i);
    ze(i+1)=dt*dze(i+1)+ze(i);

    % for sin
    if abs(ze(i+1)-0.04) <0.001
    %    Fze(i+1) = -3000 * abs(0.04-ze(i));
    end

    % for simple test
    if abs(ze(i+1) - 0.06) < 0.001
        Fze(i+1) = -60 * abs(0.04-ze(i));
    end
end

line_x = 0.04*ones(200,1);
line_y = linspace(0,200,200);
line_x2 = 0.06*ones(200,1);
%hold on;
figure(4);
subplot(2,2,1);
plot(Fze);
title("Fze");
subplot(2,2,2);
plot(ze);
hold on
% for sinx
plot(line_x(:,1));
plot(line_x2(:,1)');
title("ze");
subplot(2,2,3);
plot(dze,"r");
title("dze");
subplot(2,2,4);
plot(ddze,"g");
title("ddze");