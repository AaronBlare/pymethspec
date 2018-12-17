clear all;

cpgs = string(importdata('cpgs.txt'));
data_bases = ["GSE40279"; "GSE87571"];

for cpg_id = 1:size(cpgs, 1)
    
    cpg = cpgs(cpg_id)
    
    f = figure;
    for data_base_id = 1:size(data_bases, 1)
        
        % ======== config ========
        
        config.data_base = data_bases(data_base_id);
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
        
        config.is_clustering = 0;
        
        config.color = '';
        
        config.up = get_up_data_path();
        
        % ======== processing ========
        subplot(1, size(data_bases, 1), data_base_id)
        
        if strcmp(config.gender, 'versus')
            config.gender = 'F';
            config.color = 'r';
            plot_linreg_cpg(config, cpg)
            config.gender = 'M';
            config.color = 'b';
            plot_linreg_cpg(config, cpg)
            config.gender = 'versus';
        end
        
        box on;
        b = gca;
        legend(b,'off');
        title(config.data_base, 'FontSize', 16)
        yl = ylim;
        if yl(1) < 0
            ylim([0, yl(2)]);
        end
        if yl(2) > 1
            ylim([yl(1), 1]);
        end
        sgtitle(cpg, 'FontSize', 20)
        propertyeditor('on')
        
        suffix = sprintf('cpg(%s)_data_bases(%s)', cpg, join(sort(data_bases), '_'));
        
        config.data_base = "versus";
        
        up_save = get_up_figure_path();
        
        save_path = sprintf('%s/%s', ...
            up_save, ...
            get_result_path(config));
        mkdir(save_path);
        
        savefig(f, sprintf('%s/linreg_%s.fig', save_path, suffix))
        saveas(f, sprintf('%s/linreg_%s.png', save_path, suffix))
        
    end
    
end