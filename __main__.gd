extends Node


# touche ESC
func _unhandled_input(event):
    if event is InputEventKey:
        if event.pressed and event.scancode == KEY_ESCAPE:
            get_tree().quit()


func _ready():	
	var camera
	camera = get_node("Camera2D")
	camera._set_current(false)
	
	var scene= get_node("MarginContainer/Node2D")
	
	# Création d'une classe de 5 Students
	var classroom = Classroom.new(50)
	classroom.populate_test_classe(5, "2CAP_AEPE_")
	
	# Création d'une séance notée
	var seance= Seance.new(scene, classroom, 15)
	
	
	# Ajout de tous les élèves au groupe 0, 1 et 2
#	var groupA= Group.new(5)
#	groupA.add_by_id(0)
#	groupA.add_by_id(1)
#	groupA.add_by_id(2)
	
	# Ajout du groupe à la séance
#	seance.add_group(groupA)
	
	# Affichage des blocs du group
#	groupA_bloc.show_bloc(groupA, classroom)

#	var blocs= BlocsConstructor.new(classroom, scene)




	# 2e groupe
#	var groupB= Group.new(7)
#	groupB.add_by_id(3)
#	groupB.add_by_id(4)
#
#	seance.add_group(groupB)
#	var groupB_bloc= preload("res://UI/group_bloc.tscn").instance()
#	scene.add_child(groupB_bloc)
#	groupB_bloc.show_bloc(groupB, classroom)
#	groupB_bloc.set_position(Vector2(400,0))
	
	
	
	
	var texte = str(classroom)
	
	var info  = get_node("Popup/Info")
	var popup = get_node("Popup")
	popup.popup_centered_ratio()
	info.set_text(texte)
