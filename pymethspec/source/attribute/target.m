clear all;

% ======== config ========
config.data_base = 'liver';
config.data_type = 'attributes';
config.color = '';
config.edge_alpha = 0.5;

if strcmp(getenv('computername'), 'MSI')
    config.up = 'D:/YandexDisk/Work/pymethspec/data';
else
    config.up = 'E:/YandexDisk/Work/pymethspec/data';
end


% ======== processing ========
f = figure;

config.gender = 'any';
config.color = [0.5 0.5 0.5];
config.edge_alpha = 0.3;
plot_target_hist(config);

config.gender = 'F';
config.color = 'r';
config.edge_alpha = 0.5;
plot_target_hist(config);

config.gender = 'M';
config.color = 'b';
config.edge_alpha = 0.5;
plot_target_hist(config);

box on;
legend('-DynamicLegend');
propertyeditor('on');

if strcmp(getenv('computername'), 'MSI') 
    up_save = 'C:/Users/user/Google Drive/pymethspec/figures'; 
elseif strcmp(getenv('computername'), 'DESKTOP-4BEQ7MS') 
    up_save = 'D:/Aaron/Bio/pymethspec/figures'; 
else 
    up_save = 'C:/Users/user/Google Drive/pymethspec/figures'; 
end 

save_path = sprintf('%s/%s', ...
    up_save, ...
    get_result_path(config));
mkdir(save_path);

savefig(f, sprintf('%s/age_hist.fig', save_path))
saveas(f, sprintf('%s/age_hist.png', save_path))

