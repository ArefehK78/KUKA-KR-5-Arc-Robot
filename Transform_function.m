clc
close
clear

%% DH parameters

syms q1 q2 q3 q4 q5 q6

syms theta1 theta2 theta3 theta4 theta5 theta6
T1 = Transform( 75 , -pi/2 , 335 , q1)
T1(2,1)=0
T1(2,2)=0
T1(3,3)=0
T1(3,4)=0

T2 = Transform( 270 , 0 , 0 , q2)


T3 = Transform( 90 , pi/2 , 0 , q3)
T3(2,1)=0
T3(2,2)=0
T3(3,3)=0
T3(3,4)=0

T4 = Transform( 0 , pi , 295 , q4)
T4(3,1)=0
T4(3,2)=0
T4(2,3)=0
T4(2,4)=0


T5 = Transform( 0 , -pi/2 , 0 , q5)
T5(2,1)=0
T5(2,2)=0
T5(3,3)=0

T6 = Transform( 0 , pi , 80 , q6)
T6(3,1)=0
T6(3,2)=0
T6(2,3)=0
T6(2,4)=0

T = T1*T2*T3*T4*T5*T6;

x = T(1,4);
y = T(2,4);
z = T(3,4);
disp('x = ');disp(x);
disp('y = ');disp(y);
disp('z = ');disp(z);

%% %% %% Jacobian

syms q1_dot q2_dot q3_dot q4_dot q5_dot q6_dot
J = [diff([x;y;z],[q1]), diff([x;y;z],[q2]), diff([x;y;z],[q3]), diff([x;y;z],[q4]), diff([x;y;z],[q5]), diff([x;y;z],[q6])] ;
J_dot = diff(J,q1)*q1_dot + diff(J,q2)*q2_dot + diff(J,q3)*q3_dot + diff(J,q4)*q4_dot + diff(J,q5)*q5_dot + diff(J,q6)*q6_dot ;

disp('Jacobian = ');disp(J);
disp('Jacobian_dot = ');disp(J_dot);
%% Transfer function

function T = Transform (a_i_1,alpha_i_1,d_i,theta_i)

c_theta = cos(theta_i);
s_theta = sin(theta_i);

c_alpha = cos(alpha_i_1);
s_alpha = sin(alpha_i_1);

t11 = c_theta;
t12 = -s_theta;
t13 = 0;
t14 = a_i_1;

t21 = s_theta*c_alpha;
t22 = c_theta*c_alpha;
t23 = -s_alpha;
t24 = -s_alpha*d_i;

t31 = s_theta*s_alpha;
t32 = c_theta*s_alpha;
t33 = c_alpha;
t34 = c_alpha*d_i;

t41 = 0;
t42 = 0;
t43 = 0;
t44 = 1;

T = [t11 t12 t13 t14;...
    t21 t22 t23 t24;...
    t31 t32 t33 t34;...
    t41 t42 t43 t44];

end

