extends Node2D
class_name Stops

var input_enter_monitoring = false

var stop_id : String
var temp_stop_id_for_planets = null

@export var interaction_scene : PackedScene
@export var gui_canvas_layer : CanvasLayer
@export var encounter_sfx : AudioStreamPlayer

var label : Label
@export var label_timer: Timer 
var label_fade_time := 0.5
var fade_out_active := false
var fade_in_active := false
var label_deleted := false







@export var placeholder_planet : Area2D
@export var blue_planet : Area2D
@export var red_cat : Area2D
@export var ghost_fleet : Area2D

var area_dict = {
	"placeholder_planet": {
		"repeat_state": 2,
		"node_name": "PlaceholderPlanet",
	},
	"supernova": {
		"repeat_state": 0,
	},
	"blue_planet": {
		"repeat_state": 0,
		"node_name": "BluePlanet"
	},
	"red_cat": {
		"repeat_state": 0,
		"node_name": "RedCat"
	},
	"ghost_fleet": {
		"repeat_state": 1,
		"node_name": "GhostFleet"
	}
}

# Three states of repeatability:
# 0: Repeatable, can do the encounter multiple times.
# 1: Non-repeatable, can only do the encounter once.
# 2: Stop area deletes itself after encounter.

func _ready() -> void:
	placeholder_planet.body_entered.connect(stop_area_entered.bind("placeholder_planet"))
	placeholder_planet.body_exited.connect(stop_area_exited.bind("placeholder_planet"))
	blue_planet.body_entered.connect(stop_area_entered.bind("blue_planet"))
	blue_planet.body_exited.connect(stop_area_exited.bind("blue_planet"))
	red_cat.body_entered.connect(stop_area_entered.bind("red_cat"))
	red_cat.body_exited.connect(stop_area_exited.bind("red_cat"))
	ghost_fleet.body_entered.connect(stop_area_entered.bind("ghost_fleet"))
	ghost_fleet.body_exited.connect(stop_area_exited.bind("ghost_fleet"))










func stop_area_entered(useless_var, encounter_id):
	label_deleted = false
	stop_id = encounter_id
	label = get_node(area_dict[stop_id]["node_name"]).get_child(2)
	label.modulate = Color(1, 1, 1, 0)
	label.show()
	label_timer.wait_time = label_fade_time
	fade_in_active = true
	fade_out_active = false
	label_timer.start()
	
	input_enter_monitoring = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("enter") && input_enter_monitoring == true:
		GlobalData.input_movement_monitoring = false
		GlobalData.fade_out()
		GlobalData.fade_out_completed.connect(start_interaction)
		encounter_sfx.play()

func _process(delta: float) -> void:
	if fade_in_active == true && label_deleted == false:
		var percent_completed = (label_timer.time_left / label_timer.wait_time)
		label.modulate = Color(1, 1, 1, 1.0 - percent_completed)
		if label.modulate == Color(1, 1, 1, 1):
			fade_in_active = false
	if fade_out_active == true && label_deleted == false:
		var percent_completed = (label_timer.time_left / label_timer.wait_time)
		label.modulate = Color(1, 1, 1, percent_completed)
		if label.modulate == Color(1, 1, 1, 0):
			fade_out_active = false

func stop_area_exited(useless_var, encounter_id):
	stop_id = encounter_id
	label = get_node(area_dict[stop_id]["node_name"]).get_child(2)
	label.modulate = Color(1, 1, 1, 1)
	label_timer.wait_time = label_fade_time
	fade_out_active = true
	label_timer.start()


func start_interaction():
	GlobalData.fade_out_completed.disconnect(start_interaction)
	
	if temp_stop_id_for_planets	!= null:
		stop_id = temp_stop_id_for_planets
	
	if area_dict[stop_id]["repeat_state"] == 1:
		get_node(area_dict[stop_id]["node_name"]).body_entered.disconnect(stop_area_entered)
		label.hide()
		input_enter_monitoring = false
	if area_dict[stop_id]["repeat_state"] == 2:
		get_node(area_dict[stop_id]["node_name"]).queue_free()
		label_deleted = true
	
	if "planet" in stop_id:
		temp_stop_id_for_planets = stop_id
		stop_id = "planet"	
	
	GlobalData.encounter_identifier = stop_id
	var interaction = interaction_scene.instantiate()
	gui_canvas_layer.add_child(interaction)
	GlobalData.input_movement_monitoring = false
	
