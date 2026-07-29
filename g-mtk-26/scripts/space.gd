extends Node2D

@export var player_ship : CharacterBody2D
@export var star_background : TextureRect

func _process(_delta: float) -> void:
	star_background.position = (player_ship.position * 0.8).round()
