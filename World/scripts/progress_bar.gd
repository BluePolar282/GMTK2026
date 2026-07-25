extends ProgressBar


func _ready() -> void:
	max_value = Countdown.wait_time
	Countdown.time_changed.connect(_on_time_changed)

func _on_time_changed(time_remaining: float) -> void:
	value = time_remaining
