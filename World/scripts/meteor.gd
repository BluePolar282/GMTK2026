extends Area2D

var velocity: Vector2 = Vector2.ZERO
var has_hit_player := false
@onready var camera_2d: Camera2D = $CharacterBody2D/Camera2D

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
			$CPUParticles2D.emitting = true
		await get_tree().create_timer(0.2).timeout
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Meteor Bottom"):
		explode()
		
func explode():
	$AudioStreamPlayer2D.pitch_scale = randf_range(0.9, 1.1)
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D.visible = false
	$Sprite2D.visible = false
	$CPUParticles2D.emitting = true
	Globals.shake(0.2)
	await get_tree().create_timer(0.5).timeout
	queue_free()
	queue_free()
