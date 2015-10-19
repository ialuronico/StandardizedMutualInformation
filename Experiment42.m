clear all;
close all;
clc;

%
% Experiment in Section 4.2 of the paper.
%
% Start Matlab parallel environment with the command matlabpool.
%
% (around 30' on a quadcore Intel Core-i7 2.9GHz PC for 5000 samples)

samples = 5000;

N_B = [20 40 60 80 100]; % number of records 

c = 4; % Number of clusters for clustering solutions
r = 4; % number of clusters for the reference clustering

AMIfrec = zeros(1,length(N_B));
MIfrec = zeros(1,length(N_B));
SMIfrec = zeros(1,length(N_B));

AMIvec = [];
MIvec = [];
SMIvec = [];
parfor s=1:samples
    disp(['sample ' num2str(s)]);      
    scores = zeros(3,length(N_B)); % collects the values for MI, AMI, SMI here
        
    % Generate reference clustering A
    A_orig = zeros(1,N_B(length(N_B)));        
    for j=1:N_B(length(N_B))
        A_orig(j) = randi(r);
    end            
    
    for k=1:length(N_B)
        % Generate clustering B with with N records        
        B = zeros(1,N_B(k));        
        for j=1:N_B(k)
            B(j) = randi(c);
        end            
        
        % subset of records in A for comparison with B
        A = randsample(A_orig,N_B(k));
        
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

h = figure;

subplot(3,1,1);
bar(N_B',SMIfrec'/samples,'r')
hold on;
plot(N_B,SMIfrec/samples,'ko--');
grid on;
title('SMI','Interpreter','latex','FontSize',12);

subplot(3,1,2);
bar(N_B',AMIfrec'/samples,'g')
hold on;
plot(N_B,AMIfrec/samples,'ko--');
grid on;
title('AMI','Interpreter','latex','FontSize',12);

ylabel('Probability of selection','Interpreter','latex','FontSize',12);

subplot(3,1,3);
bar(N_B',MIfrec'/samples,'w');
hold on;
plot(N_B, MIfrec/samples,'ko--');
grid on;
title('MI','Interpreter','latex','FontSize',12);

xlabel('Number of records $N$','Interpreter','latex','FontSize',12);

save('Experiment_4_2_results');
disp('Results saved.');
