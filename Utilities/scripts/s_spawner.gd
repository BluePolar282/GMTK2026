extends Node2D

var stabilizer = preload("res://items/scenes/stabilizer.tscn")
@export var spawn_area = Rect2(Vector2(-210, -200), Vector2(440, 240))
@onready var tilemap: TileMapLayer = get_tree().current_scene.get_node("MainCliffs") # adjust path

func _on_timer_timeout() -> void:
	var pos = get_valid_position()
	var rstabilizer = stabilizer.instantiate()
	rstabilizer.position = pos
	add_child(rstabilizer)

func get_valid_position() -> Vector2:
	var pos = Vector2.ZERO
	var tries = 0
	while tries < 50:
		pos = Vector2(
			randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
			randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
		)
		var cell = tilemap.local_to_map(tilemap.to_local(global_position + pos))
		var tile_data = tilemap.get_cell_tile_data(cell)
		if tile_data == null:
			return pos # empty cell = open air, safe to spawn
		tries += 1
	return pos
