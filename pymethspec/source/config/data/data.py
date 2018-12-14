from source.config.data.types import *
import socket
import os

"""
data_type can use only predefined enums
"""


class Data:

    def __init__(self,
                 data_type=DataType.cpg,
                 data_path='',
                 data_base=DataBase.GSE87571.value
                 ):
        self.data_type = data_type
        self.data_path = data_path
        self.data_base = data_base

        if self.data_path == '' or os.path.isdir(self.data_path):
            host_name = socket.gethostname()
            if host_name == 'MSI':
                self.data_path = DataPath.local_1.value
            elif host_name == 'DESKTOP-K9VO2TI':
                self.data_path = DataPath.local_2.value
            elif host_name == 'DESKTOP-4BEQ7MS':
                self.data_path = DataPath.local_3.value
            elif host_name == 'master' or host_name[0:4] == 'node':
                self.data_path = DataPath.cluster.value
