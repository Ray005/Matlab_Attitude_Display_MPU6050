clear;clc;

scom1 = instrfind('Type', 'serial', 'Port', 'COM7', 'Tag', ''); % ���Ҵ��ڶ���
if isempty(scom1)               % ������ڶ��󲻴�������
    scom1 = serial('COM7');
else                      % ����ʹ���Ѵ��ڵĶ���
    fclose(scom1);
    scom1 = scom1(1);
end

scom1.baudrate=9600;          % ������115200��Arduino֧�ֵ���߲����ʣ�
scom1.OutputBufferSize = 4096;  % �޸����������
%object.BytesAvailableFcn = @fcntion_callback;%���ô���ִ�еĻص�������������ԱȽ���Ҫ����
%fopen(scom1);
fopen(scom1);
while(1)
data = fscanf(scom1,'A%f,%f,%f G%f,%f,%f');
%fprintf('%s\n',data);
if(scom1.BytesAvailable)    %��ջ�����
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
%ʵ����ת��ͼ,��̬�ۿ�
view(phi_acc,theta_acc);
pause(0.01);
%xlabel('x��');ylabel('y��');zlabel('z��');

end




