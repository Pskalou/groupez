# class Seance.gd
extends Node2D
class_name Seance

#fait le lien entre une classroom et des groupes notés

var _classroom
# dictionary {"id":..., "group":...}
var groups:Dictionary
var _id
var _blocs
var _groups_next_id
var _scene


var _group_bloc_old_size


func _init(scene, classroom, id = 0):
	printt("Seance.gd: création de séance "+ str(id))
	printt("Seance.gd: séance "+ str(id) + " connectée à classroom " + str(classroom.get_id()))
	
	self._scene= scene
	self.groups= {}
	self._id= id
	self._classroom= classroom
	self._groups_next_id= 0
	
	# signaux à écouter et actions à faire
	Singleton.connect("student_button_dropped", self , "_on_Student_Button_dropped")
	Singleton.connect("group_bloc_touched", self , "_on_group_bloc_touched")
	Singleton.connect("group_bloc_exited", self , "_on_group_bloc_exited")
	
	# constructeur de blocs
	_blocs= BlocsConstructor.new(_classroom, _scene)
	_build_classroom_blocs()


func _build_classroom_blocs():
	if _blocs.classroom_node != null:
		_blocs.classroom_node.queue_free()
	_blocs.build_classroom_blocs()


func _build_group_blocs(group_id, position):
	var group= _select_group(group_id)
	_blocs.build_group_blocs(position , group)
	printt("OK: création du bloc pour le"+ str(group.get_label())+"id"+str(group_id))


func _rebuild_group_blocs(group_id):
	printt("(W) récupération de position...")
	var position= _blocs.group_blocs_get_position(group_id)
	_blocs.remove_group_blocs(group_id)
	
	var group= _select_group(group_id)
	if group.get_size() > 0:
		_build_group_blocs(group_id, position)


func _student_has_group(student):
	if student.get_group() == null:
		return false
	else:
		return true


func _on_Student_Button_dropped(student_button, position, touched_nodes):
	printt("OK: signal 'student_button_dropped' capté !")
	
	var student_id = student_button.student.get_id()
	var student= _classroom.student_by_id(student_id)
	
	printt("OK: student id"+str(student_id)+" dropped")
	printt("OK: position"+str(position))
	
	# si l'étudiant n'appartient à aucun groupe
	if not _student_has_group(student):
		var group_id= _create_group()
		_add_student_to_group(student_id, group_id)
		_build_group_blocs(group_id, position)
		_suppress_student_button(student_button)
		_clean_groups_dict()
		printt("OK seance", self, "étudiant seul et groupe créé")
	# si l'étudiant quitte son groupe et est posé dans le vide => classroom
	elif touched_nodes == []:
		printt("(W) seance", self, "retour de l'étudiant dans classroom")
		var old_group_id = student.get_group()
		_remove_student_from_group(student_id)
		_suppress_student_button(student_button)
		_build_classroom_blocs()
		_rebuild_group_blocs(old_group_id)
	else:
		printt("(W) seance", self, "liste des nodes touchés",touched_nodes)
		
		
func _suppress_student_button(student_button):
	print ("(W): suppression du bloc déplacé")
	student_button.queue_free()


func _clean_groups_dict():
	"""used to remove empty group in groups dict"""
	for id in groups:
		if groups[id].get_size() == 0:
			groups[id].queue_free()
			groups.erase(id)
	printt("OK",self," nettoyage du tableau _groups")


func _select_group(group_id):
	return groups.get(group_id)


func _remove_student_from_group(student_id):
	var student= _classroom.student_by_id(student_id)
	var group_id= student.get_group()
	
	student.set_group(null)
	
	var group= _select_group(group_id)
	group.remove_by_id(student_id)
	

func _add_student_to_group(student_id, group_id):
	var group= _select_group(group_id)
	group.add_by_id(student_id)
	
	var student= _classroom.student_by_id(student_id)
	student.set_group(group_id)
	
	printt ("OK Seance",self,"student",student_id,"ajouté au group",group_id)


func _create_group() -> int:
	var id= _groups_next_id
	_groups_next_id = _groups_next_id + 1
	groups[id]= Group.new(id)
	printt("OK: groupe id"+ str(id)+" crée")
	return id


func add_group(group):
	"""add a new group to this seance"""
	printt("Seance.gd: "+ group.get_label() +
		" (id "+ str(group.get_id()) +") ajouté à la séance id "+ str(_id))
	self._groups.append(group)


func _on_group_bloc_exited(group_bloc, node_over):
	# clause de garde
	var node_over_filename= node_over.get_filename()
	if node_over_filename != "res://UI/student_button.tscn":
		return

	group_bloc.restore_size()
	printt("OK seance", self,"restauration du bloc")


func _on_group_bloc_touched(group_bloc, node_over):
	printt("(W) seance", self,"restauration du bloc")
	
	# Clause de garde si c'est pas un student bloc
	printt("(W) seance", self,node_over.get_filename())
	
	var node_over_filename= node_over.get_filename()
	if node_over_filename != "res://UI/student_button.tscn":
		return
	
	printt(self, "changement de la taille du bloc")
	
	# sauvegarde ancienne taille du bloc
	_group_bloc_old_size= group_bloc.get_size()
	
	if ! group_bloc.has_node_children(node_over):
		_set_size_group_bloc(group_bloc)


func _set_size_group_bloc(group_bloc):
	printt("(W): resize "+ str(group_bloc))
	var size= group_bloc.get_size()
	printt("size: ",size)
	group_bloc.set_size(size + 1)

