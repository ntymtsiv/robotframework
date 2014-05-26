import os
import sys
import httplib
import ast
import copy
from robot.libraries.BuiltIn import BuiltIn

class CommonKeywords(object):

#    def __init__(self):
     #   self._sut_path = os.path.join(os.path.dirname(__file__),
#                                      '..', 'sut', 'login.py')

    def add_in_temp_json(self, key, value):
        json = BuiltIn().replace_variables('${JSON_TEMPLATE}')
        json = ast.literal_eval(json)
        json['key'] = value
        return json

    def create_json_from_list_of_levels(self, *args):
        json = BuiltIn().replace_variables('${JSON_TEMPLATE}')
        json = ast.literal_eval(json)
        for i in args:
            temp_raid = copy.deepcopy(json['raids'][0])
            temp_raid['raid_lvl'] = i 
            json['raids'].append(temp_raid)
        return json

    def insert_in_json(self, *args):
        json = BuiltIn().replace_variables('${JSON_TEMPLATE}')
        json = ast.literal_eval(json)
        for i in args:
           key, value = i.split('=')
           json['raids'][0][key] = value
        return json

    def print_this(self, *args):
        a = []
        for i in args:
            a.append(i)
        return a



