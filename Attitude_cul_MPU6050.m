clear;clc;

scom1 = instrfind('Type', 'serial', 'Port', 'COM7', 'Tag', ''); % 查找串口对象
if isempty(scom1)               % 如果串口对象不存在则建立
    scom1 = serial('COM7');
else                      % 否则使用已存在的对象
    fclose(scom1);
    scom1 = scom1(1);
end

scom1.baudrate=9600;          % 波特率115200（Arduino支持的最高波特率）
scom1.OutputBufferSize = 4096;  % 修改输出缓冲区
%object.BytesAvailableFcn = @fcntion_callback;%设置串口执行的回调函数（这个属性比较重要）；
%fopen(scom1);
fopen(scom1);
while(1)
data = fscanf(scom1,'A%f,%f,%f G%f,%f,%f');
%fprintf('%s\n',data);
if(scom1.BytesAvailable)    %清空缓冲区
    fread(scom1,scom1.BytesAvailable);
%fprintf('%f,%f\n',phi_acc,theta_acc);
end

phi_acc =  (atan2( --data(2),(sqrt(data(3) ^ 2 + data(1) ^ 2))))/3.14*180;
theta_acc= (atan2( -data(1), sqrt(data(3) ^ 2 + data(2) ^ 2)))/3.14*180;
% put your figure code here%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b=0:0.2:2*pi;

[X,Y]=meshgrid(-6:0.1:6);

Z=0*X+0*Y+20;

h = meshc(X,Y,Z);

view(-115,40)
axis([-10 10 -10 10 0 30])
%实现旋转视图,动态观看
view(phi_acc,theta_acc);
pause(0.01);
%xlabel('x轴');ylabel('y轴');zlabel('z轴');

end




