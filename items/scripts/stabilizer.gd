extends Area2D


@onready var main_cliffs: TileMapLayer = $"../MainCliffs"

var velocity: Vector2 = Vector2.ZERO
var on_ground: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		boost_countdown()
		queue_free()

func boost_countdown():
	Countdown.start(Countdown.time_left + 3)
	if Countdown.time_left > 60:
		Countdown.set_wait_time(60)
		Countdown.start()

func _physics_process(delta: float) -> void:
	if ! on_ground:
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, 300)
	position += velocity * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ground"):
		velocity.y = 0
		on_ground = true
