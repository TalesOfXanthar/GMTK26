extends Node

@export var text_box : Control

func _ready() -> void:
	text_box.end_dialogue.connect(queue_free)
