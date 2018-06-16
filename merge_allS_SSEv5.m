%% PARTICIPANTS
SN = {};	% serial, initial, load, target, 1st run load level (1_no, 2_load)
SN{end+1} = {09, 'KMY', 'low', 'R', 1};
SN{end+1} = {10, 'LJE', 'low', 'G', 1}; 
SN{end+1} = {11, 'KJH', 'low', 'G', 2}; 
SN{end+1} = {12, 'LSH', 'low', 'R', 2};  
SN{end+1} = {13, 'KYH', 'low', 'G', 1}; 
SN{end+1} = {14, 'CJH', 'low', 'R', 1}; 
SN{end+1} = {15, 'HYS', 'low', 'R', 2}; 
SN{end+1} = {16, 'JGH', 'low', 'G', 2}; 
SN{end+1} = {23, 'KYM', 'low', 'R', 2};
SN{end+1} = {24, 'JSH', 'low', 'G', 2};  
SN{end+1} = {27, 'CHN', 'low', 'R', 2}; 
SN{end+1} = {28, 'PSY', 'low', 'G', 2}; 
SN{end+1} = {29, 'JS',  'low', 'G', 1};
SN{end+1} = {30, 'KYJ', 'low', 'R', 1}; 
SN{end+1} = {33, 'KMJ', 'low', 'G', 1}; 
SN{end+1} = {34, 'JEH', 'low', 'R', 1}; 
SN{end+1} = {25, 'BTS', 'low', 'R', 1}; 
SN{end+1} = {26, 'JBY', 'low', 'G', 1}; 
SN{end+1} = {39, 'KJE', 'low', 'R', 2};
SN{end+1} = {40, 'LHB', 'low', 'G', 2};
SN{end+1} = {41, 'LJH', 'low', 'G', 1};
SN{end+1} = {42, 'LCH', 'low', 'R', 1};
SN{end+1} = {43, 'LHJ', 'low', 'G', 2};
SN{end+1} = {44, 'KGY', 'low', 'R', 2};
SN{end+1} = {53, 'KJW', 'low', 'R', 1};
SN{end+1} = {54, 'PHS', 'low', 'G', 1};
SN{end+1} = {51, 'KSH', 'low', 'G', 2};
SN{end+1} = {52, 'KTY', 'low', 'R', 2};
SN{end+1} = {57, 'DXY', 'low', 'R', 1};
SN{end+1} = {58, 'SSY', 'low', 'G', 1};
SN{end+1} = {55, 'HDH', 'low', 'G', 2};
SN{end+1} = {56, 'HDY', 'low', 'R', 2};

SN{end+1} = {01, 'YHJ', 'high', 'R', 1};
SN{end+1} = {02, 'LJE', 'high', 'G', 1}; 
SN{end+1} = {03, 'CS',  'high', 'G', 2}; % 50% WM accuracy
SN{end+1} = {04, 'HSJ', 'high', 'R', 2};  
SN{end+1} = {05, 'KDY', 'high', 'G', 1}; 
% SN{end+1} = {06, 'SJS', 'high', 'R', 1}; % responses were not registered
SN{end+1} = {07, 'JDH', 'high', 'R', 2}; 
SN{end+1} = {08, 'JSI', 'high', 'G', 2}; 
SN{end+1} = {17, 'KJH', 'high', 'R', 1};
SN{end+1} = {18, 'SJW', 'high', 'G', 1}; 
SN{end+1} = {21, 'PSK', 'high', 'G', 1}; 
SN{end+1} = {22, 'LYS', 'high', 'R', 1}; 
SN{end+1} = {19, 'LJH', 'high', 'G', 2}; 
SN{end+1} = {20, 'PDJ', 'high', 'R', 2}; 
SN{end+1} = {31, 'BEY2', 'high', 'R', 2}; 
SN{end+1} = {32, 'JDY2', 'high', 'G', 2}; 
SN{end+1} = {33, 'KKT', 'high', 'G', 1}; 
SN{end+1} = {34, 'KMS', 'high', 'R', 1}; 
SN{end+1} = {37, 'KBH', 'high', 'R', 1}; % missed --> found it (20150305 hjk).
SN{end+1} = {38, 'ASC', 'high', 'G', 1};
SN{end+1} = {39, 'PWJ', 'high', 'R', 2};
% SN{end+1} = {40, 'KJK', 'high', 'G', 2}; % responses were not registered
SN{end+1} = {41, 'OYJ', 'high', 'G', 1};
SN{end+1} = {42, 'JSY', 'high', 'R', 1};
SN{end+1} = {43, 'JSY', 'high', 'R', 2};
SN{end+1} = {44, 'PYR', 'high', 'G', 2};
SN{end+1} = {51, 'PJW', 'high', 'G', 2};
SN{end+1} = {52, 'PJS', 'high', 'R', 2};
SN{end+1} = {53, 'KSH', 'high', 'R', 1};
SN{end+1} = {54, 'JJY', 'high', 'G', 1};
SN{end+1} = {55, 'KBR', 'high', 'G', 2};
SN{end+1} = {56, 'LSJ', 'high', 'R', 2};
SN{end+1} = {57, 'SSY', 'high', 'R', 1};
SN{end+1} = {58, 'LTH', 'high', 'G', 1};


