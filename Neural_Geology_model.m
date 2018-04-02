clear;
m=4; %Training Data set
n=3; %No of features
h=1; %No of hidden layers
os=1;%Output solutions

DATA=[1 2 3; 4 6 7; 0 1 2; 5 5 4];%Input
I=DATA;
Y=[0; 1; 0;1];%Output

ONES(1:m,1)=1;
DATA=[ONES DATA];
n=n+1; %Additon of a Bais Value
DATA=DATA.'

O(1:n,1:h+1,1:m)=0;%row(feature),column(Layer no),Data set no
for i=1:m
    O(1:n,1,i)=DATA(:,i);
    O(1,1:h+1,i)=1;
end
O;
if h~=0
    w(1:n,1:n,1:h)=0.5 %input to output, hidden layer number
end
wf(1:n,1:os)=0.5;
d=0.05;%Rate of gradient descent
r=0;%iteration counter
lp=0.10;%Learning Parameter

mp=1;%Gradient Descent

for r=1:100000
    for i=1:m
        if h~=0
            for j=1:h
                O(:,j+1,i)=w(:,:,j)*O(:,j,i);
                for k=1:n
                    O(k,j+1,i)=sigm(O(k,j+1,i));
                end
                O(1,j+1,i)=1;
            end
        else
            j=0;
        end
        x(i)=wf.'*O(:,j+1,i);
        x(i)=sigm(x(i))
        error=0.5*(Y(i)-x(i))^2;
        t=lp*(Y(i)-x(i))*(1+x(i))*(1-x(i));
        wf=wf+t*O(:,h+1,i);
        if h~=0
            for j=h:-1:1
                pro=t*wf;
                for a=h:-1:j
                    pro=pro.*((1-O(:,a+1,i)).*O(:,a+1,i));
                    if a~=j
                        pro=pro.*w(:,:,a);
                    else
                        pro=pro.*[O(:,a,i) O(:,a,i) O(:,a,i) O(:,a,i)];
                    end
                end
                w(:,:,j)=w(:,:,j)+pro;
            end
        end
    end
    for k=1:m
        if x(k)>0.5
            u(k)=1;
        else
            u(k)=0;
        end
    end
    if u.'==Y
        %break;
    end
end
O;
[I Y x.']
[I Y u.']

function s=sigm(x)
    s=1/(1+exp(-x));
end


