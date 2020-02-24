extends "res://addons/gut/test.gd"



func test_get_size():
	var group= Group.new()
	group.add_by_id (10)
	group.add_by_id (11)
	assert_true(group.get_size() == 2 , "taille du groupe")
	

func test_list():
	var group= Group.new()
	group.add_by_id (10)
	group.add_by_id (11)
	var my_list= group.list()
	assert_true(my_list[10]== 0 , "récupération de la liste de type Array")


func test_set_get_id():
	var group= Group.new()
	assert_true(group.get_id() == 0, "id par défaut = 0")
	group= Group.new(10)
	assert_true(group.get_id() == 10, "id imposé à la création")
	group.set_id(25)
	assert_true(group.get_id() == 25, "id modifié")


func test_get_student_total():
	var group= Group.new()
	group.add_by_id (10)
	group.add_by_id (11)
	group.set_group_level(50)
	group.set_student_level(10,5)
	group.set_student_level(11,15)
	assert_true(group.get_student_total(10) == 55, "points collectifs du groupe")
	assert_true(group.get_student_total(11) == 65, "points collectifs du groupe")


func test_set_get_group_level():
	var group= Group.new()
	group.add_by_id (10)
	group.add_by_id (11)
	group.set_group_level(50)
	assert_true(group.get_group_level() == 50, "points collectifs du groupe")


func test_set_get_student_level():
	var group= Group.new()
	group.add_by_id (10)
	group.add_by_id (11)
	group.set_student_level(10,5)
	assert_true(group.get_student_level(10) == 5, "score de l'étudiant")
	assert_true(group.get_student_level(11) == 0, "score de l'étudiant")


func test_add_by_id():
	var group= Group.new()
	group.add_by_id (10)
	assert_true(group.has_student_id(10), "ajout d'un étudiant dans un groupe")
	group.add_by_id (10)
	assert_false(group.has_student_id(11), "ajout d'un étudiant dans un groupe")

