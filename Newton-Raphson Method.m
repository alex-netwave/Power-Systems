%Newton-Raphson Method
%Iterative method of approximating values to variables
clear; clc; close all;
syms x; syms y;
f=[(x^2)*y;(y^2)*x];
const=[45;50];
%Initial conditions for x and y: x(0), y(0)
X(1)=1;Y(1)=1;
%Note - Form: 
%20x + 10y = 300  |   ax + by = const(1) 
%10x + 10y = 200  |   cx + dy = const(2)

%Jacobian matrix - the below are equivalent
J1=[diff(f(1), x) diff(f(1),y); diff(f(2), x) diff(f(2),y)];
J=[diff(f,x), diff(f,y)];

numIt=2; % Number of iterations
for i=1:numIt %Iterative calculations
    quad = const-subs(f, [x,y], [X(i), Y(i)]);
    r=[X(i); Y(i)]+inv(J)*quad;
    r=subs(r,[x,y],[X(i),Y(i)]);
    [X(i+1),Y(i+1)]=deal(r(1),r(2));
end
x=X';y=Y';i=[0:numIt]'; %Table rows and names
table(i,x,y) %Create and display table
