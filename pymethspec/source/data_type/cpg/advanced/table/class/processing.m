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
base_cross_reactive = 'exclude';
base_snp = 'exclude';
base_chr = 'non_gender';
base_gene_region = 'yes';
base_geo = 'any';
base_probe_class = 'any';

base_cells = 'none';
base_disease = 'any';
base_genders = ['versus'];
base_life_style = 'any';
base_age = 'any';


lvl_1_genders = ["versus"];

lvl_1_scenario = 'approach';
lvl_1_approach = 'top';
lvl_1_methods = ["linreg_variance_ols"];
lvl_1_suffixes = [""];
lvl_1_experiments = [7];

lvl_2_genders = ["versus"];

lvl_2_scenario = 'validation';
lvl_2_approach = 'top';
lvl_2_methods = ["gender_specific"];
lvl_2_suffixes = [""];
lvl_2_experiments = [7];

all_metrics_labels = [];
intersection_names = [];
lvl_1_metrics_map = {};
lvl_2_metrics_map = {};
lvl_1_configs = {};
lvl_2_configs = {};

for lvl_1_id = 1:num_base_exps
    
    clearvars config_lvl_1;
    
    config_lvl_1.data_base = data_base;
    config_lvl_1.data_type = data_type;
    
    config_lvl_1.cross_reactive = cross_reactive;
    config_lvl_1.snp = snp;
    config_lvl_1.chromosome_type = chromosome_type;
    
    config_lvl_1.dna_region = dna_region;
    
    config_lvl_1.info_type = info_type;
    
    config_lvl_1.scenario = lvl_1_scenario;
    config_lvl_1.approach = lvl_1_approach;
    config_lvl_1.method = lvl_1_methods(lvl_1_id);
    
    config_lvl_1.disease = disease;
    config_lvl_1.gender = lvl_1_genders(lvl_1_id);
    
    config_lvl_1.is_clustering = 0;
    
    config_lvl_1.up = get_up_data_path();
    
    config_lvl_1.suffix = lvl_1_suffixes(lvl_1_id);
    
    config_lvl_1.experiment = lvl_1_experiments(lvl_1_id);
    
    [names, metrics_labels, metrics_map] = lvl_1_condition(config_lvl_1);
    
    if lvl_1_id == 1 
        intersection_names = names;
    else
        intersection_names = intersect(intersection_names, names);
    end
    
    all_metrics_labels = horzcat(all_metrics_labels, metrics_labels);
    lvl_1_metrics_map{end + 1} = metrics_map;
    
    lvl_1_configs{end + 1} = config_lvl_1;
end

for lvl_2_id = 1:num_advanced_exps
    
    clearvars config_lvl_2;
    
    config_lvl_2.data_base = data_base;
    config_lvl_2.data_type = data_type;
    
    config_lvl_2.cross_reactive = cross_reactive;
    config_lvl_2.snp = snp;
    config_lvl_2.chromosome_type = chromosome_type;
    
    config_lvl_2.dna_region = dna_region;
    
    config_lvl_2.info_type = info_type;
    
    config_lvl_2.scenario = lvl_2_scenario;
    config_lvl_2.approach = lvl_2_approach;
    config_lvl_2.method = lvl_2_methods(lvl_2_id);
    
    config_lvl_2.disease = disease;
    config_lvl_2.gender = lvl_2_genders(lvl_2_id);
    
    config_lvl_2.is_clustering = 0;
    
    config_lvl_2.up = get_up_data_path();
    
    config_lvl_2.suffix = lvl_2_suffixes(lvl_2_id);
    
    config_lvl_2.experiment = lvl_2_experiments(lvl_2_id);
    
    [names, metrics_labels, metrics_map] = lvl_2_condition(lvl_1_configs{target_base_exp}, config_lvl_2);
    
    intersection_names = intersect(intersection_names, names);
    
    all_metrics_labels = horzcat(all_metrics_labels, metrics_labels);
    lvl_2_metrics_map{end + 1} = metrics_map;

    lvl_2_configs{end + 1} = config_lvl_2;
    
    save_config = config_lvl_2;
end

metrics_data = [];
for name_id = 1:size(intersection_names,1)
    name = string(intersection_names(name_id));
    data = [];
    for lvl_1_id = 1:num_base_exps
        data = horzcat(data, lvl_1_metrics_map{lvl_1_id}(name));
    end
    
    for lvl_2_id = 1:num_advanced_exps
        data = horzcat(data, lvl_2_metrics_map{lvl_2_id}(name));
    end
    metrics_data = vertcat(metrics_data, data);
end

lvl_1_suffix = sprintf('%d', lvl_1_experiments(1));
for lvl_1_id = 2:num_base_exps
    lvl_1_suffix = sprintf('%s_%d', lvl_1_suffix, lvl_1_experiments(lvl_1_id));
end

lvl_2_suffix = sprintf('%d', lvl_2_experiments(1));
for lvl_2_id = 2:num_advanced_exps
    lvl_2_suffix = sprintf('%s_%d', lvl_2_suffix, lvl_2_experiments(lvl_2_id));
end

suffix = sprintf('lvl_3_by_lvl_1(%s)_lvl_2(%s)', lvl_1_suffix, lvl_2_suffix);
path = sprintf('%s/data/%s', ...
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