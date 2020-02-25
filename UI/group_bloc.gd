extends Node2D



# boutons gauche et droit
var right_button 
var left_button

var full_area

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
	full_area= $"Area2D/Shape"
	
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


func add_student():
	pass


func get_size():
	return self.size


func restore_size():
	set_size(group.get_size())



func set_size(_size):
	self.size= _size
	self.adjust_size()


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
	var half_height= (50 + size * 50 + 50 )/2
	full_area.shape.set_extents(Vector2(175,half_height))
	full_area.set_position(Vector2(175,half_height))


func new(_group:Group):
	print ("group: " + str(_group.get_id()) + ": créé")
	self.group= _group
	self.size= _group.get_size()
	self.label.set_text(_group.get_label())
	self.level.set_text(str(_group.get_group_level()))
	self.adjust_size()


func _on_right_button_mouse_entered():
	right_button.set_modulate(Color( 0.2, 1, 0.2, 0.5 ))

func _on_right_button_mouse_exited():
	right_button.set_modulate(Color( 0.2, 1, 0.2, 0.2))

func _on_right_button_pressed():
	var old_level = group.get_group_level()
	group.set_group_level(old_level + 1)
	level.set_text(str(group.get_group_level()))
	printt(group.get_label() + ": "+ str(group.get_group_level()))


func _on_left_button_mouse_entered():
	left_button.set_modulate(Color( 1, 0.2, 0.2, 0.5 ))

func _on_left_button_mouse_exited():
	left_button.set_modulate(Color( 1, 0.2, 0.2, 0.2))

func _on_left_button_pressed():
	var old_level = group.get_group_level()
	group.set_group_level(old_level - 1)
	level.set_text(str(group.get_group_level()))
	printt(group.get_label() + ": "+ str(group.get_group_level()))

#
var mouse_dragging
var difference


func _on_ColorRect_gui_input(event):
	pass
	if event is InputEventMouseButton:
		if event.is_pressed():
			if !mouse_dragging:
				difference= get_viewport().get_mouse_position() - position
			mouse_dragging = true
			z_index = z_index+1
		else:
			mouse_dragging = false
			z_index = z_index-1
	if event is InputEventMouseMotion and mouse_dragging:
		var pos= get_viewport().get_mouse_position() - difference
		set_position(pos)


func has_node_children(other_node):
	return self.get_children().has(other_node)


func _on_Area2D_area_entered(area):
	var other_node= area.get_parent()
	if ! has_node_children(other_node):
		Singleton.send_group_bloc_touched_signal(self, area.get_parent())
	
		printt("ENTERED me", self, "other", area.get_parent())
	

func _on_Area2D_area_exited(area):
	var other_node= area.get_parent()
	if ! has_node_children(other_node):
	
		printt("EXITED me", self, "other", area.get_parent())
		Singleton.send_group_bloc_exited_signal(self, area.get_parent())

