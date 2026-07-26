extends Node2D


@export var asteroid_scene : PackedScene

@export var belt_1_timer: Timer
@export var belt_2_timer: Timer
@export var belt_3_timer: Timer

var spawn_cords_belt_1 = [
	Vector2(2085, 0),
	Vector2(2130, 0),
	Vector2(2175, 0),
]

var spawn_cords_belt_2 = [
	Vector2(2912, 0),
	Vector2(2792, 0),
	Vector2(2768, 0),
]

func _ready() -> void:
	belt_1_timer.timeout.connect(_on_asteroid_timer_timeout1)
	belt_1_timer.timeout.connect(_on_asteroid_timer_timeout2)
	belt_2_timer.timeout.connect(_on_asteroid_timer_timeout2)
	belt_1_timer.timeout.connect(_on_asteroid_timer_timeout3)
	belt_2_timer.timeout.connect(_on_asteroid_timer_timeout3)
	belt_3_timer.timeout.connect(_on_asteroid_timer_timeout3)

func _on_asteroid_timer_timeout1():
	var asteroid : RigidBody2D = asteroid_scene.instantiate()
	asteroid.position = spawn_cords_belt_1.pick_random()
	asteroid.position.x += randi_range(-40, 10)
	asteroid.linear_velocity = (Vector2(0,100))
	add_child(asteroid)
	belt_1_timer.wait_time = randf() + 0.1
	
func _on_asteroid_timer_timeout2():
	var asteroid : RigidBody2D = asteroid_scene.instantiate()
	asteroid.position = spawn_cords_belt_2.pick_random()
	asteroid.position.x += randi_range(-100, 20)
	asteroid.linear_velocity = (Vector2(0,100 + randi_range(-1, 1)))
	add_child(asteroid)
	belt_2_timer.wait_time = randf() + 0.15

func _on_asteroid_timer_timeout3():
	var asteroid : RigidBody2D = asteroid_scene.instantiate()
	asteroid.position = spawn_cords_belt_2.pick_random()
	asteroid.position.x += randi_range(-200, 20)
	asteroid.linear_velocity = (Vector2(0,100 + randi_range(-1, 1)))
	add_child(asteroid)
	belt_2_timer.wait_time = randf() + 0.20
