extends Control

func _ready() -> void:
	if Globals.won:
		print("You Win!")
		$Camera2D/OutcomeLabel.text = "You Win!"
	else:
		print("You loose!")
		$Camera2D/OutcomeLabel.text = "Game Over"
	
	$Camera2D/RetryButton.pressed.connect(_on_retry_pressed)
	$Camera2D/MenuButton.pressed.connect(_on_menu_pressed)

func show_game_over() -> void:
	show()
	get_tree().paused = true

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://World/scenes/world.tscn")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")
