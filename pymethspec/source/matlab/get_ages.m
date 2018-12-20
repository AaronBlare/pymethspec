function ages = get_ages(config)
age_ann = 'age';
gender_ann = 'gender';
disease_ann = 'disease';

fn = sprintf('%s/%s/attribute.txt', config.up, config.data_base);

delimiter = '\t';
formatSpec = '%s%s%s%s%s%[^\n\r]';
fileID = fopen(fn,'r');
ann = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);

age_id = 0;
gender_id = 0;
disease_id = 0;
for key_id = 1:size(ann, 2)
    curr_key = ann{1, key_id};
    if strcmp(curr_key{1}, age_ann)
        age_id = key_id;
    end
    if strcmp(curr_key{1}, gender_ann)
        gender_id = key_id;
    end
    if strcmp(curr_key{1}, disease_ann)
        disease_id = key_id;
    end
end

ages = ann{1,age_id};
ages = str2double(ages(2:end));

end