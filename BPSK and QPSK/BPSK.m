clear; clc;
N = 16; 
data = randi([0 1],1,N);  
S = pskmod(data,2,0);
SNR = 10;  
Rec = awgn(S,SNR);
f=10^3;
T=1/f;
t = 0:(T/1000):T ; 
sent_sig = [];
for l=1:length(data)
    Transimit = real(S(l))*cos(2*pi*f*t) + imag(S(l))*sin(2*pi*f*t); 
    sent_sig = [sent_sig Transimit]; 
end
Reciecved_signal = awgn(sent_sig,SNR);
figure(3);
plot(sent_sig); 
ylim([-1.5,1.5]); xlim([0,N*10^3+N]);
figure(4);
plot(Reciecved_signal);
xlim([0,N*10^3+N]);
 scatterplot(Rec); 
 scatterplot(S); 
 s1=abs(S);
 r1=abs(Rec);
 [x,q]=biterr(round(100*s1),round(100*r1));
 x = x /100;
 q = q/100;