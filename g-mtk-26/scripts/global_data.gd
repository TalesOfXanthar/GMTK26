extends Node

signal event_triggered(event_type)

signal fade_out_completed

var input_movement_monitoring := true

var encounter_identifier : String

signal stop_countdown
signal start_countdown

signal dropped_item

## Determines whether mouse has Sprite2D that follows.
var is_item_attached := false
## The item that you are dragging around.
var item_attached : Dictionary
## The item that you are currently hovering over.
var item_hovering_over : Dictionary

var item_attached_sprite : Sprite2D
## Confirms whether an item was taken from its slot where it was after
## being placed on the item that you were hovering over.
var confirmed_took_item = false

var failed_to_find_item := true

var engine_overheat := 0.0



var inventory = [
		{"fuel_canister": 5},
		{"empty": null},
		{"empty": null},
		{"locked": null},
		{"locked": null},
		{"empty": null},
		{"empty": null},
		{"empty": null},
		{"locked": null},
		{"empty": null},
		{"empty": null},
		{"empty": null},
		{"thruster":{"damaged": false}},
		{"empty": null},
		{"empty": null},
		{"locked": null},
	]


var total_fuel : float = 0.0
var current_fuel : float = 0.0

var fade_in_rect : ColorRect
var fade_out_rect : ColorRect
var timer : Timer
var fade_time := 1.0
var fade_in_active := false
var fade_out_active := false

func _ready() -> void:
	item_attached_sprite = Sprite2D.new()
	get_node("/root/SceneManager/FadeLayer").add_child(item_attached_sprite)
	item_attached_sprite.hide()
	item_attached_sprite.top_level = true
	
func _input(event: InputEvent) -> void:
	if is_item_attached == true:
		item_attached_sprite.position = get_viewport().get_mouse_position()
		item_attached_sprite.z_index = 10
		item_attached_sprite.top_level = true
		if Input.is_action_just_released("mouse_left_click"):
			print("3")
			is_item_attached = false
			item_attached_sprite.hide()
			#GlobalData.item_hovering_over = GlobalData.inventory[index_number].duplicate_deep()
			for item:Item in get_node("/root/SceneManager/SpaceScene/ItemShipLayer/ShipInventory/ItemList").get_children():
				if item.mouse_hovering:
					item_hovering_over = inventory[item.index_number].duplicate_deep()
					failed_to_find_item = false
					break
				else:
					failed_to_find_item = true
			print("4")
			dropped_item.emit()
			item_attached_sprite.top_level = false

func _process(delta: float) -> void:
	if fade_in_active == true:	
		var percent_completed = 1.0 - (timer.time_left / timer.wait_time)
		fade_in_rect.color = Color(0, 0, 0, 1 - percent_completed)
	if fade_out_active == true:	
		var percent_completed = 1.0 - (timer.time_left / timer.wait_time)
		fade_out_rect.color = Color(0, 0, 0, percent_completed)
	
	

func fade_timeout():
	timer.timeout.disconnect(fade_timeout)
	if fade_in_active == true:
		fade_in_active = false
		fade_in_rect.hide()
	if fade_out_active == true:
		fade_out_active = false
		fade_out_completed.emit()
		fade_out_rect.hide()
		fade_in()

func fade_in():
	fade_in_rect = get_node("/root/SceneManager/FadeLayer/FadeInRect")
	fade_in_rect.color = Color(0, 0, 0, 1)
	fade_in_rect.show()
	timer = get_node("/root/SceneManager/FadeLayer/FadeTimer")
	timer.timeout.connect(fade_timeout)
	timer.wait_time = fade_time
	fade_in_active = true
	timer.start()

func fade_out():
	fade_out_rect = get_node("/root/SceneManager/FadeLayer/FadeOutRect")
	fade_out_rect.color = Color(0, 0, 0, 0)
	fade_out_rect.show()
	timer = get_node("/root/SceneManager/FadeLayer/FadeTimer")
	timer.timeout.connect(fade_timeout)
	timer.wait_time = fade_time
	fade_out_active = true
	timer.start()
	
	
