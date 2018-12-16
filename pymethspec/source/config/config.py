from source.infrastucture.load.annotation import *
from source.infrastucture.load.excluded import *
from source.infrastucture.load.attributes import *
from source.annotation.subset import *
from source.attribute.subset import *


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

        self.cpg_list = []
        self.cpg_gene_dict = {}
        self.cpg_bop_dict = {}
        self.gene_cpg_dict = {}
        self.gene_bop_dict = {}
        self.bop_cpg_dict = {}
        self.bop_gene_dict = {}

        self.attribute_indexes = []

        self.excluded = load_excluded(self)

        self.annotation_dict = load_annotation_dict(self)
        subset_annotations(self)

        self.attribute_dict = load_attribute_dict(self)
        subset_attributes(self)
