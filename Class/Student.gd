class_name Student

var _id
var _label
var _level
var _group


func _init(id=0, label="default_label_0", level=0, group=null):
	""" id, label, level, group """
	_id= id
	_label= label
	_level= level
	_group= group


func from_dict(my_dict):	
	self._id= 		my_dict.get("id",0)
	self._label=	my_dict.get("label", "default_label_0")
	self._level= 	my_dict.get("level", 0)
	self._group= 	my_dict.get("group", null)


func to_dict() -> Dictionary:
	var my_dict = {}
	my_dict["id"] = self._id
	my_dict["label"] = self._label
	my_dict["level"] = self._level
	my_dict["group"] = self._group
	return my_dict


func to_string() -> String :
	var texte = ""
	texte += "id:" + str(self._id) + "\t"
	texte += "label:" + str(self._label) + "\t"
	texte += "group:" + str(self._group) + "\t"
	texte += "level:" + str(self._level)
	return texte


func _to_string():
	return to_string()


func get_id() -> int :
	return self._id
func set_id(id):
	self._id = id


func get_label() -> String:
	return self._label
func set_label(new_label):
	self._label = new_label
	
	
func get_group() -> int:
	return self._group
func set_group(group):
	self._group = group


func get_level() -> int:
	return self._level
func set_level(level):
	self._level = level
