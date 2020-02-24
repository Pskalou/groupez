extends Node2D



# boutons gauche et droit
var right_button 
var left_button

var area

var group
var label
var level
var size


# blocs
var vertical_rect : ColorRect
var end_rect : ColorRect


func _ready():
	
	
	# blocs
	vertical_rect= $"vertical_rect"
	end_rect= $"end_rect"

	# collission Shape pour détecter les contacts
	area= $"Area2D/Shape"
	
	# interface IHM
	right_button= $"ColorRect/MarginContainer/HBoxContainer/right_button"
	left_button=  $"ColorRect/MarginContainer/HBoxContainer/left_button"
	
	label = $"ColorRect/MarginContainer/label"
	level = $"ColorRect/MarginContainer2/level"
	
	# les rendre à moitier opaque
	right_button.set_modulate(Color( 0.2, 1, 0.2, 0.2 ))
	left_button.set_modulate(Color( 1, 0.2, 0.2, 0.2 ))
	
	
	group= Group.new()
	new(group)


func has_node(node_over) -> bool:
	for current_node in self.get_children():
		if current_node == node_over:
			return true
	return false


func add_student():
	pass


func get_size() -> int:
	return self.size


func set_size(size):
	self.size= size
	self.adjust_size()


func restore_size():
	self.size= group.get_size()
	adjust_size()


func adjust_size():
	# end_rectangle position
	var start_pos= Vector2(0,50)
	var new_pos= start_pos + size * Vector2(0,50)
	end_rect.set_position(new_pos)
	
	# vertical_rectangle size
	var new_height= 50* size
	vertical_rect.set_size( Vector2(50,new_height) )

	# area2D surface
	# mise à l'échelle du rectangleShape
	var center_y= (50 + 50* size + 50) / 2 # rect du haut + center + end_rect
	area.shape.set_extents(Vector2(175,center_y))
	area.set_position(Vector2(175,center_y))


func new(group:Group):
	print ("group: " + str(group.get_id()) + ": créé")
	self.group= group
	self.size= group.get_size()
	self.label.set_text(group.get_label())
	self.level.set_text(str(group.get_group_level()))
	self.adjust_size()


func _on_right_button_mouse_entered():
	right_button.set_modulate(Color( 0.2, 1, 0.2, 0.5 ))

func _on_right_button_mouse_exited():
	right_button.set_modulate(Color( 0.2, 1, 0.2, 0.2))

func _on_right_button_pressed():
	var old_level = group.get_group_level()
	group.set_group_level(old_level + 1)
	level.set_text(str(group.get_group_level()))
	print(group.get_label() + ": "+ str(group.get_group_level()))


func _on_left_button_mouse_entered():
	left_button.set_modulate(Color( 1, 0.2, 0.2, 0.5 ))

func _on_left_button_mouse_exited():
	left_button.set_modulate(Color( 1, 0.2, 0.2, 0.2))

func _on_left_button_pressed():
	var old_level = group.get_group_level()
	group.set_group_level(old_level - 1)
	level.set_text(str(group.get_group_level()))
	print(group.get_label() + ": "+ str(group.get_group_level()))

#
var mouse_dragging
var difference


func _on_ColorRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if !mouse_dragging:
				difference= get_viewport().get_mouse_position() - position
			mouse_dragging = true
			# mise au premier plan
			z_index = z_index + 1
		else:
			mouse_dragging = false
			# remettre sur le plan initial
			z_index = z_index - 1
	if event is InputEventMouseMotion and mouse_dragging:
		var pos= get_viewport().get_mouse_position() - difference
		set_position(pos)




func _on_Area2D_area_entered(area):
	# nodes
	var node_over = area.get_parent()
	printt("goup_bloc",self, "touched by:", node_over)
	
	Singleton.send_group_bloc_touched_signal(self, node_over)



func _on_Area2D_area_exited(area):
	var node_over = area.get_parent()
	printt("goup_bloc",self, "end of touched by", node_over)
	
	Singleton.send_group_bloc_exited_signal(self, node_over)
	
	pass # Replace with function body.
