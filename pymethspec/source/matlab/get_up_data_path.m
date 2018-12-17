function up = get_up_data_path()
if strcmp(getenv('computername'), 'MSI')
    up = 'D:/YandexDisk/Work/pymethspec/data';
elseif strcmp(getenv('computername'), 'DESKTOP-4BEQ7MS')
    up = 'C:/Users/User/YandexDisk/pymethspec/data';
else
    up = 'E:/YandexDisk/Work/pymethspec/data';
end
end