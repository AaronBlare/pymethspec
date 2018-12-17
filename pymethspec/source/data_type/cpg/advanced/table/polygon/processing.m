clear all;

% ======== params ========
config_lvl_1.metrics_rank = 1;
config_lvl_1.plot_method = 1;
config_lvl_1.metrics_diff_id = 2;
config_lvl_1.metrics_diff_direction = 'ascend';
config_lvl_1.part = 0.0005;

% ======== config ========
config_lvl_1.data_base = 'GSE87571';
config_lvl_1.data_type = 'cpg';

config_lvl_1.lvl_1_experiment = 'base';
config_lvl_1.lvl_1_task = 'table';
config_lvl_1.lvl_1_method = 'variance_linreg';

config_lvl_1.exclude = 'cluster';
config_lvl_1.cross_reactive = 'exclude';
config_lvl_1.snp = 'exclude';
config_lvl_1.chr = 'non_gender';
config_lvl_1.gene_region = 'yes';
config_lvl_1.geo = 'any';
config_lvl_1.probe_class = 'any';

config_lvl_1.cells = 'none';
config_lvl_1.disease = 'any';
config_lvl_1.gender = 'versus';
config_lvl_1.life_style = 'any';
config_lvl_1.age = 'any';

config_lvl_1.suffix = '';

config_lvl_1.is_clustering = 0;

config_lvl_1.up = get_up_data_path(); 

% ======== save_config ========
config_lvl_2.data_base = config_lvl_1.data_base;
config_lvl_2.data_type = config_lvl_1.data_type;

config_lvl_2.experiment = 'advanced';
config_lvl_2.task = 'table';
config_lvl_2.method = 'polygon';

config_lvl_2.exclude = config_lvl_1.exclude;
config_lvl_2.cross_reactive = config_lvl_1.cross_reactive;
config_lvl_2.snp = config_lvl_1.snp;
config_lvl_2.chr = config_lvl_1.chr;
config_lvl_2.gene_region = config_lvl_1.gene_region;
config_lvl_2.geo = config_lvl_1.geo;
config_lvl_2.probe_class = config_lvl_1.probe_class;

config_lvl_2.cells = config_lvl_1.cells;
config_lvl_2.disease = config_lvl_1.disease;
config_lvl_2.gender = 'versus';
config_lvl_2.life_style = config_lvl_1.life_style;
config_lvl_2.age = config_lvl_1.age;

config_lvl_2.suffix = config_lvl_1.suffix;

config_lvl_2.is_clustering = config_lvl_1.is_clustering;

config_lvl_2.up = get_up_figures_path(); 

% ======== processing ========
specific(config_lvl_1, config_lvl_2);