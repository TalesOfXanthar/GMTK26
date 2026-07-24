extends CharacterBody2D
var rotation_velocity := 0.0

func _physics_process(delta: float) -> void:
	var rotation_direction := 0.0
	var movement_direction := 0.0
	
	rotation_direction = Input.get_axis("rotate_counterclockwise", "rotate_clockwise")
	if rotation_direction != 0.0:	
		rotation_velocity += lerpf(rotation_velocity, rotation_direction * 0.05, 0.04)
		rotation_velocity = clampf(rotation_velocity, -0.07, 0.07)
	else:
		rotation_velocity = 0
	rotation += rotation_velocity

	movement_direction = Input.get_axis("move_backwards", "move_forward")
	if movement_direction != 0.0:
		var movement_vector = transform.x * movement_direction * 60
		velocity = velocity.move_toward(movement_vector, 5)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, 0.5)
		
	move_and_slide()
