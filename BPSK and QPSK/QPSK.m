clear; clc;
N = 16;  
input = randi([0 3],1,N);  
S = pskmod(input,4,pi/4);
stairs(input);
ylim([-0.5,4-0.5]); 
xlim([0,N]);
SNR = 10; 



R = awgn(S,SNR);
f=1000;
T=1/f;
t = 0:(T/1000):T ; 
tranS = [];
for l=1:length(input)
    T = real( S(l))*cos(2*pi*f*t) +imag(S(l))*sin(2* pi*f*t); 
    tranS = [tranS T]; 
end
RecSig = awgn(tranS,SNR);
plot(tranS); 
ylim([-1.5,1.5]); 
xlim([0,N*10^3+N]);
figure(4);
plot(RecSig);
xlim([0,N*10^3+N]);
scatterplot(R);
scatterplot(S);
s0=abs(S);
r0=abs(R);
[x,q]=biterr(round(100*s0),round(100*r0)); 
x = x/100;
q = q/100;
%%
M = 16;  
    SNR = 10;
EbV = 5:15;
EbV= EbV'; 
nbit = 100;
berEst = zeros(size(EbV));
for n = 1:length(EbV)
    numErrs = 0;
    numBits = 0;
    
    while numErrs < 200 && numBits < 1e7
        % Generate binary data and convert to symbols
        dataIn = randi([0 1],nbit,6);
        dataSym = bi2de(dataIn);
        
        % QAM modulate using 'Gray' symbol mapping
        txSig = qammod(dataSym,M);
        
        % Pass through AWGN channel
        rxSig = awgn(txSig,SNR);
        
        % Demodulate the noisy signal
        rxSym = qamdemod(rxSig,M);
        % Convert received symbols to bits
        dataOut = de2bi(rxSym,6);
        nErrors = biterr(dataIn,dataOut);
        
        numErrs = numErrs + nErrors;
        numBits = numBits + nbit*6;
    end
    
    % Estimate the BER
    berEst(n) = numErrs/numBits;
end
berTheory = berawgn(EbV,'qam',M);

semilogy(EbV,berEst,'*')
