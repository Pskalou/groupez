extends Node


signal student_button_dropped(student_button, position, touched_nodes)
signal group_bloc_touched(group_bloc, node_over)
signal group_bloc_exited(group_bloc, node_over)


func send_student_button_signal(student_button, position, touched_nodes):
#	printt("Singleton.emit_signal('student_button_dropped'," + str(student_button.student.get_label()) + " at position "+str(position)+")")
	emit_signal("student_button_dropped", student_button, position, touched_nodes)


func send_group_bloc_exited_signal(group_bloc, node_over):
	emit_signal("group_bloc_exited", group_bloc, node_over)


func send_group_bloc_touched_signal(group_bloc, node_over):
#	printt("OK: group_bloc "+ group_bloc.group.get_label() +" Area2D entered detected")
	emit_signal("group_bloc_touched", group_bloc, node_over)
