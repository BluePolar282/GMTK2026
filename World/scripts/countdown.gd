extends Timer

signal time_changed(time_remaining: float)

func _ready() -> void:
	wait_time = 60

func _process(_delta: float) -> void:
	if not is_stopped():
		time_changed.emit(time_left)

func add_time(extra: float) -> void:
	var new_time: float = time_left + extra
	stop()
	start(new_time)
	time_changed.emit(new_time)



	
