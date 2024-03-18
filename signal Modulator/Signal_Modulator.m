clear; clc;
a = input('enter start point ');
b = input('enter end point: ');
f = input('enter frequency: ');
n = input('enter n of break points: ');
x = [a];
t =linspace(a,b,(b-a)*f);
for i=1:n;
    fprintf('interval %d end: ',i);
    x0 = input('enter x position: ');
    x = [x x0];
end
x = [x b];
y=[];
for i=1:n+1
        fprintf('interval number %d :  ',i);
        k = input('enter the type of the signal :  ','s');
        if  k=='a'
                A =input('enter amplitude:  ');
                y0= A*ones(1,f*(x(i+1)-x(i)));
                y=[y y0];
                y0=[];
        elseif k =='b'
                slope =input('enter slope:  ');
                interct =input('enter interct:  ');
                y0= slope*t +interct;
                y0 = y0(     f*  (x(i)-a) +1    :   f*(x(i+1)-a)    );
                y=[y y0];
        elseif k =='c'
                A =input('enter amplitude:  ');
                power =input('enter power :  ');
                interct =input('enter interct :  ');
                y0= A*(t.^power) +interct;
                y0 = y0(     f*  (x(i)-a) +1    :   f*(x(i+1)-a)    );
                y=[y y0];
        elseif k =='d'
                A =input('enter amplitude:  ');
                ex =input('enter exponnent:  ');
                y0= A*(exp(ex*t));
                y0 = y0(     f*  (x(i)-a) +1    :   f*(x(i+1)-a)    );
                y=[y y0];
        elseif k =='e'
                A =input('enter amplitude:  ');
                freq =input('enter frequency :  ');
                phase =input('enter phase :  ');
                y0= A*sin(pi*freq*t+phase);
                y0 = y0(     f*  (x(i)-a) +1    :   f*(x(i+1)-a)    );
                y=[y y0];
        end
end
subplot(2,2,1);
plot(t,y);
modify = input('what type of modif you want:  ','s');
if modify =='a'
    a = input('enter scalling value: ');
    y = y*a;
    elseif  modify =='b'
        t = -t;
        elseif  modify =='c'
            a = input('enter shift value: ');
            t = t-a;
            elseif  modify =='d'
                a = input('enter expand value: ');
                t = t*a;
                elseif  modify =='e'
                  a = input('enter comp value: ');
                     t = t/a;

else 
end
subplot(2,2,2);
plot(t,y);

    




