# class Group.gd
extends Node
class_name Group


# association d'étudiants
# c'est le groupe qui contient toutes les notes

var _students : Dictionary
var _group_level : int
var _id : int
var _label: String



func get_size():
	return len(self._students)


func _init(id=null, label="Groupe n°"):
	if id == null:
		id=0
	_students = {}
	_group_level = 0
	_id= id
	_label= label + str(id)


func list():
	return self._students


func _to_string():
	return to_string()


func to_string() -> String:
	var texte = "Group " + str(self._id) +": " + str(self._group_level) + "\n"
	for element in _students:
		texte += str(element)
		texte += "\n"
	return texte


func set_label(label):
	self._label= label


func get_label() -> String:
	return self._label


func set_id(id):
	_id = id


func get_id() -> int:
	return self._id


func add_by_id(student_id):
	if ! has_student_id(student_id):
		# dictionnaire : key = student_id / value = score
		self._students[student_id] = 0
		printt("OK: student id"+str(student_id)+" ajouté au groupe"+str(_id))
	else:
		printt("(E) déjà dans le groupe")


func remove_by_id(student_id):
	if has_student_id(student_id):
		_students.erase(student_id)
		printt("OK group",self,"student",student_id,"removed from group",_id)
		
	else:
		printt("(E) group",self,"suppression impossible car student absent")


func has_student_id(id):
	return _students.has(id)


func set_group_level(level):
	self._group_level = level


func get_group_level() -> int:
	return self._group_level


func get_student_total(id) -> int:
	return get_group_level() + get_student_level(id)


func set_student_level(id:int,level:int):
	if has_student_id(id):
		_students[id] = level
	

func get_student_level(id) -> int:
	if ! has_student_id(id):
		printt("(E) Group", self, "student inaccessible")
		return -1
	return _students[id]
