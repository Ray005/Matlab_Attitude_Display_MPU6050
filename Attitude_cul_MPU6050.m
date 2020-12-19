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

%Ϊ��ʾ�������ı����������꣩
point_a = [1,0,0]';
point_b = [0,-1,0]';
point_c = [0,1,0]';
point_d = point_b - 0.5 * (point_b - point_c);  
s_x = [point_a(1,1), point_b(1,1), point_c(1,1), point_a(1,1);
       point_a(1,1), point_c(1,1), point_d(1,1), point_a(1,1)];
s_y = [point_a(2,1), point_b(2,1), point_c(2,1), point_a(2,1);
       point_a(2,1), point_c(2,1), point_d(2,1), point_a(2,1)];
s_z = [point_a(3,1), point_b(3,1), point_c(3,1), point_a(3,1);
       point_a(3,1), point_c(3,1), point_d(3,1), point_a(3,1)];

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
point_a = RZ(RY(RX([1,0,0]',phi_acc),theta_acc),0);
point_b = RZ(RY(RX([0,-1,0]',phi_acc),theta_acc),0);
point_c = RZ(RY(RX([0,1,0]',phi_acc),theta_acc),0);
                    
point_d = point_b - 0.5 * (point_b - point_c);
s_x = [point_a(1,1), point_b(1,1), point_c(1,1), point_a(1,1);
point_a(1,1), point_c(1,1), point_d(1,1), point_a(1,1)];
s_y = [point_a(2,1), point_b(2,1), point_c(2,1), point_a(2,1);
point_a(2,1), point_c(2,1), point_d(2,1), point_a(2,1)];
s_z = [point_a(3,1), point_b(3,1), point_c(3,1), point_a(3,1);
point_a(3,1), point_c(3,1), point_d(3,1), point_a(3,1)];

h4 = surf(s_x, s_y, s_z);
grid on
xlim([-1 1])
ylim([-1 1])
zlim([-1 1])

h4.XData = s_x;
h4.YData = s_y;
h4.ZData = s_z;
pause(0.05);
end




