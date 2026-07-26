extends Control

func _on_button_pressed() -> void:
	$AudioStreamPlayer2D.play()
	get_tree().change_scene_to_file("res://World/scenes/world.tscn")

func _on_button_2_pressed() -> void:
	$AudioStreamPlayer2D.play()
	get_tree().change_scene_to_file("res://UI/tutorial.tscn")
