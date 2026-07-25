extends Node2D

@export var interaction_scene : PackedScene
@export var gui_canvas_layer : CanvasLayer

@export var placeholder_planet : Area2D


func _ready() -> void:
	placeholder_planet.body_entered.connect(stop_area_entered.bind("placeholder_planet"))

func stop_area_entered(useless_var, encounter_id):
	GlobalData.encounter_identifier = encounter_id
	var interaction = interaction_scene.instantiate()
	gui_canvas_layer.add_child(interaction)
