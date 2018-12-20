function [names, data] = get_data(config)
if strcmp(config.method, 'manova')
    target_str = '';
    types_str = '';
    for i = 1:length(config.attribute_target)
        target_str = sprintf('%s_%s', target_str, config.attribute_target{i});
    end
    target_str = strip(target_str,'left','_');
    for i = 1:length(config.attributes_types)
        types_str = sprintf('%s_%s', types_str, config.attributes_types{i});
    end
    types_str = strip(types_str,'left','_');
    file_name = sprintf('top_target(%s)_exog(%s).txt', target_str, types_str);
else
    file_name = 'default.xlsx';
end

fn = sprintf('%s/%s/%s', ...
    config.up, ...
    get_result_path(config), ...
    file_name);
raw_data = importdata(fn, '\t');

names = raw_data.textdata(2:end, 1);
data = raw_data.data;
end