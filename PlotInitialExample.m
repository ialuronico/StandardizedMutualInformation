clear;
close all;
clc;

% Plot results from Experiment 4_1

load('Experiment_4_1_results');


h = figure;

bar(c_B',AMIfrec'/samples,'w')
hold on;
plot(c_B,AMIfrec/samples,'ko--');
grid on;
%title('AMI','Interpreter','latex','FontSize',12);
ylabel('Probability of selection','Interpreter','latex','FontSize',12);
xlabel('Number of clusters $c$ in $\mathbf{B}$','Interpreter','latex','FontSize',12);

set(h, 'Position', [150 150 820 235])
set(h,'PaperSize',[19.5 7],'PaperPositionMode','auto');
saveas(h,'ExInitial','pdf');