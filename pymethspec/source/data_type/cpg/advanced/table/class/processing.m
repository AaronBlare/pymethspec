clear all;

num_base_exps = 1;
num_advanced_exps = 1;
target_base_exp = 1;

data_base = 'GSE87571';
data_type = 'cpg';

base_experiment = 'base';
base_task = 'table';
base_methods = ['variance_linreg'];

base_exclude = 'cluster';
base_cross_reactive = 'ex';
base_snp = 'ex';
base_chr = 'NG';
base_gene_region = 'yes';
base_geo = 'any';
base_probe_class = 'any';

base_cells = 'none';
base_disease = 'any';
base_genders = ['vs'];
base_life_style = 'any';
base_age = 'any';

base_suffixes = [''];
base_exps_ids = [7];

advanced_experiment = 'advanced';
advanced_task = 'table';
advanced_methods = ['polygon'];

advanced_exclude = 'cluster';
advanced_cross_reactive = 'ex';
advanced_snp = 'ex';
advanced_chr = 'NG';
advanced_gene_region = 'yes';
advanced_geo = 'any';
advanced_probe_class = 'any';

advanced_cells = 'none';
advanced_disease = 'any';
advanced_genders = ['vs'];
advanced_life_style = 'any';
advanced_age = 'any';

advanced_suffixes = [''];
advanced_exps_ids = [7];

all_metrics_labels = [];
intersection_names = [];
base_metrics_map = {};
advanced_metrics_map = {};
base_configs = {};
advanced_configs = {};

for base_exp_id = 1:num_base_exps
    
    config_base.data_base = data_base;
    config_base.data_type = data_type;
    
    config_base.experiment = base_experiment;
    config_base.task = base_task;
    config_base.method = base_methods(base_exp_id);
    
    config_base.exclude = base_exclude;
    config_base.cross_reactive = base_cross_reactive;
    config_base.snp = base_snp;
    config_base.chr = base_chr;
    config_base.gene_region = base_gene_region;
    config_base.geo = base_geo;
    config_base.probe_class = base_probe_class;
    
    config_base.cells = base_cells;
    config_base.disease = base_disease;
    config_base.gender = base_genders(base_exp_id);
    config_base.life_style = base_life_style;
    config_base.age = base_age;
    
    config_base.suffix = base_suffixes(base_exp_id);
    config_base.exp_id = base_exps_ids(base_exp_id);
    
    config_base.is_clustering = 0;
    
    config_base.up = get_up_data_path();
    
    [names, metrics_labels, metrics_map] = base_condition(config_base);
    
    if base_exp_id == 1 
        intersection_names = names;
    else
        intersection_names = intersect(intersection_names, names);
    end
    
    all_metrics_labels = horzcat(all_metrics_labels, metrics_labels);
    base_metrics_map{end + 1} = metrics_map;
    
    base_configs{end + 1} = config_base;
end

for advanced_exp_id = 1:num_advanced_exps
    
    config_advanced.data_base = data_base;
    config_advanced.data_type = data_type;
    
    config_advanced.experiment = advanced_experiment;
    config_advanced.task = advanced_task;
    config_advanced.method = advanced_methods(advanced_exp_id);
    
    config_advanced.exclude = advanced_exclude;
    config_advanced.cross_reactive = advanced_cross_reactive;
    config_advanced.snp = advanced_snp;
    config_advanced.chr = advanced_chr;
    config_advanced.gene_region = advanced_gene_region;
    config_advanced.geo = advanced_geo;
    config_advanced.probe_class = advanced_probe_class;
    
    config_advanced.cells = advanced_cells;
    config_advanced.disease = advanced_disease;
    config_advanced.gender = advanced_genders(advanced_exp_id);
    config_advanced.life_style = advanced_life_style;
    config_advanced.age = advanced_age;
    
    config_advanced.suffix = advanced_suffixes(advanced_exp_id);
    config_advanced.exp_id = advanced_exps_ids(advanced_exp_id);
    
    config_advanced.is_clustering = 0;
    
    config_advanced.up = get_up_data_path();
    
    [names, metrics_labels, metrics_map] = advanced_condition(base_configs{target_base_exp}, config_advanced);
    
    intersection_names = intersect(intersection_names, names);
    
    all_metrics_labels = horzcat(all_metrics_labels, metrics_labels);
    advanced_metrics_map{end + 1} = metrics_map;

    advanced_configs{end + 1} = config_advanced;
    
    save_config = config_advanced;
end

metrics_data = [];
for name_id = 1:size(intersection_names,1)
    name = string(intersection_names(name_id));
    data = [];
    for base_exp_id = 1:num_base_exps
        data = horzcat(data, base_metrics_map{base_exp_id}(name));
    end
    
    for advanced_exp_id = 1:num_advanced_exps
        data = horzcat(data, advanced_metrics_map{advanced_exp_id}(name));
    end
    metrics_data = vertcat(metrics_data, data);
end

base_suffix = sprintf('%d', base_exps_ids(1));
for base_exp_id = 2:num_base_exps
    base_suffix = sprintf('%s_%d', base_suffix, base_exps_ids(base_exp_id));
end

advanced_suffix = sprintf('%d', advanced_exps_ids(1));
for advanced_exp_id = 2:num_advanced_exps
    advanced_suffix = sprintf('%s_%d', advanced_suffix, advanced_exps_ids(advanced_exp_id));
end

suffix = sprintf('class_by_base(%s)_advanced(%s)', base_suffix, advanced_suffix);
path = sprintf('%s/%s', ...
    save_config.up, ...
    get_result_path(save_config));
mkdir(path)
fn = sprintf('%s/%s.xlsx', ...
    path, ...
    suffix);

d = vertcat("names", intersection_names);
for metrics_id = 1:size(metrics_data, 2)
    d = horzcat(d, vertcat(all_metrics_labels(metrics_id), string(metrics_data(:, metrics_id))));
end

xlswrite(fn, d);