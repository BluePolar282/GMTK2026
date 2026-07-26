extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var robot: CharacterBody2D = $".."

func _process(delta: float) -> void:
	if robot.dashing:
		if (get_tree().get_frame() % 3) == 0:
			print("trail")
			var newSprite : AnimatedSprite2D = animated_sprite_2d.duplicate()
			newSprite.stop()
			newSprite.z_index = 0
			get_tree().root.add_child(newSprite)
			newSprite.global_position = robot.global_position
			newSprite.StartFading()
