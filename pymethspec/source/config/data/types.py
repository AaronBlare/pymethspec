from enum import Enum
import getpass


class DataPath(Enum):
    local_1 = 'D:/YandexDisk/Work/pymethspec/data'
    local_2 = 'E:/YandexDisk/Work/pymethspec/data'
    local_3 = 'C:/Users/User/YandexDisk/pymethspec/data'
    cluster = '/common/home/' + getpass.getuser() + '/Work/pymethspec/data'


class DataBase(Enum):
    GSE40279 = 'GSE40279'
    GSE52588 = 'GSE52588'
    GSE30870 = 'GSE30870'
    GSE61256 = 'GSE61256'
    GSE63347 = 'GSE63347'
    GSE87571 = 'GSE87571'
    liver = 'liver'
    data_base_versus = 'versus'


class DataType(Enum):
    cpg = 'cpg'
    gene = 'gene'
    bop = 'bop'
    suppl = 'suppl'
    cache = 'cache'
    versus = 'versus'
