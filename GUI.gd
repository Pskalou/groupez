extends Control


var texte			:String
var start_info		:RichTextLabel
var start_popup		:Popup
var effectif_label	:Label
var score_popup		:Popup
var score_info		:RichTextLabel
# focus
var classroom_label_focus	:LineEdit
var classroom_focus 		: TextEdit

# valeurs par défaut
var effectif 		= 10
var classroom_label = "Nom de la classe"
var score_text
# connexion => World
var new_seance_from_buttons	:FuncRef
var new_seance_from_array	:FuncRef
var get_score				:FuncRef


func _ready():
	# variables
	start_info  = get_node("Popup/Panel/VBoxContainer/info_container/Info")
	start_popup = get_node("Popup")
	
	score_popup	= get_node("Score_popup")
	score_info	= get_node("Score_popup/Panel/VBoxContainer/info_container/VBoxContainer/Score_info_label")
	
	effectif_label= 		$Popup/Panel/VBoxContainer/PanelContainer/CenterContainer/VBoxContainer/effectif_container/effectif_label
	classroom_label_focus= 	$Popup/Panel/VBoxContainer/PanelContainer/CenterContainer/VBoxContainer/HBoxContainer/classroom_label_focus
	classroom_focus= 		$Popup/Panel/VBoxContainer/info_container/VBoxContainer/Classroom_focus
	# affichages
	effectif_label.set_text(str(effectif))
	
	
func show_popup():
	start_popup.popup_centered_ratio()


func _on_more_button_pressed():
	effectif = effectif + 1
	effectif_label.set_text(str(effectif))
	pass # Replace with function body.


func _on_less_button_pressed():
	effectif = max (0,effectif - 1)
	effectif_label.set_text(str(effectif))
	pass # Replace with function body.


func _on_validate_effectif_button_pressed():
	# Datas
	var lineEdit_text  = classroom_label_focus.get_text()
	if  lineEdit_text != "":
		classroom_label = lineEdit_text
	print(classroom_label)
	
	# GUI's datas => World
	new_seance_from_buttons.call_func(effectif, classroom_label)
	start_popup.set_visible(false)


func _on_list_Button_pressed():	
	var array = textEdit_to_array(classroom_focus)
	
	# GUI's datas => World
	new_seance_from_array.call_func(array)
	start_popup.set_visible(false)


func textEdit_to_array(textEdit) -> String:
	var my_array= []
	var number_of_lines = textEdit.get_line_count()

	for i in range(number_of_lines):
		var line = textEdit.get_line(i)
		line = line.lstrip(" ").rstrip(" ")
		
		if line != "":
			my_array.append(line)
			
	return (my_array)


func _on_Score_Button_pressed():	
	start_popup.set_visible(false)
	score_info.clear()
	##
	
	score_text= get_score.call_func()
	score_info.set_bbcode(score_text) 
	score_popup.popup_centered_ratio()
	score_popup.set_visible(true)
	pass # Replace with function body.


func _on_Close_Score_Button_pressed():
	score_text= get_score.call_func()
	print(score_text)
#	score_info.clear()
	score_info.set_bbcode(score_text) 
#	score_popup.set_visible(false)
	pass # Replace with function body.
