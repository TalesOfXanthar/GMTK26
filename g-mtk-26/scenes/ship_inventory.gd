extends Node2D
class_name ShipInventory

func _ready() -> void:
	GlobalData.take_hit.connect(damage_item)
	damage_item()
	
func add_item(added_item : String):
	for item : Item in $ItemList.get_children():
		#if GlobalData.inventory[item.index_number].keys()[0] == "empty":
		if item.item_type == "empty":
			GlobalData.inventory[item.index_number] = ItemDescriptions[added_item]["template"].duplicate_deep
			item.item_type = added_item
			item.get_item_properties()
			break

func damage_item():
	var damage_candidates := []
	
	for item : Item in $ItemList.get_children():
		if item.item_type == "empty" or item.item_type == "thruster":
			damage_candidates.append(item)
			
	var chosen_item : Item = damage_candidates.pick_random()
	print(GlobalData.inventory[chosen_item.index_number])
	GlobalData.inventory[chosen_item.index_number][chosen_item.item_type]["damaged"] = true
	chosen_item.get_item_properties()
