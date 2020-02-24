extends "res://addons/gut/test.gd"


func test_save_load():
	var classroom = Classroom.new()
	classroom.populate_test_classe(3, "Test_")
	Gui.save_game(classroom, true)

	var restored_classroom = Gui.load_game(true)
	var test = (classroom.to_string() == restored_classroom.to_string())
	assert_true(test, "sauvegarde puis restauration\n" + restored_classroom.to_string())
