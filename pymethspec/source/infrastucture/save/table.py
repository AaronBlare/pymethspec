from source.infrastucture.path import *
import pandas as pd


def save_table_dict(config, table_dict):
    fn = get_table_path(config) + '/' + config.setup.get_file_name() + '.xlsx'
    df = pd.DataFrame(table_dict)
    writer = pd.ExcelWriter(fn, engine='xlsxwriter')
    df.to_excel(writer, index=False)
    writer.save()
