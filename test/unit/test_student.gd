extends "res://addons/gut/test.gd"




func test_from_dict():
	var user0 = Student.new()
	var my_dict={"id":10}
	user0.from_dict(my_dict)
	assert_true(user0.get_id() == 10, "doit retourner 10 car student modifié")
	assert_true(user0.get_group() == null, "doit retourner valeur par défaut (null)")


func test_to_dict():
	var user0 = Student.new(10, "toto", 20, 2)
	var my_dict = user0.to_dict()
	var my_dict2 = {"id":10,"level":20, "group":2, "label":"toto" }
	# test
	var test = true
	for key in my_dict.keys():
		test = test and (my_dict.get(key) == my_dict2.get(key))
	# assert
	assert_true(test, "export d'un student en dict\n")
	

func test_new_user():
	assert_true(Student.new(), "Nouvelle instance d'un Student")


func test_user_set_get_id():
	var user0 = Student.new()
	user0.set_id(5)
	assert_true(user0.get_id() == 5, "modification de l'id par defaut")

func test_user_set_get_group():
	var user0 = Student.new()
	user0.set_group(15)
	assert_true(user0.get_group() == 15, "modification de l'id par defaut")

func test_user_set_get_label():
	var user0 = Student.new()
	user0.set_label("pascal")
	assert_true(user0.get_label() == "pascal", "modification de l'id par defaut")

func test_user_set_get_points():
	var user0 = Student.new()
	user0.set_level(115)
	assert_true(user0.get_level() == 115, "modification de l'id par defaut")
