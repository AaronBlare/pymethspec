function fn = get_result_path(config)
fn = '';
annotation = sprintf('ex(%s)_CR(%s)_SNP(%s)_chr(%s)_gene(%s)_geo(%s)_class(%s)', ...
                    config.exclude,...
                    config.cross_reactive,...
                    config.snp,...
                    config.chr,...
                    config.gene_region,...
                    config.geo,...
                    cofig.probe_class);
attribute = sprintf('cells(%s)_disease(%s)_gender(%s)_LS(%s)_age(%s)',...
                    config.cells,...
                    config.disease,...
                    config.gender,...
                    config.life_style,...
                    config.age);
if strcmp(config.data_type, 'gene_data')
    fn = sprintf('%s/%s/%s/%s/%s/%s/%s', ...
                    config.data_base, ...
                    config.data_type, ...
                    config.experiment,...
                    config.task,...
                    config.method,...
                    annotation,...
                    attribute);
elseif strcmp(config.data_type, 'attributes')
    fn = sprintf('%s/%s', ...
                    config.data_base, ...
                    config.data_type);
end
end