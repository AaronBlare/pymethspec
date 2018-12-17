from source.infrastucture.path import *
import pandas as pd


def load_table_dict(config):
    fn = get_table_path(config) + '/' + config.setup.get_file_name() + '.xlsx'
    df = pd.read_excel(fn)
    return df.to_dict()