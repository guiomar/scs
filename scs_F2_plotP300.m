function scs_F2_plotP300()

clc; clear; close all;


% DATA

mypath = 'C:\Users\Guiomar\Documents\guio_scripts\scs_data\';


SubjectNames = {'FB04','FB11','FB15','FB26','FB30','FB33','FB37','FB38','FB34','FB10','FB17','FB28'};  % 'FB06','FB22','FB40'

cond = '0';
[S0, T0,B0] = cargadatos3(cond);
cond = '1';
[S1, T1,B1] = cargadatos3(cond);


% figure()
% subplot 131; plot_p300_values(B0,B1)
% subplot 132; plot_p300_values(T0,T1)
% subplot 133; plot_p300_values(S0,S1)

figure()
subplot 221; plot_p300_values(B0,S0,SubjectNames,{'B0','S0'})
subplot 222; plot_p300_values(T0,S0,SubjectNames,{'T0','S0'})
subplot 223; plot_p300_values(B1,S1,SubjectNames,{'B1','S1'})
subplot 224; plot_p300_values(T1,S1,SubjectNames,{'T1','S1'})


% F=figure();
% plot_p300_values(B1,S1,SubjectNames,{'B1','S1'})




% Save figure in mydir
mydir2 ='C:\Users\Guiomar\Documents\PROJETCS\SCS_Pain\';
dosave = 0; 

figName = 'Fig_3_B1_S1';

papersize = [0 0 5 5];


% ==== Save figure ====
if dosave
    
    set(F,'PaperUnits','inches')
    set(F,'PaperPosition',papersize)
    % set(h,'PaperPositionMode','auto')
    print(F,'-dpng','-r500',[mydir2,figName]);

end


end 




function [data1, data2,data3] = cargadatos3(cond)

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

% P300=time>0.088&time<0.092;
P300=time>0.250&time<0.300;

data1 = mean(data1(:,P300),2);
data2 = mean(data2(:,P300),2);
data3 = mean(data3(:,P300),2);

end

% 
% B0 = importdata([mypath,'P300_B0.mat']);
% B1 = importdata([mypath,'P300_B1.mat']);
% T0 = importdata([mypath,'P300_T0.mat']);
% T1 = importdata([mypath,'P300_T1.mat']);
% S0 = importdata([mypath,'P300_S0.mat']);
% S1 = importdata([mypath,'P300_S1.mat']);
% 
% 
% 



