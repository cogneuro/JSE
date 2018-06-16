data_dir = '/Users/dojoonyi/Dropbox/data/JSE/JSE_exp2/';

%% WORKING MEMORY TASK
filename = fullfile(data_dir, 'logJSEn64_WMtask.csv');
formatSpec = '%f%*s%*s%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', ',', 'TextType', ...
	'string', 'HeaderLines' ,1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);

WW = [dataArray{1:end-1}];
clearvars filename delimiter startRow formatSpec fileID dataArray ans;


%% GO/NOGO TASK
filename = fullfile(data_dir, 'logJSEn64_GNGtask.csv');
formatSpec = '%f%*s%*s%f%f%f%f%f%f%*s%*s%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', ',', 'TextType', ...
	'string', 'EmptyValue', NaN, 'HeaderLines' ,1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);

TT = [dataArray{1:end-1}];
clearvars filename delimiter startRow formatSpec fileID dataArray ans;


%% Check Subject Index
if isequal(sort(unique(WW(:,1))), sort(unique(TT(:,1))))
	SN = unique(WW(:,1));
else
	error("Subject Indices do not match!");
end


%% Go/Nogo performance
cntTrial = zeros(length(SN),9); % 1_SID, 2~5_correct, 6~9_incorrect, 
cntInv   = zeros(length(SN),9); % 1_SID, 2~5_anticipatory, 6~9_3SD trimmed
cntTrmd  = zeros(length(SN),3); % 1_SID, 2_anticipatory, 3_3SD trimmed
avgRTsd  = zeros(length(SN),5); % 1_SID, 2~5_each condition
percERR  = zeros(length(SN),5); % 1_SID, 2~5_each condition

sumWM = zeros(length(SN),3); % 1_SID, 2_WM accuracy, 3_WM RT

% avgRT3sd = cell(1,2);
% avgRT3sd{1} = zeros(length(SN)/2,5); % low-load group
% avgRT3sd{2} = zeros(length(SN)/2,5); % high-load group

for it = 1:length(SN)
	xsn = SN(it);
	
	%% working memory data
	sWW = WW(WW(:,1)==xsn,:);
	% 1_SID, 2_Group (1:low, 2:high), 3_Trial, 4_Probe, 5_Response, 
	% 6_Correct (0:incorrect, 1:correct),7_RT	
	
	sumWM(it,1) = xsn;
	sumWM(it,2) = mean(sWW(:,6));
	sumWM(it,3) = mean(sWW(sWW(:,6)==1,7)); % there was no RT beyond 3SD
	
	wCorr = zeros(1,240);	% 240 GNG trials
	for mm=1:12				% 12 WM trials
		wCorr((mm-1)*20+1:mm*20) = sWW(mm,6);
	end
	
	%% go/nogo data
	sTT = TT(TT(:,1)==xsn,:);
	% 1_SID, 2_Group (1:low, 2:high), 3_Epoch, 4_Trial, 5_Load (1:absent, 2:present)
	% 6_Congruent (0:not my turn, 1:congruent, 2:incongruent), 7_Target (0:not, 1:target),
	% 8_Response (0:not go, 1:go), 9_Correct (0:incorrect, 1:correct), 10_RT
	sTT(sTT(:,6)>0, end+1) = wCorr; % 11_WMcorr
	
	%% sorting data
	xRT{1} = sTT(sTT(:,5)==1 & sTT(:,6)==1 & sTT(:,9)==1, 10); % no load, congruent 
	xRT{2} = sTT(sTT(:,5)==1 & sTT(:,6)==2 & sTT(:,9)==1, 10); % no load, incongruent 
	xRT{3} = sTT(sTT(:,5)==2 & sTT(:,6)==1 & sTT(:,9)==1, 10); % load, congruent 
	xRT{4} = sTT(sTT(:,5)==2 & sTT(:,6)==2 & sTT(:,9)==1, 10); % load, incongruent 
	
	xIC{1} = sTT(sTT(:,5)==1 & sTT(:,6)==1 & sTT(:,9)~=1, 10); % no load, congruent 
	xIC{2} = sTT(sTT(:,5)==1 & sTT(:,6)==2 & sTT(:,9)~=1, 10); % no load, incongruent 
	xIC{3} = sTT(sTT(:,5)==2 & sTT(:,6)==1 & sTT(:,9)~=1, 10); % load, congruent 
	xIC{4} = sTT(sTT(:,5)==2 & sTT(:,6)==2 & sTT(:,9)~=1, 10); % load, incongruent 

	cntTrial(it,1) = xsn;
	for mm=1:4
		cntTrial(it, 1+mm) = length(xRT{mm});
		cntTrial(it, 5+mm) = length(xIC{mm});
	end
	
	%% 3SD trimming
	avgRTsd(it, 1) = xsn;
	cntInv(it,1) = xsn;
	for mm=1:4
		trmd1 = xRT{mm}(xRT{mm} > .15); % anticipatory responses removed
		
		cutoff(1) = mean(trmd1) - std(trmd1)*3;
		cutoff(2) = mean(trmd1) + std(trmd1)*3;
		trmd2 = trmd1(trmd1>cutoff(1) & trmd1<cutoff(2));
		
		avgRTsd(it, 1+mm) = mean(trmd2)*1000;
		
		cntInv(it, 1+mm) = cntTrial(it, 1+mm) - length(trmd1);
		cntInv(it, 5+mm) = cntTrial(it, 1+mm) - cntInv(it, 1+mm) - length(trmd2);
		
		clear trmd1 trmd2;
	end
	
