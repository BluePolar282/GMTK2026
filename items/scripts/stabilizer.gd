extends Area2D

var Countdown = 1

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Countdown.add_time(5)
		queue_free()
