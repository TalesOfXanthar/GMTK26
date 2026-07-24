extends Node2D

@export var interaction_scene : PackedScene
@export var gui_canvas_layer : CanvasLayer

func _ready() -> void:
	var interaction = interaction_scene.instantiate()
	gui_canvas_layer.add_child(interaction)
