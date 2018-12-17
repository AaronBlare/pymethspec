function specific(config_lvl_1, config_lvl_2)

if strcmp(config_lvl_1.gender, 'any')
    [config_lvl_1.names, config_lvl_1.data] = get_data(config_lvl_1);
    save_data(config_lvl_1, config_lvl_2);
else
    [config_lvl_1.names, config_lvl_1.data_1, config_lvl_1.data_2] = get_specific_data(config_lvl_1);
    [config_lvl_1.metrics_1, config_lvl_1.metrics_2] = get_specific_metrics(config_lvl_1);
    [config_lvl_1.metrics_diff, config_lvl_1.metrics_diff_labels] = get_specific_polygons(config_lvl_1);
    
    num_names = size(config_lvl_1.names, 1)
    
    config_lvl_1.order = get_specific_order(config_lvl_1);
    
    save_specific(config_lvl_1, config_lvl_2);
end

end