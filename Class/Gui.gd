class_name Gui



static func save_game(classe, debug=false):
	printt("save_game(): début")
	var save_game = File.new()
	
	# version debug pour les tests unitaires
	var name
	if debug:
		name = "user://_savegame.save"
	else:
		name = "user://savegame.save"
	
	save_game.open(name, File.WRITE)
	
	save_game.store_line(to_json(classe.to_json()))
	save_game.close()
	printt("save_game(): fin")


static func load_game(debug=false):
	printt("load_game(): début")
	
	# version debug pour les tests unitaires
	var name
	if debug:
		name = "user://_savegame.save"
	else:
		name = "user://savegame.save"
	
	var save_game = File.new()
	if not save_game.file_exists(name):
		printt("load_game(): Pas de fichier à restaurer")
		return # Error! We don't have a save to load.

	printt("load_game(): fichier trouvé")
	save_game.open(name, File.READ)
	
	var current_line = save_game.get_line()
	current_line = parse_json(JSON.parse(current_line).result)
		
	# création de la Classroom peuplée de Students
	var classroom = Classroom.new()
	var student
	for element in current_line:
		student = Student.new()
		student.from_dict(element)
		classroom.add_student(student)

	return classroom

