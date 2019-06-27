function scs_F1_lineplots ()

clc; clear; 
close all;

%% CONFIG

% Stats
config.test = 'ranksum';
config.tail = 'both';
config.pthres = 0.05;

% Axis
config.rangeY = [-8 5];
config.stepY = 2;
config.rangeX = [-0.1 0.5]; % secs
config.stepX = 0.1; % secs

% Smoothing
config.nwinms = 10/1000; % secs

% Labels

%% PLOTS

figure()

cond='B';
config.grupos = {'B0','B1'};
subplot(1,3,1); pintaroi(cond, config)

cond='T';
config.grupos = {'T0','T1'};
subplot(1,3,2); pintaroi(cond, config)

cond='S';
config.grupos = {'S0','S1'};
subplot(1,3,3); pintaroi(cond, config)


% figure()
% cond='0';
% config.grupos = {'S0','T0','B0'};
% subplot(1,2,1); pintaroi3(cond, config)
%  
% cond='1';
% config.grupos = {'S1','T1','B1'};
% subplot(1,2,2); pintaroi3(cond, config)
% 




function [data1, data2,data3, time] = cargadatos3(cond)

data1 = importdata(['scs_data/DATA_Avg SEP S',cond,'.mat']);
data2 = importdata(['scs_data/DATA_Avg SEP T',cond,'.mat']);
data3 = importdata(['scs_data/DATA_Avg SEP B',cond,'.mat']);
time  = importdata(['scs_data/DATA_time_Avg SEP B',cond,'.mat']);

SubjectNames = {'FB04','FB11','FB15','FB26','FB30','FB33','FB37','FB38','FB40','FB34','FB06','FB10','FB17','FB22','FB28'};%};

% Remove noisy subjects
noisysubjects = {'FB06','FB22','FB40'}; % 'FB06','FB22','FB40'

i1 = zeros(1,numel(SubjectNames));
for iS = 1:numel(noisysubjects)
    i1s = strcmp(noisysubjects{iS},SubjectNames);
    i1=i1+i1s; 
end

data1 = squeeze(data1);
data2 = squeeze(data2);
data3 = squeeze(data3);
data1(i1>0,:)=[];
data2(i1>0,:)=[];
data3(i1>0,:)=[];


function pintaroi3(cond, config)


[data1,data2, data3, time] = cargadatos3(cond);
config.Time = time;

% Smoothing: nsamples
samplingrate = 1/(config.Time(2)-config.Time(1));
config.nwinsamples = round(config.nwinms*samplingrate); % samples

% Labels
switch cond
    case '0'
        config.labelY = ['\bf Unattended\rm amplitude'];
    case '1'
        config.labelY = ['\bf Attended\rm amplitude'];
end
plot_timeseries3(data1, data2, data3, config)





function [data1, data2,time] = cargadatos(cond)

data1 = importdata(['scs_data/DATA_Avg SEP ',cond,'0.mat']);
data2 = importdata(['scs_data/DATA_Avg SEP ',cond,'1.mat']);
time  = importdata(['scs_data/DATA_time_Avg SEP ',cond,'0.mat']);

SubjectNames = {'FB04','FB11','FB15','FB26','FB30','FB33','FB37','FB38','FB40','FB34','FB06','FB10','FB17','FB22','FB28'};%};

% Remove noisy subjects

noisysubjects = {'FB06','FB22','FB40'}; % 'FB06','FB22','FB40'

i1 = zeros(1,numel(SubjectNames));
for iS = 1:numel(noisysubjects)
    i1s = strcmp(noisysubjects{iS},SubjectNames);
    i1=i1+i1s; 
end

data1 = squeeze(data1);
data2 = squeeze(data2);
data1(i1>0,:)=[];
data2(i1>0,:)=[];



function pintaroi(cond, config)


[data1,data2, time] = cargadatos(cond);
config.Time = time;

% Smoothing: nsamples
samplingrate = 1/(config.Time(2)-config.Time(1));
config.nwinsamples = round(config.nwinms*samplingrate); % samples

% Labels
config.labelY = ['\bf ',cond,' \rm amplitude'];

plot_timeseries(data1, data2, config)








