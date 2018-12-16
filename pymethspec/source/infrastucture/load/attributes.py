from source.infrastucture.path import *
from source.config.attribute.types import *
import os.path
import pickle


def load_attribute_dict(config):
    fn = get_data_base_path(config) + '/' + config.attribute.name
    fn_txt = fn + '.txt'
    fn_pkl = fn + '.pkl'

    if os.path.isfile(fn_pkl):

        f = open(fn_pkl, 'rb')
        attribute_dict = pickle.load(f)
        f.close()

    else:

        possible_keys = [x.value for x in AttributeKey]
        f = open(fn_txt)
        key_line = f.readline()
        keys = key_line.split(' ')
        keys = [x.rstrip() for x in keys]

        attribute_dict = {}
        for key in keys:
            if key in possible_keys:
                attribute_dict[key] = []

        for line in f:
            values = line.split(' ')
            for key_id in range(0, len(keys)):
                key = keys[key_id]
                if key in possible_keys:
                    attribute_dict[key].append(values[key_id].rstrip())
        f.close()

        f = open(fn_pkl, 'wb')
        pickle.dump(attribute_dict, f, pickle.HIGHEST_PROTOCOL)
        f.close()

    return attribute_dict
