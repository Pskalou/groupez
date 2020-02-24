class_name Classroom
"""
classe qui gère les classroom 
(ouaaaaaa)
"""
# Class Classroom.gd

# list of Student
var _students
var _id:int


func set_id(id):
	self._id= id

	
func get_id() -> int:
	return self._id


func _init(id=0):
	self._students = []
	self._id= id


func has_id(id) -> bool:
	for student in _students:
		if student.get_id() == id:
			return true
	return false


func add_student(student):
	var id = student.get_id()
	if has_id(id):
		print ("création impossible, ID déjà utilisée")
		return -1
	_students.append(student)


func list(index = null):
	if index == null:
		return _students
	return _students[index]


func student(index):
	return _students[index]


func student_by_id(id):
	for student in _students:
		if id == student.get_id():
			return student
	return null


func populate_test_classe(number_of_users, label) :
	""" populate classroom with tests students """
	var students = []
	for id in range(number_of_users):
		var user_label = label + str(id)
		students.append(Student.new(id, user_label) )
	self._students = students


func _to_string():
	return to_string()


func to_string() -> String:
	var texte = ""
	for element in _students:
		texte += element.to_string()
		texte += "\n"
	return texte


func to_json():
	var my_list = []
	for element in _students:
		my_list.append(element.to_dict())
	return to_json(my_list)
