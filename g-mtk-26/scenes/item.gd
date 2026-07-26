extends Control

## The INDEX number to retrive the item from the list. (Starts from 0)
@export var index_number : int
var item_type : String

var moveable : bool
var mouse_hovering = false
var being_hovered_over = false

@export var rect : ColorRect
@export var highlight_rect : ColorRect
@export var area : Area2D
@export var item_sprite : Sprite2D



func _ready() -> void:
	area.mouse_entered.connect(mouse_entered)
	area.mouse_exited.connect(mouse_exited)
	area.area_entered.connect(another_area_entered_this_one)
	area.area_exited.connect(another_area_exited_this_one)
	
	item_type = GlobalData.inventory[index_number].keys()[0]
	item_sprite.texture = load(ItemDescriptions.item_desc[item_type]["sprite"])
	if item_type == "locked":
		rect.visible = false
	
	get_item_properties()
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse_left_click") && mouse_hovering && moveable:
		GlobalData.item_attached = GlobalData.inventory[index_number]
		GlobalData.is_item_attached = true
		GlobalData.item_attached_sprite.texture = load(ItemDescriptions.item_desc[item_type]["sprite"])
		GlobalData.item_attached_sprite.show()

func get_item_properties():
	moveable = ItemDescriptions.item_desc[item_type]["moveable"]
	
func mouse_entered():
	mouse_hovering = true
	highlight_rect.show()
	# make a timer that if it reaches 1 second without mouse exiting, show info
	
func mouse_exited():
	mouse_hovering = false
	highlight_rect.hide()
	
func another_area_entered_this_one(useless_var):
	GlobalData.item_hovering_over = GlobalData.inventory[index_number]
	being_hovered_over = true

func another_area_exited_this_one(useless_var):
	being_hovered_over = false

func dropped_item():
	if being_hovered_over == true:
		
		GlobalData.inventory[index_number] = GlobalData.item_attached
