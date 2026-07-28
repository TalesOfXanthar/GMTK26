extends Node

@export var text_box : Control

func _ready() -> void:
	text_box.end_dialogue.connect(Fader.fade_out)
	Fader.fade_out_completed.connect(delete_interaction_scene)

func delete_interaction_scene():
	Fader.fade_in()
	queue_free()
