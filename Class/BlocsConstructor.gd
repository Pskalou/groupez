extends Node2D
class_name BlocsConstructor


var classroom_node	:Node
var classroom		:Classroom
var node_scene		:Node
var groups			:Array


func _init(classroom_init:Classroom, node_scene_init:Node):
	self.node_scene= node_scene_init
	self.classroom= classroom_init


func remove_group_blocs(group_id):
	for group_bloc in groups:
		var current_group_id= group_bloc.group.get_id()
		if current_group_id == group_id:
			printt("OK BlocConstructor", self, "group_bloc supprimé")
			groups.erase(group_bloc)
			group_bloc.queue_free()


func group_blocs_get_position(group_id) -> Vector2:
	for group_bloc in groups:
		var current_group_id= group_bloc.group.get_id()
		if current_group_id == group_id:
			printt("OK BlocConstructor", self, "retourne la position du groupe")
			return (group_bloc.get_position() + Vector2(50,50))
	printt("(E) blocConstructor", self, "retour de position impossible")
	return Vector2(0,0)


func build_group_blocs(pos:Vector2, group:Group):
	var classroom_button = []
	var index= 0

	groups.append(preload("res://UI/group_bloc.tscn").instance())
	var group_bloc= groups[-1]
	node_scene.add_child(group_bloc)
	group_bloc.new(group)
	group_bloc.set_position(pos + Vector2(-50,-50))
	
	var group_size= group.get_size()
	group_bloc.set_size(group_size)
	
	pos= Vector2(50,50)
	for id in group.list():
		var student= classroom.student_by_id(id)

		printt("instanciation student_button")
		classroom_button.append(preload("res://UI/student_button.tscn").instance())
		var current_button:Node2D = classroom_button[index]

		printt("affichage et positionnement du student_button")
		group_bloc.add_child(current_button)
		current_button.set_position(pos)

		printt("initialisation du student_button")
		current_button.new(student)

		pos += Vector2(0, 50)
		index += 1



func build_classroom_blocs():
	self.classroom_node= Node.new()
	self.node_scene.add_child(classroom_node)
	var classroom_button = []
	var index= 0
	var pos = Vector2(50,50)
	for student in classroom.list():
		if student.get_group() != null:
			continue

		printt("instanciation student_button")
		classroom_button.append(preload("res://UI/student_button.tscn").instance())
		var current_button:Node2D = classroom_button[index]

		printt("affichage et positionnement du student_button")
		classroom_node.add_child(current_button)
		current_button.set_position(pos)

		printt("initialisation du student_button")
		current_button.new(student)

		pos += Vector2(0, 50)
		index += 1
