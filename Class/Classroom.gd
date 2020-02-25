class_name Classroom
"""
classe qui gère les classroom 
(ouaaaaaa)
"""
# Class Classroom.gd


# {student_id: student}
var students:Dictionary
var _id:int


func set_id(id):
	self._id= id


func get_id() -> int:
	return self._id


func _init(id=0):
	self.students.empty()
	self._id= id


func has_id(id) -> bool:
	return students.has(id)


func add_student(student):
	var id = student.get_id()
	if has_id(id):
		print ("création impossible, ID déjà utilisée")
		return -1
	students[id] = student


func students_list():
	return students.values()


func student(id):
	return students[id]


func student_by_id(id):	
	return students.get(id)


func populate_classroom(number_of_users, label) :
	""" populate classroom with tests students """
	var students_dict = {}
	for id in range(number_of_users):
		var user_label = label + str(id)
		students_dict[id] = Student.new(id, user_label)
	self.students= students_dict


func _to_string():
	return to_string()


func to_string() -> String:
	var texte = ""
	for element in students.values():
		texte += element.to_string()
		texte += "\n"
	return texte


func to_json():
	var my_list = []
	for element in students.values():
		my_list.append(element.to_dict())
	return to_json(my_list)
