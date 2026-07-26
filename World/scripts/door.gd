extends Area2D

var can_exit = false

func open_door():
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D.play("open")
	can_exit = true
	
func _on_body_entered(body: Node2D) -> void:
	if can_exit:
		if body.is_in_group("Player"):
			Globals.lost = false
			Globals.won = true
			get_tree().change_scene_to_file("res://UI/GameOver.tscn")

func _on_door_bar_open() -> void:
	open_door()
