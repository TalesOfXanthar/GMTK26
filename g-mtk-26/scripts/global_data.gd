extends Node

signal event_triggered(event_type)

signal take_hit

# ----- Section for variables about starting/ending the game -----

signal win
signal game_started

# ----- -----
var input_movement_monitoring := true

var encounter_identifier : String
var random_identifier : String

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

var repair_item := false

var engine_overheat := 0.0



var inventory = [
		{"fuel_canister": 5},
		{"repair_scrap":":)"},
		{"empty": {"damaged":false}},
		{"locked": null},
		{"locked": null},
		{"fuel_canister": 5},
		{"fuel_canister": 5},
		{"empty": {"damaged":false}},
		{"locked": null},
		{"empty": {"damaged":false}},
		{"empty": {"damaged":false}},
		{"empty": {"damaged":false}},
		{"thruster":{"damaged": false}},
		{"empty": {"damaged":false}},
		{"empty": {"damaged":false}},
		{"locked": null},
	]


var total_fuel : float = 0.0
var current_fuel : float = 0.0

func _ready() -> void:
	
	for item in GlobalData.inventory:
		if item.keys()[0] == "fuel_canister":
			total_fuel += 5
			current_fuel += item["fuel_canister"]
	
	
	item_attached_sprite = Sprite2D.new()
	if get_node("/root/SceneManager/FadeLayer") != null:
		get_node("/root/SceneManager/FadeLayer").add_child(item_attached_sprite)
	item_attached_sprite.hide()
	item_attached_sprite.top_level = true
	
func _input(_event: InputEvent) -> void:
	if is_item_attached == true:
		item_attached_sprite.position = get_viewport().get_mouse_position()
		item_attached_sprite.z_index = 10
		item_attached_sprite.top_level = true
		if Input.is_action_just_released("mouse_left_click"):
			is_item_attached = false
			item_attached_sprite.hide()
			#GlobalData.item_hovering_over = GlobalData.inventory[index_number].duplicate_deep()
			for item : Item in get_node("/root/SceneManager/SpaceLayer/Space/ItemShipLayer/ShipInventory/ItemList").get_children():
				if item.mouse_hovering:
					repair_item = false
					item_hovering_over = inventory[item.index_number].duplicate_deep()
					failed_to_find_item = false
					if item.is_damaged && item_attached.keys()[0] == "repair_scrap":
						failed_to_find_item = true
						repair_item = true
					elif item.is_damaged && item.item_type == "empty":	
						failed_to_find_item = true
						
					
					break
				else:
					failed_to_find_item = true
			dropped_item.emit()
			item_attached_sprite.top_level = false
