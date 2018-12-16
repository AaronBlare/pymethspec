from source.config.annotation.annotation import *
from source.config.attribute.attribute import *
from source.config.setup.setup import *
from source.config.data.data import *


class Config:

    def __init__(self,
                 data,
                 setup,
                 annotation,
                 attribute,
                 target=AttributeKey.age.value
                 ):

        self.data = data
        self.setup = setup
        self.annotation = annotation
        self.attribute = attribute
        self.target = target

        self.annotation_dict = load_annotation_dict(self)
        self.attribute_dict = load_attribute_dict(self)
        self.attribute_indexes = get_indexes(self)