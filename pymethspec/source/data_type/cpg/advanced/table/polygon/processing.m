clear all;

% ======== params ========
config_base.metrics_rank = 1;
config_base.plot_method = 1;
config_base.metrics_diff_id = 2;
config_base.metrics_diff_direction = 'ascend';
config_base.part = 0.0005;

% ======== config ========
config_base.data_base = 'GSE87571';
config_base.data_type = 'cpg';

config_base.experiment = 'base';
config_base.task = 'table';
config_base.method = 'variance_linreg';

config_base.exclude = 'cluster';
config_base.cross_reactive = 'ex';
config_base.snp = 'ex';
config_base.chr = 'NG';
config_base.gene_region = 'yes';
config_base.geo = 'any';
config_base.probe_class = 'any';

config_base.cells = 'none';
config_base.disease = 'any';
config_base.gender = 'vs';
config_base.life_style = 'any';
config_base.age = 'any';

config_base.suffix = '';

config_base.is_clustering = 0;

config_base.up = get_up_data_path(); 

% ======== save_config ========
config_advanced.data_base = config_base.data_base;
config_advanced.data_type = config_base.data_type;

config_advanced.experiment = 'advanced';
config_advanced.task = 'table';
config_advanced.method = 'polygon';

config_advanced.exclude = config_base.exclude;
config_advanced.cross_reactive = config_base.cross_reactive;
config_advanced.snp = config_base.snp;
config_advanced.chr = config_base.chr;
config_advanced.gene_region = config_base.gene_region;
config_advanced.geo = config_base.geo;
config_advanced.probe_class = config_base.probe_class;

config_advanced.cells = config_base.cells;
config_advanced.disease = config_base.disease;
config_advanced.gender = 'vs';
config_advanced.life_style = config_base.life_style;
config_advanced.age = config_base.age;

config_advanced.suffix = config_base.suffix;

config_advanced.is_clustering = config_base.is_clustering;

config_advanced.up = get_up_figures_path(); 

% ======== processing ========
specific(config_base, config_advanced);