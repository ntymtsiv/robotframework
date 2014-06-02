import os
import sys
import httplib
import ast
import copy
import json
from robot.libraries.BuiltIn import BuiltIn

class CommonKeywords(object):

#    def __init__(self):
     #   self._sut_path = os.path.join(os.path.dirname(__file__),
#                                      '..', 'sut', 'login.py')
    VALID_PARAMAS_FOR_CREATE_VD = ['raid_level']

    def _parse_args_in_json(self, args):
        json = {}
        for arg in args:
           key, value = arg.split('=')
           json[key] = value
        return json

    def list_count_should_be(self, _list, expected_count):
	if  len(_list)!=int(expected_count):
		raise AssertionError("{0} != {1}".format(len(_list), int(expected_count)))

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
    
    def create_json_for_delete_raid(self, *args):
        json = _parse_args_in_json(args)

    def create_json_for_raid_creating(self, controller_id, pd_list, args):
        _json = {}
        _args = args.split(' ')
        for arg in _args:
            key, value = arg.split('=')
            if key == "drives_number":
                _json["drives"] = self._get_unused_pd_from_list(pd_list, value)
	#TODO delete when raid_level wiil be striing instead of int
            elif key == "raid_level":
		_json["raid_level"] = int(value)
            else:
                if key in self.VALID_PARAMAS_FOR_CREATE_VD:
                    _json[key] = value
        return json.dumps(_json)

    def _get_unused_pd_from_list(self, pd_list, drives_number):
        drives = []
        for i in range(int(drives_number)):
            for drive in pd_list["data"]:
                if drive["state"] == "unconfigured_good" and drive not in drives:
		    _drive={}
		    _drive["controller_id"] = drive["controller_id"]
		    _drive["enclosure"] = drive["enclosure"]
		    _drive["slot"] = drive["slot"]  
		    pd_list["data"].remove(drive)
                    drives.append(_drive)
                    break
        
#	raise AssertionError(drives)
        return drives



    def vd_should_be_in_vd_list(self, controller_id, vd_list,  vd_id, **args):
#	for vd in 
	pass
    def insert_in_json(self, *args):
        json = BuiltIn().replace_variables('${JSON_TEMPLATE}')
        json = ast.literal_eval(json)
        json['raids'][0] = self._parse_args_in_json(args)
        return json

    def print_this(self, *args):
        a = []
        for i in args:
            a.append(i)
        return a



