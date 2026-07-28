extends Node2D

@export var fuel_label : RichTextLabel
@export var engine_heat_label : RichTextLabel
@export var resource_ship_layer : CanvasLayer

var in_sight_position = Vector2(256, 0)
var out_of_sight_position = Vector2(384, 0)
var move_rate = 4
var is_being_shown = false

func _input(event: InputEvent) -> void:
	if event.is_action("tab"):
		is_being_shown = true
	if event.is_action_released("tab"):
		is_being_shown = false

func _process(_delta: float) -> void:
	var modulate_rate = (move_rate * 2) / 100.0
	if is_being_shown == true:	
		position = position.move_toward(in_sight_position, move_rate)
		if modulate.a < 1.0:	
			modulate.a += modulate_rate
	else:
		position = position.move_toward(out_of_sight_position, move_rate)
		if modulate.a > 0.0:	
			modulate.a -= modulate_rate
	
	var max_fuel := 0.0
	var current_fuel := 0.0
	
	for item in GlobalData.inventory:
		if item.keys()[0] == "fuel_canister":
			max_fuel += 5
			current_fuel += item["fuel_canister"]
	var percentage_max_fuel : float
	if current_fuel <= 0:	
		percentage_max_fuel = 0
	else:
		percentage_max_fuel = 100 * (GlobalData.current_fuel / GlobalData.total_fuel)
	
	
	
	fuel_label.text = "Fuel: " + str(snapped(GlobalData.current_fuel, 0.01)) + " (" + str(snapped(percentage_max_fuel, 1)) + "% Max)"
	engine_heat_label.text = "Engine Overheat: " + str(snapped(GlobalData.engine_overheat, 0.01)) + "%"
