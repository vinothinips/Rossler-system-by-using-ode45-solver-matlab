clc; clear all; close all;

% Standard constants for the Rossler Attractor
a = 0.2;
b = 0.4;
c = 5.3;

% The Rossler attractor
Rossler1 = @(t,y)[-y(2)-y(3); y(1) + a*y(2); b + y(3)*(y(1)-c)];
tspan = 0:0.005:100;
a=5:0.1:25;
for k = 1:numel(a)
    [t,x{k}]=ode45(@rossler,tspan,[a(k) 0 0.1]);
end
ym = cell2mat(x);


%%
Ts = mean(diff(tspan));                             % Sampling Interval
Fs = 1/Ts;                                          % Sampling Frequency
Fn = Fs/2;                                          % Nyquist Frequency
L = numel(tspan);                                   % Signal Length
FTvdp1 = fft(ym(:,1:2:size(ym,2)))/L;               % Fourier Trasnsform
Fv = linspace(0, 1, fix(L/2)+1)*Fn;                 % Frequency Vector
Iv = 1:numel(Fv);                                   % Index Vector

figure
plot(Fv, abs(FTvdp1(Iv,:)))
grid
xlabel('Frequency')
title('Frequency Domain Plot')
xlim([0 Fs/2])