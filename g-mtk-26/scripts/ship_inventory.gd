extends Node2D
class_name ShipInventory

var is_being_shown = false

var in_sight_position = Vector2.ZERO
var out_of_sight_position = Vector2(-128, 0)
var move_rate = 4

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shift"):
		if is_being_shown == true:
			is_being_shown = false
		else:
			is_being_shown = true

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

func _ready() -> void:
	GlobalData.take_hit.connect(damage_item)
	damage_item()
	
func add_item(added_item : String):
	for item : Item in $ItemList.get_children():
		#if GlobalData.inventory[item.index_number].keys()[0] == "empty":
		if item.item_type == "empty":
			GlobalData.inventory[item.index_number] = ItemDescriptions.item_desc[added_item]["template"].duplicate_deep()
			item.item_type = added_item
			item.get_item_properties()
			break

func damage_item():
	var damage_candidates := []
	
	for item : Item in $ItemList.get_children():
		if item.item_type == "empty" or item.item_type == "thruster":
			if GlobalData.inventory[item.index_number][item.item_type]["damaged"] == false:
				damage_candidates.append(item)
			
	var chosen_item : Item = damage_candidates.pick_random()
	print(GlobalData.inventory[chosen_item.index_number])
	GlobalData.inventory[chosen_item.index_number][chosen_item.item_type]["damaged"] = true
	chosen_item.get_item_properties()
