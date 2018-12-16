from source.config.attribute.types import *


class Attribute:

    def __init__(self,
                 name='attribute',
                 cells=Cells.any.value,
                 disease=Disease.any.value,
                 gender=Gender.any.value,
                 life_style=LifeStyle.any.value,
                 age=Age.any.value
                 ):
        self.name = name
        self.cells = cells
        self.disease = disease
        self.gender = gender
        self.life_style = life_style
        self.age = age

    def __str__(self):
        return 'cells(' + self.cells + ')' + '_' + \
               'disease(' + self.disease + ')' + '_' + \
               'gender(' + self.gender + ')' + '_' + \
               'LS(' + self.life_style + ')' + '_' + \
               'age(' + self.age + ')'
