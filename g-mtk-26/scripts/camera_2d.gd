extends Camera2D

var actual_cam_pos := Vector2.ZERO
var shader_material : ShaderMaterial


@export var player : CharacterBody2D

func _ready() -> void:
	shader_material = get_tree().get_nodes_in_group("nodes_with_shaders")[0].material

func _process(delta: float) -> void:
	actual_cam_pos = actual_cam_pos.lerp(player.global_position, delta * 3)
	
	var cam_subpixel_offset = actual_cam_pos.round() - actual_cam_pos
	
	shader_material.set_shader_parameter("cam_offset", cam_subpixel_offset)
	
	global_position = actual_cam_pos.round()
	
