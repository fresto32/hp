%   SIMPLE CODE FOR VISUALIZING QUATERNION DATA FROM IMU (Ex.MPU6050 DMP)
%          You have to send data According to:
%          qw(\t)qx(\t)qy(\t)qz(\t)(' ')

clear; clc; close all; 
%Creat Port
s = serial('/dev/cu.usbmodem641');
%Open Port 
fopen(s);
%Set Terminator
set(s,'BaudRate',115200);
set(s,'Terminator',' ');fscanf(s);
%Read First Data for Calibration 
a(1,:)=fscanf(s,'%f');
yaw_c = a(1,1);
pitch_c = a(1,2);
roll_c = a(1,3);

for frame=1:1:1000
    frame
    %Read Data;
    a(frame,:)=fscanf(s,'%f');
    %Convert Quaternion to Roll Pitch Yaw
    %[yaw, pitch, roll] = a(frame,:);
    yaw = a(frame,1);
    pitch = a(frame,2);
    roll = a(frame,3);
    %Visualize Data On Sphere Or any Other Objects
    [x,y,z] = cylinder;h = surf(x,y,z);axis('square'); 
    title('3D Visualization')
    xlabel('x'); ylabel('y'); zlabel('z');
    %Rotate Object
    rotate(h,[1,0,0],(roll))
    rotate(h,[0,1,0],(pitch))
    rotate(h,[0,0,1],(yaw))
    view(0,0);
    drawnow
end
fclose(s);