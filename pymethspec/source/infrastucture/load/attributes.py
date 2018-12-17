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
                    value = values[key_id].rstrip()
                    if str.isdigit(value):
                        value = float(value)
                        if value.is_integer():
                            attribute_dict[key].append(int(value))
                        else:
                            attribute_dict[key].append(float(value))
                    else:
                        attribute_dict[key].append(value)
        f.close()

        f = open(fn_pkl, 'wb')
        pickle.dump(attribute_dict, f, pickle.HIGHEST_PROTOCOL)
        f.close()

    return attribute_dict


def load_cells_dict(config):
    fn = get_data_base_path(config) + '/' + config.attribute.cells_name
    fn_txt = fn + '.txt'
    fn_pkl = fn + '.pkl'

    if os.path.isfile(fn_pkl):

        f = open(fn_pkl, 'rb')
        cells_dict = pickle.load(f)
        f.close()

    else:

        f = open(fn_txt)
        key_line = f.readline()
        keys = key_line.split('\t')
        keys = [x.rstrip() for x in keys]

        cells_dict = {}
        for key in keys:
            cells_dict[key] = []

        for line in f:
            values = line.split('\t')
            for key_id in range(0, len(keys)):
                key = keys[key_id]
                value = values[key_id].rstrip()
                if str.isdigit(value):
                    cells_dict[key].append(float(value))
                else:
                    cells_dict[key].append(value)
        f.close()

        f = open(fn_pkl, 'wb')
        pickle.dump(cells_dict, f, pickle.HIGHEST_PROTOCOL)
        f.close()

    return cells_dict

