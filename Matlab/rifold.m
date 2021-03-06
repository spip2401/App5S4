close all;
clear all;

[s1,Fe] = audioread('Sons/phrase_malentendant_bruite.wav');
[s2,Fe] = audioread('Sons/phrase_originale2.wav');

N = 256;

b = [1 -3.914 7.643 -9.551 8.717 -5.637 2.074];         
a = [1 0.3696 0.04];

z = roots(a);
p = roots(b);

p = [.95*p(1); .95*p(2); 1/1.2^2*p(3); 1/1.2^2*p(4); 1/1.2^2*p(5); 1/1.2^2*p(6)];

zplane(z,p);
freqz(poly(z),poly(p),N/2)
h = abs(freqz(poly(z),poly(p),N));
figure
plot(h);

% 4 bandes

nbre_bandes = 4;

H = ones(1,N);

moyenne1 = 0;

for i = 1:length(H)/4 + 1
   moyenne1 = moyenne1 + h(i);
end
moyenne1 = moyenne1 / i;
H(1:i) = moyenne1;

moyenne2 = 0;

for i2 = 1:length(H)/4
    moyenne2 = moyenne2 + h(i + i2);
end

moyenne2 = moyenne2 / i2;
H(i + 1: i + i2) = moyenne2;

moyenne3 = 0;

for i3 = 1:length(H)/4
    moyenne3 = moyenne3 + h(i + i2 + i3);
end

moyenne3 = moyenne3 / i3;
H(i + i2 + 1: i + i2 + i3) = moyenne3;

moyenne4 = 0;

for i4 = 1:length(H)/4 - 1
    moyenne4 = moyenne4 + h(i + i2 + i3 + i4);
end

moyenne4 = moyenne4 / i4;
H(i + i2 + i3 + 1: i + i2 + i3 + i4) = moyenne4;

H = [H H(end) H(end:-1:2)];

figure
plot(H);

Hfft = ifft(H);
figure
plot(Hfft);
Hfft = ifftshift(Hfft);
figure
plot(Hfft);