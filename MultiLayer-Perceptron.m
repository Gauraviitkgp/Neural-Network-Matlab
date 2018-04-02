clear;
m=4; %Training Data set
n=3; %No of features
h=1; %No of hidden layers Model than becomes [n+1 neurons(0): n+1 neurons(1) .. n+1 neurons (h): os]
os=1;%Output solutions

DATA=[1 2 3; 4 6 7; 0 1 2; 5 5 4];%Input 
I=DATA;%Backup of Data
Y=[0; 1; 0;1];%Output

ONES(1:m,1)=1;%Bais Value
DATA=[ONES DATA];
n=n+1; %Additon of a Bais Value
DATA=DATA.'

O(1:n,1:h+1,1:m)=0;%row(feature),column(Layer no),Data set no
for i=1:m
    O(1:n,1,i)=DATA(:,i);
    O(1,1:h+1,i)=1;%Setting up bais value
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

for r=1:100000 %Number of iterations
    for i=1:m %Number of datasets
        if h~=0 %For h=0 w=wf but dimensionality of wf and w are different hence different matrix is taken. for h=0 it becomes single layer perceptron
            for j=1:h
                O(:,j+1,i)=w(:,:,j)*O(:,j,i);
                for k=1:n
                    O(k,j+1,i)=sigm(O(k,j+1,i)); %Signum function applied
                end
                O(1,j+1,i)=1;%Setting up bais value
            end
        else
            j=0;
        end
        x(i)=wf.'*O(:,j+1,i); %Calculation of output
        x(i)=sigm(x(i)) %Signmum function
        error=0.5*(Y(i)-x(i))^2; %Error
        t=lp*(Y(i)-x(i))*(1+x(i))*(1-x(i)); 
        wf=wf+t*O(:,h+1,i); %Updatation of output weights
        if h~=0
            for j=h:-1:1 %Back Progagation
                pro=t*wf;
                for a=h:-1:j
                    pro=pro.*((1-O(:,a+1,i)).*O(:,a+1,i));
                    if a~=j
                        pro=pro.*w(:,:,a);
                    else
                        pro=pro.*[O(:,a,i) O(:,a,i) O(:,a,i) O(:,a,i)]; %Back Propagation algorithm
                    end
                end
                w(:,:,j)=w(:,:,j)+pro; %Updatation of weights
            end
        end
    end
    for k=1:m
        if x(k)>0.5
            u(k)=1; %if unit step function is used pegged at 0.5
        else
            u(k)=0;
        end
    end
    if u.'==Y
        %break;
    end
end
O;
[I Y x.']               %Output with signmun
[I Y u.']               %Output with unit step dunction

function s=sigm(x) 
    s=1/(1+exp(-x)); %Defination of signmum function
end


