from source.config.attribute.types import *
import numpy as np


def get_attribute_indexes(config, target, common):
    passed_indexes = []
    attributes = config.attributes[target]
    if config.attribute.disease != common:
        passed_indexes = list(range(0, len(attributes)))
    else:
        for index in range(0, len(attributes)):
            if config.attribute.disease == attributes[index]:
                passed_indexes.append(index)
    return passed_indexes


def get_indexes(config):
    indexes = list(range(0, len(list(config.attribute_dict.values())[0])))
    
    target = AttributeKey.gender.value
    common = Gender.any.value
    if target in config.attribute_dict:
        passed_indexes = get_attribute_indexes(config, target, common)
        indexes = list(set(indexes).intersection(passed_indexes))

    target = AttributeKey.disease.value
    common = Disease.any.value
    if target in config.attribute_dict:
        passed_indexes = get_attribute_indexes(config, target, common)
        indexes = list(set(indexes).intersection(passed_indexes))

    indexes.sort()

    return indexes


def subset_attributes(config):
    config.attribute_indexes = get_indexes(config)
    for key, values in config.attribute_dict.items():
        values = list(map(int, list(np.array(values)[config.attribute_indexes])))
