clc; clear;


% DATA

mypath = 'C:\Users\Guiomar\Documents\guio_scripts\scs_data\';

B0 = importdata([mypath,'P300_B0.mat']);
B1 = importdata([mypath,'P300_B1.mat']);
T0 = importdata([mypath,'P300_T0.mat']);
T1 = importdata([mypath,'P300_T1.mat']);
S0 = importdata([mypath,'P300_S0.mat']);
S1 = importdata([mypath,'P300_S1.mat']);



% figure()
% subplot 131; plot_p300_values(B0,B1)
% subplot 132; plot_p300_values(T0,T1)
% subplot 133; plot_p300_values(S0,S1)

figure()
subplot 221; plot_p300_values(B0,S0)
subplot 222; plot_p300_values(T0,S0)
subplot 223; plot_p300_values(B1,S1)
subplot 224; plot_p300_values(T1,S1)



