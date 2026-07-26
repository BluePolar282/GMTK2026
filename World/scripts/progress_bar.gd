extends ProgressBar

func _ready() -> void:
	max_value = Countdown.wait_time
	Countdown.stop()
	Countdown.start()

func _process(delta: float) -> void:
	value = Countdown.time_left
