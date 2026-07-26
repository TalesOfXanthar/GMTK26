extends CharacterBody2D
var rotation_velocity := 0.0
var unrounded_position : Vector2


func _ready() -> void:
	unrounded_position = position
	
func _physics_process(delta: float) -> void:
	var rotation_direction := 0.0
	var movement_direction := 0.0
	if GlobalData.input_movement_monitoring:
		rotation_direction = Input.get_axis("rotate_counterclockwise", "rotate_clockwise")
		movement_direction = Input.get_axis("move_backwards", "move_forward")
	
	if rotation_direction != 0.0:	
		rotation_velocity += lerpf(rotation_velocity, (rotation_direction*PI/360), (5.625*PI)/360)
		rotation_velocity = clampf(rotation_velocity, -(11.25*PI)/360, (11.25*PI)/360)
		
		GlobalData.engine_overheat += 0.002
		for item in GlobalData.inventory:
			if item.keys()[0] == "fuel_canister":
				item["fuel_canister"] -= 0.002
				break
	else:
		rotation_velocity = 0
	rotation += rotation_velocity

	if movement_direction != 0.0:
		var movement_vector = transform.x * movement_direction * 40
		velocity = velocity.move_toward(movement_vector, 5)
		
		GlobalData.engine_overheat += 0.002
		for item in GlobalData.inventory:
			if item.keys()[0] == "fuel_canister":
				item["fuel_canister"] -= 0.002
				break
	else:
		velocity = velocity.move_toward(Vector2.ZERO, 1)
	
	move_and_slide()
	unrounded_position += velocity * delta
	if get_slide_collision_count() == 0:	
		position = unrounded_position.round()
	
	
	unrounded_position = unrounded_position.clamp(position - Vector2.ONE, position + Vector2.ONE)
	
