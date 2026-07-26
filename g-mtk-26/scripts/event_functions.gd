extends Node

@export var space_scene = preload("res://scenes/space_scene.tscn")

func _ready() -> void:
	GlobalData.event_triggered.connect(event)

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
