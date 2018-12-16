from source.infrastucture.path import *
import os.path
import pickle


def load_excluded(config):
    exclude = []

    if config.annotation.exclude != '':
        fn = get_data_base_path(config) + '/' + config.annotation.exclude
        fn_txt = fn + '.txt'
        fn_pkl = fn + '.pkl'

        if os.path.isfile(fn_pkl):

            f = open(fn_pkl, 'rb')
            exclude = pickle.load(f)
            f.close()

        else:
            f = open(fn_txt)
            exclude = f.readlines()
            f.close()

            f = open(fn_pkl, 'wb')
            pickle.dump(exclude, f, pickle.HIGHEST_PROTOCOL)
            f.close()

    return exclude
