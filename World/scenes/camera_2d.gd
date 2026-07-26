extends Camera2D

var shake_strength: float = 0.0
var shake_decay: float = 7.0

func _ready() -> void:
	Globals.shake_requested.connect(_on_shake_requested)

func _process(delta: float) -> void:
	if shake_strength > 0.0:
		shake_strength = lerp(shake_strength, 0.0, shake_decay * delta)
		offset = Vector2(
			randf_range(-1, 1) * shake_strength,
			randf_range(-1, 1) * shake_strength
		)
		if shake_strength < 0.05:
			shake_strength = 0.0
			offset = Vector2.ZERO

func _on_shake_requested(amount: float) -> void:
	shake_strength = amount
