extends Node2D

@export var projectile_scene:= preload("res://World/scenes/meteor.tscn")
@export var spawn_rate:= 0.1  # seconds between spawns
@export var spawn_width:= 800.0  # horizontal spread
@export var fall_speed_min:= 300.0
@export var fall_speed_max:= 600.0

var timer:= 0.1

func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0.0:
		spawn_projectile()
		timer = spawn_rate

func spawn_projectile() -> void:
	var proj = projectile_scene.instantiate()
	get_parent().add_child(proj)
	proj.global_position = global_position + Vector2(randf_range(-400 / 2, 400 / 2), 0)
