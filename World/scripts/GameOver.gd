extends Control

func _ready() -> void:
	if Globals.won:
		$Panel/Label.text = "You Win!"
	elif Globals.lost:
		$Panel/Label.text = "Game Over"
	
	$Panel/RetryButton.pressed.connect(_on_retry_pressed)
	$Panel/MenuButton.pressed.connect(_on_menu_pressed)

func show_game_over() -> void:
	show()
	get_tree().paused = true

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://World/scenes/world.tscn")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")  # replace with your menu scene path
