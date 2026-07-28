extends RigidBody2D
class_name Asteroid

@export var collision_node : CollisionShape2D
@export var sprite_node : Sprite2D
var player_ship : CharacterBody2D


func _on_body_entered(body: Node) -> void:
	GlobalData.take_hit.emit()
	
func _process(delta: float) -> void:
	if position.y > player_ship.position.y + 300:
		queue_free()
