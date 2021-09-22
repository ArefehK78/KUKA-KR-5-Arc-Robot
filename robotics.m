
syms theta1;
syms theta2;
syms theta3;
syms theta4;
syms theta5;
syms theta6;

T1 = Transform( 75 , -pi/2 , 335 , theta1);
T1(2,1)=0;
T1(2,2)=0;
T1(3,3)=0;
T1(3,4)=0;

T2 = Transform( 270 , 0 , 0 , theta2);


T3 = Transform( 90 , pi/2 , 0 , theta3);
T3(2,1)=0;
T3(2,2)=0;
T3(3,3)=0;
T3(3,4)=0;

T4 = Transform( 0 , pi , 295 , theta4);
T4(3,1)=0;
T4(3,2)=0;
T4(2,3)=0;
T4(2,4)=0;


T5 = Transform( 0 , -pi/2 , 0 , theta5);
T5(2,1)=0;
T5(2,2)=0;
T5(3,3)=0;

T6 = Transform( 0 , pi , 80 , theta6);
T6(3,1)=0;
T6(3,2)=0;
T6(2,3)=0;
T6(2,4)=0;

% Forward Kinematic 
T = T1*T2*T3*T4*T5*T6;


%End Effector POS
End_Effector_pos = T(1:3,4);

j1 = linspace(-155,155,10)*pi/180;
j2 = linspace(-180,65,10)*pi/180;
j3 = linspace(-15,158,10)*pi/180;
j4 = linspace(-350,350,10)*pi/180;
j5 = linspace(-130,130,10)*pi/180;
j6 = linspace(-350,350,10)*pi/180;


[theta0,theta1,theta2,theta3,theta4,theta5] = ndgrid(j1,j2,j3,j4,j5,j6);
X = 270.*cos(theta1) + 90.*cos(theta1).*cos(theta2) - 295.*cos(theta1).*sin(theta2) - 295.*cos(theta2).*sin(theta1) - 90.*sin(theta1).*sin(theta2) + 80.*cos(theta3).*sin(theta4).*(cos(theta1).*cos(theta2) - sin(theta1).*sin(theta2)) - 80.*cos(theta4).*sin(theta3).*(cos(theta1).*cos(theta2) - sin(theta1).*sin(theta2)) + 75;
Y = 80.*cos(theta3).*cos(theta4) + 80.*sin(theta3).*sin(theta4) + 335;
Z = 295.*sin(theta1).*sin(theta2) - 295.*cos(theta1).*cos(theta2) - 90.*cos(theta1).*sin(theta2) - 90.*cos(theta2).*sin(theta1) - 270.*sin(theta1) - 80.*cos(theta3).*sin(theta4).*(cos(theta1).*sin(theta2) + cos(theta2).*sin(theta1)) + 80.*cos(theta4).*sin(theta3).*(cos(theta1).*sin(theta2) + cos(theta2).*sin(theta1));
 
figure(1)
plot3(X(:),Y(:),Z(:),'.')

RVC --- Setting the Links
Link1 = Link('d',335,'a',75,'alpha',-pi/2);
Link2 = Link('d',0,'a',270,'alpha',0);
Link3 = Link('d',0,'a',90,'alpha',pi/2);
Link4 = Link('d',295,'a',0,'alpha',pi);
Link5 = Link('d',0,'a',0,'alpha',-pi/2);
Link6 = Link('d',80,'a',0,'alpha',pi);

Robot = SerialLink([Link1 Link2 Link3 Link4 Link5 Link6],'name','Kuka kr5');

Theta Inputs
    T1= 0;
    T2= -45;
    T3= 90;
    T4= 45;  % or 270 degrees
    T5= 45;
    T6= -10;
    Input Conversion
    T1 = T1*pi/180;
    T2 = T2*pi/180;
    T3 = T3*pi/180;
    T4 = T4*pi/180;
    T5 = T5*pi/180;
    T6 = T6*pi/180;
    T = [T1,T2,T3,T4,T5,T6];

figure(2)
Robot.plot(T);

q = Robot.fkine(T);
q2 = Robot.fkine([0,45,120,90,90,0]);
T1 = transl(538.2,-80,670.9);
T2 = transl(538.2,-80,670.9);
traj = ctraj(q,q2,100);
ikine = Robot.ikine(traj);
figure(3)
Robot.plot(ikine)
