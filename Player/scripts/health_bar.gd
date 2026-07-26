extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Find the player in he scene
	var player = get_tree().get_first_node_in_group("Player")
	
	if player:
		max_value = player.MAX_HEALTH
		value = player.health
		print(value)
		# Update the bar whenever health changes
		get_tree().process_frame.connect(_update_display.bind(player))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		value = player.health

func _update_display(player: Node) -> void:
	if player:
		max_value = player.MAX_HEALTH
		value = player.health
