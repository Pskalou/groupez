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
	var _seance= Seance.new(scene, classroom, 15)
	
	
	# Affichage du pop-up
	var texte = str(classroom)
	
	var info  = get_node("Popup/Info")
	var popup = get_node("Popup")
	popup.popup_centered_ratio()

	info.set_text(texte)
