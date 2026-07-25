extends Node2D

var input_enter_monitoring = false

var stop_id : String

@export var interaction_scene : PackedScene
@export var gui_canvas_layer : CanvasLayer
@export var select_sfx : AudioStreamPlayer








@export var placeholder_planet : Area2D

var area_dict = {
	"placeholder_planet": {
		"repeat_state": 2,
		"node_name": "PlaceholderPlanet",
	}
}

# Three states of repeatability:
# 0: Repeatable, can do the encounter multiple times.
# 1: Non-repeatable, can only do the encounter once.
# 2: Stop area deletes itself after encounter.

func _ready() -> void:
	placeholder_planet.body_entered.connect(stop_area_entered.bind("placeholder_planet"))
	placeholder_planet.body_exited.connect(stop_area_exited.bind("placeholder_planet"))











func stop_area_entered(useless_var, encounter_id):
	stop_id = encounter_id
	get_node(area_dict[stop_id]["node_name"]).get_child(2).show()
	
	input_enter_monitoring = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("enter") && GlobalData.input_movement_monitoring == true:
		GlobalData.input_movement_monitoring = false
		GlobalData.fade_out()
		GlobalData.fade_out_completed.connect(start_interaction)
		select_sfx.play()

func stop_area_exited(useless_var, encounter_id):
	stop_id = encounter_id
	get_node(area_dict[stop_id]["node_name"]).get_child(2).hide()


func start_interaction():
	GlobalData.fade_out_completed.disconnect(start_interaction)
	GlobalData.encounter_identifier = stop_id
	var interaction = interaction_scene.instantiate()
	gui_canvas_layer.add_child(interaction)
	GlobalData.input_movement_monitoring = false
	
	if area_dict[stop_id]["repeat_state"] == 1:
		get_node(area_dict[stop_id]["node_name"]).body_entered.disconnect(stop_area_entered)
		input_enter_monitoring = false
	if area_dict[stop_id]["repeat_state"] == 2:
		get_node(area_dict[stop_id]["node_name"]).queue_free()
