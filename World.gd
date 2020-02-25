extends Container

# données
var seance 		: Seance
var classroom 	: Classroom
# groups = {group_id: group}
var groups		: Dictionary
var scores		: Dictionary

# connexion => GUI
var score_text	: String

# valeurs par défaut
var effectif = 5
var classroom_label = "Classe par défaut"
var id = 0


func _ready():
	
	seance = $MarginContainer/Seance
	
	# connexion 
	# Seance  => World
	seance.sync_datas = funcref (self, "sync_datas_from_seance")
	
	# nouvelle séance
	new_seance_configuration()
	seance.start()


func get_score():
	return str(score_text)


func update_score():
	score_text= ""
	var student_label
	var student_id
	var group_id
	for student in classroom.students_list():
		student_id=	student.get_id()
		group_id=	student.get_group()
		student_label=	student.get_label()
		score_text += str(student_label) +"\t" + str(group_id) + "\n"
	print(score_text)


func sync_datas_from_seance():
	print(classroom)
	update_score()
	print("(W) Data synchronised")


func new_seance_configuration():
#	seance = $MarginContainer/Seance
	for child in seance.get_children():
		child.queue_free()
	classroom = Classroom.new()
	classroom.populate_classroom(effectif, classroom_label)
	seance.classroom= classroom
	
	groups.empty()
	seance.groups= groups
	
	seance._id= id
	
	update_score()


func new_seance_from_GUI_buttons(new_effectif, new_classroom_label):
	effectif = max(0,new_effectif)
	classroom_label = new_classroom_label
	
	new_seance_configuration()
	seance.start()


func new_seance_from_GUI_array(array:Array):
	# array[0] 		= classroom label
	# array[1]... 	= students label
	if array == []:
		return
	
	effectif 		= len(array) - 1
	classroom_label	= array.pop_front()
	
	new_seance_configuration()
	
	# change students label with array
	for id in range(len(array)):
		classroom.student(id).set_label(array[id])
	
	seance.start()

