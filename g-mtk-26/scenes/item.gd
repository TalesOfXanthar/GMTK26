extends Control
class_name Item


## The INDEX number to retrive the item from the list. (Starts from 0)
@export var index_number : int
var item_type : String

var moveable : bool
var mouse_hovering = false
var being_hovered_over = false
var is_the_item_hovering_over_others = false
var backup_store : Dictionary

@export var rect : ColorRect
@export var highlight_rect : ColorRect
@export var area : Area2D
@export var item_sprite : Sprite2D


func _ready() -> void:
	area.mouse_entered.connect(mouse_entered)
	area.mouse_exited.connect(mouse_exited)
	GlobalData.dropped_item.connect(dropped_item_was_called)
	
	item_type = GlobalData.inventory[index_number].keys()[0]
	if item_type == "locked":
		rect.visible = false
	
	get_item_properties()

func _input(event: InputEvent) -> void:
	if mouse_hovering == true:	
		if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			
			GlobalData.item_attached = GlobalData.inventory[index_number].duplicate_deep()
			print("1")
			
			
			GlobalData.is_item_attached = true
			GlobalData.item_attached_sprite.texture = load(ItemDescriptions.item_desc[item_type]["sprite"])
			GlobalData.item_attached_sprite.show()
			
			GlobalData.inventory[index_number] = ItemDescriptions.item_desc["empty"]["template"]
			get_item_properties()
			print("2")
			
			is_the_item_hovering_over_others = true
			GlobalData.confirmed_took_item = false

func get_item_properties():
	item_type = GlobalData.inventory[index_number].keys()[0]
	if item_type == "locked":
		rect.visible = false
	item_sprite.texture = load(ItemDescriptions.item_desc[item_type]["sprite"])
	moveable = ItemDescriptions.item_desc[item_type]["moveable"]
	
func mouse_entered():
	mouse_hovering = true
	highlight_rect.show()
	# make a timer that if it reaches 1 second without mouse exiting, show info
	
func mouse_exited():
	mouse_hovering = false
	highlight_rect.hide()

func dropped_item_was_called():
	if mouse_hovering == true:
		is_the_item_hovering_over_others = false
		GlobalData.inventory[index_number] = GlobalData.item_attached.duplicate_deep()
		print("5")
	elif is_the_item_hovering_over_others == true:
		is_the_item_hovering_over_others = false
		if GlobalData.failed_to_find_item == true:
			GlobalData.inventory[index_number] = GlobalData.item_attached.duplicate_deep()
			print("failed_to_find")
		else:
			GlobalData.inventory[index_number] = GlobalData.item_hovering_over.duplicate()
		print("6")
	get_item_properties()
