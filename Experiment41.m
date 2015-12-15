clear all;
close all;
clc;

%
% Experiment in Section 4.1 of the paper.
%
% Start Matlab parallel environment with the command matlabpool.
%
% (around 30' on c4.8large Amazon instance)

samples = 5000;

c_B = [2:1:10]; % number of clusters in B

N = 100; % Number of records
r = 4; % number of clusters for the reference clustering

AMIfrec = zeros(1,length(c_B));
MIfrec = zeros(1,length(c_B));
SMIfrec = zeros(1,length(c_B));

AMIvec = [];
MIvec = [];
SMIvec = [];
parfor s=1:samples
    disp(['sample ' num2str(s)]);          
    scores = zeros(3,length(c_B)); % collects the values for MI, AMI, SMI here
        
    % Generate reference clustering A
    A = zeros(1,N);        
    for j=1:N
        A(j) = randi(r);
    end            
    
    for k=1:length(c_B)
        % Generate clustering B with c clusters        
        B = zeros(1,N);        
        for j=1:N
            B(j) = randi(c_B(k));
        end    
        
        % Compute MI, AMI, SMI
        scores(1,k) = mi(A,B); 
        scores(2,k) = ami(A,B); 
        scores(3,k) = smi(A,B); 
    end

    % Compute which clustering gets higher score for each measure
    [~, win] = max(scores');
    
    MIvec = [MIvec win(1)];
    AMIvec = [AMIvec win(2)];
    SMIvec = [SMIvec win(3)];
end

% Compute the frequencies of selection

for u=MIvec
    MIfrec(u) = MIfrec(u) + 1;
end
for u=AMIvec
    AMIfrec(u) = AMIfrec(u) + 1;
end
for u=SMIvec
    SMIfrec(u) = SMIfrec(u) + 1;
end

save('Experiment_4_1_results');
disp('Results saved.');