end

percERR(:,1) = cntTrial(:,1);
percERR(:,2:5) = 100 * cntTrial(:,6:9)./(cntTrial(:,2:5)+cntTrial(:,6:9));

cntTrmd(:,1) = cntInv(:,1);
cntTrmd(:,2:3) = [sum(cntInv(:,2:5),2),sum(cntInv(:,6:9),2)];

%% Check Subject Index
xxx = 1;
if ~isequal(avgRTsd(:,1), sumWM(:,1)), xxx = 0; end
if ~isequal(avgRTsd(:,1), percERR(:,1)), xxx = 0; end
if ~isequal(avgRTsd(:,1), cntTrial(:,1)), xxx = 0; end
if ~xxx
	error("Subject Indices do not match!");
end


%% Output file: Summary
dataFile = fopen('summaryJSEn64.csv', 'w');
fprintf(dataFile,'analyzeJSEv64.m @ %s\n\n', datestr(clock));
fprintf(dataFile,'All %d subjects\n\n', length(SN));

fprintf(dataFile,'Go/Nogo RT trimmed by 3SD\n');

nCorr = sum(sum(cntTrial(:,2:5)));
nTrmd1 = sum(cntTrmd(:,2)); % anticipatory
nTrmd2 = sum(cntTrmd(:,3)); % 3SD
fprintf(dataFile,'Trimming %d RTs shorter than 150ms(%1.2f%%) ', nTrmd1, 100*nTrmd1/nCorr);
fprintf(dataFile,'and %d RTs beyond 3 SD(%1.2f%%).\n', nTrmd2, 100*nTrmd2/nCorr);
fprintf(dataFile,'SID,Group,accWM,rtWM,rtNoCong,rtNoIncg,rtWmCong,rtWmIncg,');
fprintf(dataFile,'erNoCong,erNoIncg,erWmCong,erWmIncg,');
fprintf(dataFile,'#C1,#C2,#C3,#C4,#I1,#I2,#I3,#I4,<150ms,>3SD\n');

for it=1:size(avgRTsd,1)
	xgrp = 'lowload';
	if fix(avgRTsd(it,1)/100)==2, xgrp = 'highload'; end	
	
	fprintf(dataFile,'%d,%s,%4.10f,%4.10f,%4.10f,%4.10f,%4.10f,%4.10f,',...
		avgRTsd(it,1), xgrp, sumWM(it,2), sumWM(it,3),...
		avgRTsd(it,2), avgRTsd(it,3), avgRTsd(it,4), avgRTsd(it,5));
	
	fprintf(dataFile,'%4.10f,%4.10f,%4.10f,%4.10f,',...
		percERR(it,2), percERR(it,3), percERR(it,4), percERR(it,5));

	fprintf(dataFile,'%d,%d,%d,%d,%d,%d,%d,%d,',...
		cntTrial(it,2), cntTrial(it,3), cntTrial(it,4), cntTrial(it,5),...
		cntTrial(it,6), cntTrial(it,7), cntTrial(it,8), cntTrial(it,9));
	fprintf(dataFile,'%d,%d\n', cntTrmd(it,2),cntTrmd(it,3));
end
fprintf(dataFile,'\n\n\n');


%% Output file: summary for R plot
dataFile1 = fopen('plotJSEn64.csv', 'w');

fprintf(dataFile1,'SID,Group,accWM,rtWM,rtNoCong,rtNoIncg,rtWmCong,rtWmIncg,');
fprintf(dataFile1,'erNoCong,erNoIncg,erWmCong,erWmIncg\n');

for it=1:size(avgRTsd,1)
	xgrp = 'lowload';
	if fix(avgRTsd(it,1)/100)==2, xgrp = 'highload'; end	
	
	fprintf(dataFile1,'%d,%s,%4.10f,%4.10f,%4.10f,%4.10f,%4.10f,%4.10f,',...
		avgRTsd(it,1), xgrp, sumWM(it,2), sumWM(it,3),...
		avgRTsd(it,2), avgRTsd(it,3), avgRTsd(it,4), avgRTsd(it,5));
	
	fprintf(dataFile1,'%4.10f,%4.10f,%4.10f,%4.10f\n',...
		percERR(it,2), percERR(it,3), percERR(it,4), percERR(it,5));
end


fclose('all');