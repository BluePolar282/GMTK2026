extends Area2D

var can_exit = false

func open_door():
	$AnimatedSprite2D.play("open")
	can_exit = true
	
func _on_body_entered(body: Node2D) -> void:
	if can_exit:
		if body.is_in_group("Player"):
			print("yay")
			
func _on_door_bar_open() -> void:
	open_door()
