function indexes = get_attributes_indexes(config)
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

indexes = [1:size(ann{1}, 1)-1]';

if gender_id > 0
    genders = ann{1,gender_id};
    genders = genders(2:end);
    
    if ~strcmp(string(config.gender), 'any')
        curr_indexes = [];
        for id = 1:size(genders, 1)
            if strcmp(genders(id), config.gender)
                curr_indexes = vertcat(curr_indexes, id);
            end
        end
        tmp_indexes = intersect(indexes, curr_indexes);
        indexes = tmp_indexes;
    end
end

if disease_id > 0
    diseases = ann{1,disease_id};
    diseases = diseases(2:end);
    
    if ~strcmp(string(config.disease), 'any')
        curr_indexes = [];
        for id = 1:size(diseases, 1)
            if strcmp(diseases(id), config.disease)
                curr_indexes = vertcat(curr_indexes, id);
            end
        end
        tmp_indexes = intersect(indexes, curr_indexes);
        indexes = tmp_indexes;
    end
end

end