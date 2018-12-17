clear all;

metric = "r_test";

data_base = 'GSE87571';
data_type = 'cpg';

exclude = 'cluster';
cross_reactive = 'exclude';
snp = 'exclude';
chr = 'non_gender';
gene_region = 'yes';
geo = 'any';
probe_class = 'any';

cells = 'none';
disease = 'any';
gender = 'versus';
life_style = 'any';
age = 'any';

lvl_1_experiment = 'base';
lvl_1_task = 'table';
lvl_1_method = 'custom';
lvl_1_suffix = '';

lvl_2_experiment = 'base';
lvl_2_task = 'clock';
lvl_2_method = 'linreg_mult';
lvl_2_suffix = '_type(all)_num(15)_num_comb(15)';

% ======== config_lvl_1 ========
config_lvl_1.data_base = data_base;
config_lvl_1.data_type = data_type;

config_lvl_1.experiment = lvl_1_experiment;
config_lvl_1.task = lvl_1_task;
config_lvl_1.method = lvl_1_method;

config_lvl_1.exclude = exclude;
config_lvl_1.cross_reactive = cross_reactive;
config_lvl_1.snp = snp;
config_lvl_1.chr = chr;
config_lvl_1.gene_region = gene_region;
config_lvl_1.geo = geo;
config_lvl_1.probe_class = probe_class;

config_lvl_1.cells = cells;
config_lvl_1.disease = disease;
config_lvl_1.gender = gender;
config_lvl_1.life_style = life_style;
config_lvl_1.age = age;

config_lvl_1.is_clustering = 0;

config_lvl_1.up = get_up_data_path();

config_lvl_1.suffix = lvl_1_suffix;

% ======== config_lvl_2 ========
config_lvl_2.data_base = data_base;
config_lvl_2.data_type = data_type;

config_lvl_2.experiment = lvl_2_experiment;
config_lvl_2.task = lvl_2_task;
config_lvl_2.method = lvl_2_method;

config_lvl_2.exclude = exclude;
config_lvl_2.cross_reactive = cross_reactive;
config_lvl_2.snp = snp;
config_lvl_2.chr = chr;
config_lvl_2.gene_region = gene_region;
config_lvl_2.geo = geo;
config_lvl_2.probe_class = probe_class;

config_lvl_2.cells = cells;
config_lvl_2.disease = disease;
config_lvl_2.gender = gender;
config_lvl_2.life_style = life_style;
config_lvl_2.age = age;

config_lvl_2.is_clustering = 0;

config_lvl_2.up = get_up_data_path();

config_lvl_2.suffix = lvl_2_suffix;


% ======== processing ========
f = figure;
if strcmp(config_lvl_2.gender, 'versus')
    config_lvl_2.gender = 'F';
    config_lvl_2.color = 'r';
    plot_clock_metrics(config_lvl_1, config_lvl_2, metric)
    config_lvl_2.gender = 'M';
    config_lvl_2.color = 'b';
    plot_clock_metrics(config_lvl_1, config_lvl_2, metric)
    config_lvl_2.gender = 'versus';
else
    config_lvl_2.color = 'g';
    plot_clock_metrics(config_lvl_1, config_lvl_2, metric)
end

suffix = sprintf('metric(%s)', metric);

up_save = get_up_figure_path();

save_path = sprintf('%s/%s', ...
    up_save, ...
    get_result_path(config_lvl_2));
mkdir(save_path);

box on;
b = gca;
legend(b,'off');
xlim([1 100])
title(sprintf('clock_method(%s)', config_lvl_1.method), 'FontSize', 16, 'Interpreter', 'none')

savefig(f, sprintf('%s/clock_method(%s)_metric(%s).fig', save_path, config_lvl_1.method, metric))
saveas(f, sprintf('%s/clock_method(%s)_metric(%s).png', save_path, config_lvl_1.method, metric))