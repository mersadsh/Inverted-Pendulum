clear
close all
clc
tic
%% Algorithm DATA
C1=2;
C2=2;
w=0.729;
It=100;
Ps=20;
%% Problem DATA

M = 0.5;
m = 0.2;
b = 0.1;
I = 0.006;
g = 9.8;
l = 0.3;
q = (M+m)*(I+m*l^2)-(m*l)^2;


%% PSO Parameters
Npar=3;
Xmax=[1000 1000 1000];
Xmin=[0   0   0];
%% Initialization
X=zeros(Ps,Npar);
Y=zeros(Ps,1);
V=zeros(Ps,Npar);
Lbestval=zeros(Ps,1);
Lbest=zeros(Ps,Npar);
for i=1:Ps
    X(i,:)=round(rand(1,Npar).* (Xmax - Xmin) + Xmin,4);
    Y(i)=fun(X(i,:));
    V(i,:)=round(rand(1,Npar),4);
    Lbest(i,:)=X(i,:);
    Lbestval(i,:)=Y(i,:);
end
Gbestnum=find(Y==min(Y));
Gbestval=10^20;
Gbest=0;
if Y(Gbestnum)<10000
    Gbestval=Y(Gbestnum);
    Gbest=X(Gbestnum,:);
end
GB=[];
%% Main Part
for i=1:It
    for j=1:Ps
        V(j,:)=w*V(j,:)+C2*rand*(Gbest-X(j,:))+C1*rand*(Lbest(j,:)-X(j,:));
        X(j,:)=round(X(j,:)+V(j,:),4);
        for k=1:Npar
            if X(j,k)>Xmax(1,k); X(j,k)=Xmax(1,k);end
            if X(j,k)<Xmin(1,k); X(j,k)=Xmin(1,k);end
        end
        Y(j,:)=fun(X(j,:));
        if Y(j,:)<Lbestval(j,:)
            Lbestval(j,:)=Y(j,:);
            Lbest(j,:)=X(j,:);
            if Y(j,:)<Gbestval
                Gbestval=Y(j,:);
                Gbest=X(j,:);
            end
        end
    end
    fprintf('The cost function is %f for [Kp Ki Kd]=[%f %f %f]\n',Gbestval,Gbest(1),Gbest(2),Gbest(3))
    GB=[GB;Gbestval];
end
plot(1:It,GB)
toc