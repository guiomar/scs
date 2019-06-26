%% Figure for individual PSD
%
% Guiomar Niso, 6 June 2017
%
% Clear figure
clc; clear; clf; close all;

%% =========================================================================

GROUPS = {'B0','B1','T0','T1','S0','S1'};


% ==== SUBJECTS ====

SubjectNames = {'FB04','FB11','FB15','FB26','FB30','FB33','FB37','FB38','FB40','FB34','FB06','FB10','FB17','FB22','FB28'};%};

% ==== ROIS ====
atlas = 'Pain';
scouts = {'Vertex'}; % , 'PCC'

fs = 8; % Font size
lw = 2;

% colorT  = [ 1  0.5 0.1]; % Naranja
colorT = 'b';


% Save figure in mydir
mydir2 ='C:\Users\Usuario\Documents\PROJECTS\SCS_Pain\';
dosave = 1; 
papersize = [0 0 10 5];



%% =========================================================================

for iGroup=1:numel(GROUPS)
    
    
GROUP = GROUPS{iGroup};

TAGdata = ['Avg SEP ',GROUP];
igTAG = 'absmax';
TAG = 'zscore smooth';

for iSubject = 1:numel(SubjectNames)

    SN = SubjectNames{iSubject}; 
    condition = '';
    sFilesTAG = busca_Files_results(TAGdata,TAG,SN,igTAG, condition);
    if isempty(sFilesTAG); continue; end

% Process: Extract scouts
sFilesScouts = bst_process('CallProcess', 'process_extract_scout', ...
    sFilesTAG, [], ...
    'timewindow',     [], ...
    'scouts',         {atlas, scouts}, ...
    'scoutfunc',      1, ...  % Mean
    'concatenate',    1, ...
    'save',           1, ...
    'addrowcomment',  1, ...
    'addfilecomment', 1);

sMatrix = in_bst(sFilesScouts.FileName);
for iScout=1:numel(scouts)
        DATA(iSubject, iScout,:)  =  sMatrix.Value(iScout,:);
end

% Process: Delete selected files
bst_process('CallProcess', 'process_delete', ...
    sFilesScouts, [], ...
    'target', 1);  % Delete selected files

save(['DATA_',TAGdata],'DATA');

end

% Just save it once
TIME = sMatrix.Time;
save(['DATA_time_',TAGdata],'TIME');



%% Plot figures ===========================================================


load(['DATA_',TAGdata]);
load(['DATA_time_',TAGdata]);

for iScout=1:numel(scouts)

% ==== PLOT FIGURE ====
XMIN = -0.1; %TIME(1);
XMAX = TIME(end);
YMIN = -10;
YMAX = 10;

F = figure(iScout); 

for iSubject = 1:numel(SubjectNames)
    
subplot(4,4,iSubject)

plot(TIME,squeeze(DATA(iSubject,iScout,:)),'Color',colorT,'LineWidth', lw); hold on
ylabel(['Signal']);
xlabel ('Time (s)');
set(gca,'FontSize',fs)
title (SubjectNames{iSubject})
% Ajustar la linea de * en pinta_barplots (parametro: maxdat)
xlim([XMIN XMAX]);
ylim ([YMIN YMAX]);
grid on; 
set(gca,'XTick',[0 0.2 0.4]); 
set(gca,'YTick',YMIN:2.5:YMAX); 
set(gca,'TickLength',[0.02 0.05]);
set(gca,'XMinorTick','on'); 


end

% ==== Save figure ====
if dosave
    
    set(F,'PaperUnits','inches')
    set(F,'PaperPosition',papersize)
    % set(h,'PaperPositionMode','auto')
%     print(F,'-dtiff','-r500',[mydir2,'Fig_DATA_',TAGdata,'_',scouts{iScout},'_',GROUP]);
    print(F,'-dpng','-r500',[mydir2,'Fig_DATA_',TAGdata,'_',scouts{iScout},'_',GROUP]);

end

end

close all;

end

