fs = 48000;
sec = 7;
recorder = audiorecorder(fs, 16, 1);
disp('stat recording');
recordblocking(recorder, sec);
disp('end recording');
audio = getaudiodata(recorder);
audiowrite('test.wav', audio, fs);
%%
clear; clc;
fs = 48000;
sec = 7;
[y, fs] = audioread('test.wav');
t = linspace(0,sec,sec*fs);
subplot(2,2,1);
plot(t,y);
Y=abs(fftshift(fft(y)));
subplot(2,2,2);
plot(t,Y); 
Y=abs(fftshift(fft(Y)));
Y2 = lowpass(Y,4000);
Y2 = iff(Y2)
subplot(2,2,3);
plot(t,Y2); 
Error = sum(abs(Y2.^2-y.^2));
%%
modu = (max(y)+y)'.*cos(2*pi*10^6*t);
subplot(2,2,2);
plot(t,modu);

%%
clear ; clc;
sec = 7;
[y, fs] = audioread('test.wav');
t = linspace(0,sec,sec*fs);
subplot(2,2,1);
plot(t,y);
modu1 = (min(y)+y)'.*cos(2*pi*10^6*t);
subplot(2,2,2);
plot(t,modu1);
subplot(2,2,4);
env1 = envelope(modu1,48000);
plot(t,env1);
env1 = env1';
Error = sum(abs(y.^2-env1.^2))/length(y) * 100;
disp('error is: ');
disp(Error);
audiowrite('modu1.wav', env1,fs);




%%
clear; clc;
fs = 48000;
sec = 7;
[y, fs] = audioread('test.wav');
t = linspace(0,sec,sec*fs);
subplot(2,2,1);
plot(t,y);
modu1 = (min(y)+y)'.*cos(2*pi*10^6*t);
subplot(2,2,2);
plot(t,modu1);

modu2 = modu1' + 0.1*rand(size(y)) ;
subplot(2,2,4);
plot(t,modu2);
env2 = envelope(modu2,48000);
plot(t,env2);
Error = sum(abs(y.^2 - env2.^2))/length(y) * 100;
disp('error is: ');
disp(Error);
audiowrite('modu2.wav', env2,fs);

