extends Node

# For both these functions, when the buttons are pressed, it carries
# out the corresponding action in the gamer_saver script file.
# Although, the load button both creates a new save if there isn't
# one and also loads information.

func _on_save_button_pressed() -> void:
	GameSaver.save_info()

func _on_load_button_pressed() -> void:
	GameSaver.check_save()
