%% Figure for individual PSD
%
% Guiomar Niso, 6 June 2017
%
% Clear figure
clc; clear; clf; close all;

%% =========================================================================

GROUPS = {'B','T','S'};


% ==== SUBJECTS ====


SubjectNames = {'FB04','FB11','FB15','FB26','FB30','FB33','FB37','FB38','FB40','FB34','FB06','FB10','FB17','FB22','FB28'};%};

% ==== ROIS ====
atlas = 'Pain';
scouts = {'Vertex'}; % , 'PCC'

fs = 8; % Font size
lw = 1.5;

% color0 = 'b';
% color1 = 'r';
color0 = [0 0 150]/255; % azul // [ 0 0.6 0.8];
color1 = [255 70 70]/255; % rojo  // [ 0.98  0.65 0.1];


% Save figure in mydir
mydir2 ='C:\Users\Guiomar\Documents\PROJETCS\SCS_Pain\';
dosave = 1; 
papersize = [0 0 12 6];

% Load data
mydir1 ='C:\Users\Guiomar\Documents\guio_scripts\scs\scs_data\';


%% =========================================================================

for iGroup=1:numel(GROUPS)
    
    
GROUP = GROUPS{iGroup};

TAGdata = ['Avg SEP ',GROUP];
igTAG = 'absmax';
TAG = 'zscore smooth';


%% Plot figures ===========================================================


COND0 = importdata([mydir1,'DATA_',TAGdata,'0.mat']);
COND1 = importdata([mydir1,'DATA_',TAGdata,'1.mat']);
load([mydir1,'DATA_time_',TAGdata,'0']);

for iScout=1:numel(scouts)

% ==== PLOT FIGURE ====
XMIN = -0.1; %TIME(1);
XMAX = TIME(end);
YMIN = -10;
YMAX = 10;

F = figure(iScout); 

for iSubject = 1:numel(SubjectNames)
    
subplot(3,5,iSubject)

plot(TIME,squeeze(COND1(iSubject,iScout,:))-squeeze(COND0(iSubject,iScout,:)),'Color','k','LineWidth', lw); hold on
% plot(TIME,squeeze(COND0(iSubject,iScout,:)),'Color',color0,'LineWidth', lw); hold on
% plot(TIME,squeeze(COND1(iSubject,iScout,:)),'Color',color1,'LineWidth', lw); 
ylabel(['Signal']);
xlabel ('Time (s)');
set(gca,'FontSize',fs)
title (SubjectNames{iSubject})
% Ajustar la linea de * en pinta_barplots (parametro: maxdat)
xlim([XMIN XMAX]);
ylim ([YMIN YMAX]);
grid on; 
set(gca,'XTick',[0 0.2 0.4]); 
set(gca,'YTick',YMIN:5:YMAX); 
set(gca,'TickLength',[0.02 0.05]);
set(gca,'XMinorTick','on'); 


end

% ==== Save figure ====
if dosave
    
    set(F,'PaperUnits','inches')
    set(F,'PaperPosition',papersize)
    
%     % Without margins
%     ax = gca; 
%     outerpos    = ax.OuterPosition; 
%     ti          = ax.TightInset;  
%     left        = outerpos(1) + ti(1); 
%     bottom      = outerpos(2) + ti(2); 
%     ax_width    = outerpos(3) - ti(1) - ti(3); 
%     ax_height   = outerpos(4) - ti(2) - ti(4); 
%     ax.Position = [left bottom ax_width ax_height];
%     
    % set(h,'PaperPositionMode','auto')
%     print(F,'-dtiff','-r500',[mydir2,'Fig_DATA_',TAGdata,'_',scouts{iScout},'_',GROUP]);
    print(F,'-dpng','-r500',[mydir2,'Fig_DATA_',TAGdata,'_',scouts{iScout},'_',GROUP]);

end

end

close all;

end

