extends Node


# touche ESC

func _ready():
	
	$GUI.show_popup()
	
	# connexion GUI => World
	$GUI.new_seance_from_buttons= funcref($World, "new_seance_from_GUI_buttons")
	$GUI.new_seance_from_array	= funcref($World, "new_seance_from_GUI_array")
	# connexion GUI <= World
#	$GUI.score_text				= $World.score_text
	$GUI.get_score	= funcref($World, "get_score")
