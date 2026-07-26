extends Node

@export var space_scene = preload("res://scenes/space_scene.tscn")

var ship_inv : ShipInventory

func _ready() -> void:
	GlobalData.event_triggered.connect(event)
	ship_inv = get_node("/root/SceneManager/SpaceScene/ItemShipLayer/ShipInventory")

func event(event_name):
	var event_callable := Callable.create(self, event_name)
	event_callable.call()

func nothing():
	pass

func restart():
	GlobalData.fade_out_completed.connect(restart_afterfade)

func restart_afterfade():
	GlobalData.fade_out_completed.disconnect(restart_afterfade)
	GlobalData.fade_in()
	get_node("/root/SceneManager/SpaceScene").queue_free()
	GlobalData.input_movement_monitoring = true
	get_node("/root/SceneManager").add_child(space_scene.instantiate())
	
func reset_heat():
	GlobalData.engine_overheat = 0.0

func reset_heat_thruster():
	GlobalData.engine_overheat = 0.0
	ship_inv.add_item("thruster")

func lose_fuel_add_translator():
	ship_inv.add_item("translator")
	GlobalData.current_fuel -= 1

func damage():
	GlobalData.take_hit.emit()

func lose_fuel_medium_add_scrap():
	GlobalData.current_fuel -= 2
	ship_inv.add_item("repair_scrap")

func lose_fuel_gain_scrap_damage():
	GlobalData.current_fuel -= 1
	ship_inv.add_item("repair_scrap")
	GlobalData.take_hit.emit()

func lose_fuel_add_scrap():
	GlobalData.current_fuel -= 1
	ship_inv.add_item("repair_scrap")

func lose_fuel_small():
	GlobalData.current_fuel -= 1
