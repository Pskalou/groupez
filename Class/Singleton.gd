extends Node


signal student_button_dropped(student_button, position, touched_nodes)
signal group_bloc_touched(group_bloc, node_over)
signal group_bloc_exited(group_bloc, node_over)


func send_student_button_signal(student_button, position,previous_position, touched_nodes):
	emit_signal("student_button_dropped", student_button, position,previous_position, touched_nodes)


func send_group_bloc_exited_signal(group_bloc, node_over):
	emit_signal("group_bloc_exited", group_bloc, node_over)


func send_group_bloc_touched_signal(group_bloc, node_over):
	emit_signal("group_bloc_touched", group_bloc, node_over)
