function plot_clock_metrics(config_lvl_1, config_lvl_2, metric)

fn = sprintf('%s/%s/clock_method(%s)%s.xlsx', ...
    config_lvl_2.up, ...
    get_result_path(config_lvl_2), ...
    config_lvl_1.method, ...
    config_lvl_2.suffix);

[num,txt,raw] = xlsread(fn);

keys = raw(1, :);
metric_id = find(string(keys)==string(metric));

names = raw(2:end, 1);
counts = cell2mat(raw(2:end, 3));
metrics = cell2mat(raw(2:end, metric_id));

hold all;
h = plot(counts, metrics, 'o-', 'LineWidth', 3);
legend(h, sprintf('gender: %s', config_lvl_2.gender));
set(h, 'Color', config_lvl_2.color)
set(gca, 'FontSize', 30);
xlabel('count', 'Interpreter', 'latex');
set(gca, 'FontSize', 30);
ylabel(sprintf('%s', metric), 'Interpreter', 'none');
box on;

end

