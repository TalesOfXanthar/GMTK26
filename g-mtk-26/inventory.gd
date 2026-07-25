extends GridContainer

var breach_avoidant
var eats_food
var movable
var tile_state
var state_json := {
		"none": {
		"properties": [],
		"movable": true,
		  },
	"person": {
		"properties": [breach_avoidant, eats_food],
		"movable": true,
		  }
}

var cursor_state := "none"

func on_tile_click(tile):
	if state_json[cursor_state]["movable"] == true && tile.tile_state == "none":
		tile.tile_state = cursor_state
		cursor_state = "none"
		print("if")
	elif state_json[cursor_state]["movable"] == true:
		cursor_state = tile_state
		tile_state = "none"
		print("elif")
	if tile.pressed:
		print("Button")
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	on_tile_click($tile_1)

#func hideSlot(node):
	#node.disabled = true
	#node.flat = true
	#node.text = ""
	#
#func setSlot(node, type, image):
	#node.text = type
	#node.icon = image
	#
#
