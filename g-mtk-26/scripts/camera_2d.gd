extends Camera2D

var actual_cam_pos := Vector2.ZERO
var shader_material : ShaderMaterial


@export var player : CharacterBody2D

func _physics_process(delta: float) -> void:
	position = player.position
