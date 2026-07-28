extends Control

signal trigger_start

@export var star_background : TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	star_background.position = star_background.position.move_toward(Vector2(-384, -216), 0.1)
	if star_background.position == Vector2(-384, -216):
		star_background.position = Vector2.ZERO


func _on_credits_pressed() -> void:
	$ColorRect.show()	


func _on_exit_credits_pressed() -> void:
	$ColorRect.hide()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	trigger_start.emit()
