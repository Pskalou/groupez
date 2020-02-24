extends "res://addons/gut/test.gd"




func test_set_get_id():
	var classroom = Classroom.new()
	assert_true(classroom.get_id()==0, "id par défaut de classroom")
	classroom.set_id(10)
	assert_true(classroom.get_id()==10, "modification de l'id de la classroom")
	
	

func test_has_id():
	var classroom = Classroom.new()
	classroom.populate_test_classe(1, "toto")
	assert_false(classroom.has_id(1), "recherche d'un id bien précis")
	assert_true(classroom.has_id(0), "recherche d'un id bien précis")


func test_populate_test_class():
	var classroom = Classroom.new()
	classroom.populate_test_classe(1, "toto")
	var texte = "id:0\tlabel:toto0\tgroup:Null\tlevel:0\n"
	assert_true(classroom.to_string() == texte, "création d'une classe à 1 élève")


func test_list_empty():
	var classroom = Classroom.new()
	classroom.populate_test_classe(4, "toto")
	assert_true(len(classroom.list()) == 4 , "longueur de liste correcte")
	assert_true(classroom.list()[2].get_label() == "toto2" , "navigation dant la liste de Student")


func test_list():
	var classroom = Classroom.new()
	classroom.populate_test_classe(4, "toto")
	assert_true(classroom.list(0).get_id() == 0 , "accès direct à l'élément 0")
	assert_true(classroom.list(2).get_label() == "toto2" , "accès direct au label n°2")

func test_student():
	var classroom = Classroom.new()
	classroom.populate_test_classe(4, "toto")
	assert_true(classroom.student(0).get_id() == 0 , "accès direct à l'élément 0")
	assert_true(classroom.student(2).get_label() == "toto2" , "accès direct au label n°2")


func test_student_by_id():
	var classroom = Classroom.new()
	classroom.populate_test_classe(4, "toto")
	assert_true(classroom.student_by_id(2).get_label() == "toto2" , "accès par id")


func test_add():
	var classroom = Classroom.new()
	classroom.populate_test_classe(4, "toto")
	classroom.add_student(Student.new(5, "pascal"))
	assert_true(classroom.list(4).get_label() == "pascal", "ajout à la main d'un student")


func test_add_impossible():
	var classroom = Classroom.new()
	classroom.populate_test_classe(5, "toto")
	var test = classroom.add_student(Student.new(4, "pascal"))
	assert_true(test == -1, "ajout impossible car ID déjà présent")
