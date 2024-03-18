clear; clc;
fs = 48000;
sec = 7;
[y, fs] = audioread('test.wav');
t = linspace(0,sec,sec*fs);
f  = linspace(-fs/2,fs/2,length(y));
subplot(3,3,1);
plot(t,y);
Y = abs(fftshift(fft(y)))/length(y);
subplot(3,3,2);
plot(f,Y);
[NUM, DEN] = butter(10, 2*4000/fs); 
y1 = amdemod(y, 4000, fs, 0, 0,NUM, DEN);
subplot(3,3,3);
plot(t,y1);
Y= abs(fftshift(fft(y1)))/length(y1);
subplot(3,3,4);
plot(f,Y);
error1 = mean((y - y1).^2);
disp("error1 is: ");
disp(error1);
ymod = fmmod(y1 , 1e6, 2e8, 0.01);
subplot(3,3,5);
plot(t,ymod);

ydem = fmdemod(ymod, 1e6, 2e8, 0.1);
subplot(3,3,6);
plot(t,ydem);
audiowrite("demodul1.wav", ydem, fs);

%-------------------------------------

error2 = mean((y1 - ydem).^2);
disp("error2 is: ");
disp(error2);



with_error = awgn(y1, 10, 'measured');
subplot(3,3,7);
plot(t,with_error);
ymod = fmmod( with_error, 1e6, 2e8, 0.01);
subplot(3,3,8);
plot(t,ymod);

ydem = fmdemod(ymod, 1e6, 2e8, 0.1);
subplot(3,3,9);
plot(t,ydem);

audiowrite("demodul2.wav", ydem, fs);
error3 = mean((with_error - ydem).^2);
disp("error3 is: ");
disp(error3);





