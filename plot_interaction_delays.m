function plot_interaction_delays(H_mvar, y, ent_params, max_delay)
count = 0;
width = 14;     % Width in inches
height = 7;    % Height in inches
alw = 1.5;    % AxesLineWidth
fs = 20;      % Fontsize
lw = 2.5;      % LineWidth
set(0,'defaultTextInterpreter','latex'); %trying to set the default
figure
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*300, height*300]); %<- Set size
set(gca, 'FontSize', fs, 'LineWidth', alw); %<- Set properties
C=linspecer(length(find(H_mvar<log2(factorial(ent_params.dim)))));
delays = -max_delay:max_delay;
for i=1:1:size(y,1)
    for j=i+1:1:size(y,1)
        if length(find(H_mvar(i,j,:)<log2(factorial(ent_params.dim))))>0
            count = count +1;
            plot(delays, [log2(factorial(ent_params.dim))*ones(max_delay+1,1); squeeze(H_mvar(i,j,:))], 'color', C(count,:), 'LineWidth',lw)
            legend_str{count,1} = sprintf('%d -> %d', j, i);
            hold on
        end
        if length(find(H_mvar(j,i,:)<log2(factorial(ent_params.dim))))>0
            count = count +1
            legend_str{count,1} = sprintf('%d -> %d', j, i);
            plot(delays, [flip(squeeze(H_mvar(j,i,:))) ; log2(factorial(ent_params.dim))*ones(max_delay+1,1)], 'color', C(count,:), 'LineWidth',lw)
            hold on
        end
        
        
    end
end
legend(legend_str)
ylabel('\textbf{M-OPTN based CE} ($\mathbf{H}$)')
xlabel ('\textbf{Delays}')
set(gca, 'XTick', delays);
set(gca,'TickLabelInterpreter','none');
set(gca,'fontweight','bold','fontsize',fs);

