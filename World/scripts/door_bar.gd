extends ProgressBar

signal open

func _process(delta: float) -> void:
	for key in get_tree().get_nodes_in_group("keys"):
		key.picked_up.connect(_on_key_picked_up)

func _on_key_picked_up() -> void:
	value += 1
	print(value)
	if value > 4:
		open.emit()
		print("progress_open")
