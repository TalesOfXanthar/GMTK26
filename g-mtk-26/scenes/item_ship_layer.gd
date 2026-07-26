extends CanvasLayer


func _input(event: InputEvent) -> void:
	if event.is_action("tab"):
		show()
	if event.is_action_released("tab"):
		hide()
