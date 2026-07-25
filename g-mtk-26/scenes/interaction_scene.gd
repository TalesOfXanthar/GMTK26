extends Node

@export var text_box : Control

func _ready() -> void:
	text_box.end_dialogue.connect(GlobalData.fade_out)
	GlobalData.fade_out_completed.connect(queue_free)
