clear;
n=3;%No of parameters
m=3;%No of traning data sets
h=1;%No of hidden layers
l=15;%No of iterations
n=n+1;
%w=w+(T-y)x
DATA=[1 2 3 0;4 6 7 1;0 1 2 0];%Input data, (parameter1 parameter2 .. parameter n Output;... upto m times)


% q=1;r=1;
% for i=1:m
%     if DATA(i,3)==1
%         STAR(q,:)=DATA(i,1:2);
%         q=q+1;
%     else
%         MOON(r,:)=DATA(i,1:2);
%         r=r+1;
%     end
% end
% hold on;
% plot(STAR(:,1),STAR(:,2),'*');
% plot(MOON(:,1),MOON(:,2),'o');

w(1+h,1:n)=0.5;%Intitialization of weighted matrix
d=0.05;%Rate of gradient descent
one(1:m,1)=1;%Bais value
D=0;%No of iteration counter
DATA=[DATA(:,1:n-1) one DATA(:,n)];
while 1
    D=D+1;
    W=w;
    for i=1:m
        sum=0;
        for j=1:n
            sum=sum+DATA(i,j)*w(j);
        end
        if(sum>0.5)
            O=1;
        else
            O=0;
        end
        for j=1:n
            w(j)=w(j)+(DATA(i,n+1)-O)*DATA(i,j)*d;
        end
    end
    if abs(W-w)<0.05
        break;
    end
end

for i=1:m
    sum(i)=0;
    for j=1:n
        sum(i)=sum(i)+DATA(i,j)*w(j);
    end
    if(sum(i)>0.5)
        O(i)=1;
    else
        O(i)=0;
    end
end
w
D
OUTPUT=[DATA(:,1:2) DATA(:,4) O.']
sums=0;
for i=1:n-1
    prompt='Enter the value of the parameter ';
    x=input(prompt);
    sums=sums+x*w(i);
end
sums=sums+1*w(n);
if(sums>0.5)
        Ans=1
    else
        Ans=0
end