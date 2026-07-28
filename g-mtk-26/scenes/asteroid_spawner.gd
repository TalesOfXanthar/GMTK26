extends Node2D

@export var player_ship : CharacterBody2D

@export var asteroid_scene : PackedScene

@export var belt_0_timer: Timer
@export var belt_1_timer: Timer
@export var belt_2_timer: Timer

var timers = [
	belt_0_timer,
	belt_1_timer,
	belt_2_timer,
]

var belt_dict = {
	"position": [
		[2085, 2130, 2175,],
		[2912, 2792, 2768,],
		[5248, 5120, 5169,],
	],
	"position_mod": [
		[-200, 10,],
		[-100, 20,],
		[-200, 20,],
	],
	"velocity_mod": [
		[-1, 1,],
		[-5, 5,],
		[-10, 10,],
	],
	"scale_mod": [
		[0.4, 1.1,], 
		[0.5, 2,],
		[0.6, 2.5,],
	],
	"timer": [
		[0.1, 0.8,],
		[0.15, 1.15,],
		[0.20, 1.20,],
	],
}

func _ready() -> void:
	belt_0_timer.timeout.connect(_on_asteroid_timer_timeout.bind(0))
	belt_0_timer.timeout.connect(_on_asteroid_timer_timeout.bind(1))
	belt_1_timer.timeout.connect(_on_asteroid_timer_timeout.bind(1))
	belt_0_timer.timeout.connect(_on_asteroid_timer_timeout.bind(2))
	belt_1_timer.timeout.connect(_on_asteroid_timer_timeout.bind(2))
	belt_2_timer.timeout.connect(_on_asteroid_timer_timeout.bind(2))


func _on_asteroid_timer_timeout(location : int):
	var asteroid : Asteroid = asteroid_scene.instantiate()
	asteroid.player_ship = player_ship
	asteroid.position = Vector2(belt_dict["position"][location].pick_random(), player_ship.position.y - 300)
	asteroid.position.x += randi_range(belt_dict["position_mod"][location][0], belt_dict["position_mod"][location][1])
	asteroid.linear_velocity = (Vector2(0,100 + randi_range(belt_dict["velocity_mod"][location][0], belt_dict["velocity_mod"][location][1])))
	
	var random_float = randf_range(belt_dict["scale_mod"][location][0], belt_dict["scale_mod"][location][1])
	var random_scale = Vector2(random_float, random_float)
	asteroid.scale = random_scale
	asteroid.sprite_node.scale = random_scale
	asteroid.collision_node.scale = random_scale
	
	add_child(asteroid)
	var timer : Timer = get("belt_" + str(location) + "_timer")
	timer.wait_time = randf_range(belt_dict["timer"][location][0], belt_dict["timer"][location][1])
