extends RigidBody2D



func _on_body_entered(body: Node) -> void:
	GlobalData.take_hit.emit()
	
func _process(delta: float) -> void:
	if position.y > 4000:
		queue_free()
