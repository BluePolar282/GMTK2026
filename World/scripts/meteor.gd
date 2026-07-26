extends Area2D

var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, 150)
	position += velocity * delta


func _on_despawn_timer_timeout() -> void:
	queue_free()
