extends Node2D


# boutons gauche et droit
var right_button 
var left_button

# nom et niveau de l'étudiant
var student
var label
var level


func _ready():
	
	right_button= $"Bord/MarginContainer/HBoxContainer/right_button"
	left_button= $"Bord/MarginContainer/HBoxContainer/left_button"
	
	label = $"Bord/MarginContainer/label"
	level = $"Bord2/MarginContainer/level"
	
	# les rendre à moitier opaque
	right_button.set_modulate(Color( 0.2, 1, 0.2, 0.2 ))
	left_button.set_modulate(Color( 1, 0.2, 0.2, 0.2 ))
	
	var Student= preload("res://Class/Student.gd")
	student= Student.new()
	new(student)


func new(_student):
	print ("student_button: " + str(_student.get_label()) + ": créé")
	self.student= _student
	self.label.set_text(str(_student.get_label()))
	self.level.set_text(str(_student.get_level()))


func _on_right_button_mouse_entered():
	right_button.set_modulate(Color( 0.2, 1, 0.2, 0.5 ))

func _on_right_button_mouse_exited():
	right_button.set_modulate(Color( 0.2, 1, 0.2, 0.2))

func _on_right_button_pressed():
#	print (get_node(".").get_layer())
	var old_level = student.get_level()
	student.set_level(old_level + 1)
	level.set_text(str(student.get_level()))
	printt(student.get_label() + ": "+ str(student.get_level()))


func _on_left_button_mouse_entered():
	left_button.set_modulate(Color( 1, 0.2, 0.2, 0.5 ))

func _on_left_button_mouse_exited():
	left_button.set_modulate(Color( 1, 0.2, 0.2, 0.2))

func _on_left_button_pressed():
	var old_level = student.get_level()
	student.set_level(old_level - 1)
	level.set_text(str(student.get_level()))
	printt(student.get_label() + ": "+ str(student.get_level()))
	pass # Replace with function body.


var mouse_dragging
var difference


var start_position:Vector2

func _on_object_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if !mouse_dragging:
				difference= get_global_mouse_position() - position
#				printt("dragging student bloc")
			mouse_dragging = true
			z_index = z_index+1
		else:
			mouse_dragging = false
			z_index = z_index -1
			var pos= get_global_mouse_position() - difference
			Singleton.send_student_button_signal(self, pos, touched_nodes)
	
	if event is InputEventMouseMotion and mouse_dragging:
		set_position(get_global_mouse_position() - difference)



var touched_nodes:Array = []

func is_touching_bloc():
	if touched_nodes == []:
		return false
	else:
		return true
	


func _on_center_contact_area_entered(area):
	touched_nodes.append(area.get_parent())
	printt("(OK) student_button", self, "list of touched nodes", touched_nodes )
	
	var node_over = area.get_parent()
	printt("(OK) student_button",self, "touched by:", node_over)


func _on_center_contact_area_exited(area):
	touched_nodes.erase(area.get_parent()) 
	printt("(OK) student_button", self, "list of touched nodes", touched_nodes )
	







