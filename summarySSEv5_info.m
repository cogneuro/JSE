%% PARTICIPANTS
SN = {};	% serial, initial, load, target, 1st run load level (1_no, 2_load)
for mm=1:1
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
end

%% PATH SPECIFICATION
root_dir = '/Users/dojoonyi/Dropbox/data/JSE/JSE_exp2';

dataFile = fopen('summarySSEv5_Sinfo.csv', 'w+');
fprintf(dataFile,'summarySSEv5_Sinfo.m\n');
fprintf(dataFile,'SN, NM, LOAD, SEQ, POS, RSP, PAIR\n');

for xsn=1:length(SN)
	clear data load tSUB;
	INFO = load(sprintf('datMatSSEv5_%s_%02d%s_%s.mat',...
				SN{xsn}{3}, SN{xsn}{1}, SN{xsn}{2}, SN{xsn}{4}));
	if str2double(INFO.tSUB.CON)==1, xPAIR = 'RG';	end
	if str2double(INFO.tSUB.CON)==2, xPAIR = 'GR';	end
	
	if strcmp(INFO.tSUB.RESP,'R'), xRSP = 'Red';	end
	if strcmp(INFO.tSUB.RESP,'G'), xRSP = 'Green';	end
	
			
	if strcmp(SN{xsn}{2}, INFO.tSUB.NM)
		if strcmp(INFO.tSUB.respColr, xRSP)
			fprintf(dataFile,'%s, %s, %s, %s, %s, %s, %s\n',...
				INFO.tSUB.SN, INFO.tSUB.NM, SN{xsn}{3}, INFO.tSUB.sequence, INFO.tSUB.posit, xRSP, xPAIR);
		else
			fprintf(dataFile,'Colr and Resp does not match in %02d%s\n', SN{xsn}{1}, SN{xsn}{2});
		end
	else
		fprintf(dataFile,'%02d does not match to %02d%s\n', xsn, SN{xsn}{1}, SN{xsn}{2});
	end
	clear INFO xCON;
end

fclose('all');
