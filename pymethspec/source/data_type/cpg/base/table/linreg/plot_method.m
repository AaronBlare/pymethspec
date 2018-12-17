clear all;

cpgs = string(importdata('cpgs.txt'));
prefix = 'class_3_';
config.is_plot_regions = 1;

% ======== config ========

config.data_base = 'GSE87571';
config.data_type = 'cpg';

config.experiment = 'base';
config.task = 'table';
config.method = 'linreg';

config.exclude = 'cluster';
config.cross_reactive = 'exclude';
config.snp = 'exclude';
config.chr = 'non_gender';
config.gene_region = 'yes';
config.geo = 'any';
config.probe_class = 'any';

config.cells = 'none';
config.disease = 'any';
config.gender = 'versus';
config.life_style = 'any';
config.age = 'any';

config.suffix = '_outliers_limit(0.0)_outliers_sigma(0.0)';

config.is_clustering = 0;

config.color = '';

config.up = get_up_data_path();

[annotations_map, labels] = get_annotations(config);

for cpg_id = 1:size(cpgs, 1)
    
    cpg = cpgs(cpg_id)
    
    curr_ann = annotations_map(cpg);
    genes_str = curr_ann(find(labels=="UCSC_REFGENE_NAME"));
    genes = strsplit(genes_str,';');
    genes = unique(genes);
    genes = strjoin(genes, ';');
    
    % ======== processing ========
    f = figure;
    if strcmp(config.gender, 'versus')
        config.gender = 'F';
        config.color = 'r';
        plot_linreg_cpg(config, cpg)
        config.gender = 'M';
        config.color = 'b';
        plot_linreg_cpg(config, cpg)
        config.gender = 'versus';
    else
        plot_linreg_cpg(config, cpg)
    end
    
    suffix = sprintf('cpg(%s)', cpg);
    
    up_save = get_up_figure_path();
    
    save_path = sprintf('%s/%s', ...
        up_save, ...
        get_result_path(config));
    mkdir(save_path);
    
    box on;
    b = gca;
    legend(b,'off');
    yl = ylim;
    if yl(1) < 0 && yl(2) > 1
        ylim([0, 1]);
    end
    if yl(1) < 0
        ylim([0, yl(2)]);
    end
    if yl(2) > 1
        ylim([yl(1), 1]);
    end
    title(sprintf('%s(%s)', cpg, genes), 'FontSize', 16)
    
    savefig(f, sprintf('%s/%s%d_linreg_%s.fig', save_path, prefix, cpg_id, suffix))
    saveas(f, sprintf('%s/%s%d_linreg_%s.png', save_path, prefix, cpg_id, suffix))
    
end
