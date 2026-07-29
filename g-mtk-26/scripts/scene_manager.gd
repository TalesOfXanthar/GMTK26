extends Node

@export var main_menu_scene : PackedScene
@export var space_scene : PackedScene
 
@export var main_menu_layer : CanvasLayer
@export var space_layer : CanvasLayer

@export var main_menu : Control
var space : Control

func _ready() -> void:
	main_menu.trigger_start.connect(game_start_fade_in)

func game_start_fade_in() -> void:
	Fader.fade_out_completed.connect(game_start)
	Fader.fade_out()
	

func game_start():
	Fader.fade_out_completed.disconnect(game_start)
	Fader.fade_in()
	
	space = space_scene.instantiate()
	space_layer.add_child(space)
	
	main_menu.queue_free()
	
	GlobalData.game_started.emit()
	
func to_title():
	main_menu = main_menu_scene.instantiate()
	main_menu_layer.add_child(main_menu)
	
	space.queue_free()
	
	
	
