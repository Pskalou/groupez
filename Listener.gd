extends Control


func _ready():
	pass # Replace with function body.

# ESC
func _unhandled_input(event):
    if event is InputEventKey:
        if event.pressed and event.scancode == KEY_ESCAPE:
            get_tree().quit()
