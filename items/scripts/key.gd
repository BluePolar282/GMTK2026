extends Area2D

@onready var main_cliffs: TileMapLayer = $"../MainCliffs"
@onready var door_bar: ProgressBar = $"Door Bar"

var velocity: Vector2 = Vector2.ZERO
var on_ground: bool = false

signal picked_up 

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$AudioStreamPlayer2D.play()
		picked_up.emit()
		$CPUParticles2D.emitting = true
		await get_tree().create_timer(0.2).timeout
		queue_free()



func _physics_process(delta: float) -> void:
	if ! on_ground:
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, 300)
	position += velocity * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ground"):
		velocity.y = 0
		on_ground = true
