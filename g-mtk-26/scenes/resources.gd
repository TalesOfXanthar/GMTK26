extends Node

@export var resource_text : RichTextLabel
@export var resource_ship_layer : CanvasLayer

func _input(event: InputEvent) -> void:
	if event.is_action("tab"):
		resource_ship_layer.show()
	if event.is_action_released("tab"):
		resource_ship_layer.hide()

func _process(delta: float) -> void:
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
	
	
	
	resource_text.text = "Fuel: " + str(snapped(GlobalData.current_fuel, 0.01)) + " (" + str(snapped(percentage_max_fuel, 1)) + "% Max)
Engine Overheat: " + str(snapped(GlobalData.engine_overheat, 0.01)) + "%"
