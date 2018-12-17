from source.config.data.data import *
from source.config.setup.setup import *
from source.config.annotation.annotation import *
from source.config.attribute.attribute import *
from source.config.config import *
from source.data_type.cpg.base.table.linreg.processing import *


def generate_table(config):
    if config.setup.method == Method.linreg:
        generate_table_linreg(config)


data = Data(
    name='cpg_beta',
    type=DataType.cpg,
    path='',
    base=DataBase.GSE87571.value
)

setup = Setup(
    experiment=Experiment.base.value,
    task=Task.table.value,
    method=Method.linreg.value,
    params={},
    suffix='',
)

annotation = Annotation(
    name='annotation',
    exclude=Exclude.none.value,
    cross_reactive=CrossReactive.exclude.value,
    snp=SNP.exclude.value,
    chr=Chromosome.non_gender.value,
    gene_region=GeneRegion.yes.value,
    geo=Geo.any.value,
    probe_class=ProbeClass.any.value
)

attribute = Attribute(
    name='attribute',
    cells=Cells.none.value,
    cells_name='cells',
    disease=Disease.any.value,
    gender=Gender.F.value,
    life_style=LifeStyle.any.value,
    age=Age.any.value
)

config = Config(
    data=data,
    setup=setup,
    annotation=annotation,
    attribute=attribute,
    target=AttributeKey.age.value
)

generate_table(config)
