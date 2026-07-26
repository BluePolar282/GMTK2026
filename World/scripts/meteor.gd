extends Area2D

var velocity: Vector2 = Vector2.ZERO
var has_hit_player := false

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, 150)
	position += velocity * delta

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not has_hit_player and body.is_in_group("Player"):
		has_hit_player = true
		if body.has_method("take_damage"):
			body.take_damage(1)
		queue_free()