%% PATH SPECIFICATION
root_dir = '/Users/dojoonyi/Dropbox/data/JSE/JSE_exp2';

dataFile1 = fopen('logJSEn64_WMtask.csv', 'w');
fprintf(dataFile1,'SID,Name,GroupNM,Group,Trial,Probe,Response,Correct,RT\n');

dataFile2 = fopen('logJSEn64_GNGtask.csv', 'w');
fprintf(dataFile2,'SID,Name,GroupNM,Group,Block1,Epoch,Trial,Load,Congruent,');
fprintf(dataFile2,'Target,Color,Direction,Response,Correct,RT\n');

cntGRP = zeros(1,2);
for xsn = 1:length(SN)
	
	%% COUNTING # PARTICIPANTS IN EACH GROUP
	if strcmp(SN{xsn}{3},'low')
		cntGRP(1) = cntGRP(1) + 1;
	elseif strcmp(SN{xsn}{3},'high')
		cntGRP(2) = cntGRP(2) + 1;
	end
	
	%% WORKING MEMORY TASK
	WW = load(fullfile(root_dir, sprintf('WMRawSSEv5_%s_%02d%s_%s.txt', ...
						SN{xsn}{3}, SN{xsn}{1}, SN{xsn}{2}, SN{xsn}{4})));
	%1_SN, 2_xLev, 3_w_it, 4_xANS, 5_resp, 6_corr, 7_rt

	xgrp = 1;
	if strcmp(SN{xsn}{3},'high'), xgrp=2; end
	
	xtrg = 'red';
	if strcmp(SN{xsn}{4},'G'), xtrg='green'; end
	
	for mm=1:size(WW,1)
		fprintf(dataFile1,'%d,%s,%s,%d,%d,%d,%d,%d,%1.4f\n',...
			SN{xsn}{1}+xgrp*100, SN{xsn}{2}, SN{xsn}{3}, xgrp,...
			mm,WW(mm,4),WW(mm,5),WW(mm,6),WW(mm,7));
	end
	
	%% GO/NOGO TASK
	TT = load(fullfile(root_dir, sprintf('datRawSSEv5_%s_%02d%s_%s.txt', ...
						SN{xsn}{3}, SN{xsn}{1}, SN{xsn}{2}, SN{xsn}{4})));
	%1_SN, 2_trial, 3_xRun, 4_xLev, 5_xBlk, 6_it, 7_data.cREP(it), 8_xCond, 
	%9_xPress, 10_xCongr, 11_xCol, 12_xDir, 13_xResp, 14_xCorr, 15_xRT,

	for mm=1:size(TT,1)
		fprintf(dataFile2,'%d,%s,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%4.4f\n',...
			SN{xsn}{1}+xgrp*100, SN{xsn}{2}, SN{xsn}{3}, xgrp, SN{xsn}{5}, TT(mm,3),...
			TT(mm,2),TT(mm,4),TT(mm,10),TT(mm,9),TT(mm,11),TT(mm,12),TT(mm,13),TT(mm,14),TT(mm,15));
	end
	

	%% PRINT INFO 
	fprintf('Loading the data from SN %02d: total %d WM trials and %d GNG trials\n',...
		SN{xsn}{1}, size(WW,1), size(TT,1));  
end	

fclose('all');
