import os.path
from source.config.data.types import *

def get_data_base_path(config):
    return config.data.get_data_base_path()

def get_cache_path(config):
    return get_data_base_path(config) + '/' + \
           DataType.cache.value

def get_result_path(config):
    return str(config.data) + '/' + \
           str(config.setup) + '/' + \
           str(config.annotation) + '/' + \
           str(config.attribute)
