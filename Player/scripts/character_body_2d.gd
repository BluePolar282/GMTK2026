extends CharacterBody2D

enum STATE { 
	FALL,
	FLOOR, 
	JUMP, 
	DJUMP,
	DASH,
	}

const SPEED = 145
const ACCEL = 800
const FRICTION = 650

const GRAVITY = 580
const FALL_SPEED = 300

const JUMP_SPEED = -240
const JUMP_DECEL = 850
const JUMP_STOP = 7000
const DJUMP_SPEED = -240

const DASH_SPEED = 550
const DASH_DECEL = 10000

const MAX_HEALTH = 5

var active_state := STATE.FLOOR
var playing_anim := false
var can_DJump := false
var can_dash := false
var saved_position := Vector2.ZERO
var current_dir = 1
var health := MAX_HEALTH

signal died

func _ready() -> void:
	switch_state(STATE.FLOOR)
	add_to_group("Player")
 
func _physics_process(delta: float) -> void:
	process_state(delta)
	move_and_slide()
	
func movement(delta: float, input_dir: float = 0) -> void:
	if input_dir == 0:
		input_dir = signf(Input.get_axis("Left", "Right"))
	var target_speed = input_dir * SPEED

	if input_dir != 0:
		current_dir = input_dir
		velocity.x = move_toward(velocity.x, target_speed, ACCEL * get_process_delta_time())
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * get_process_delta_time())
 
 
func switch_state(to_state: STATE) -> void:
	var sprite = $AnimatedSprite2D
	
	var previous_state := active_state
	active_state = to_state
	# State-entry actions (run once when a state is entered)
	match active_state:
		
		STATE.FALL:
			if previous_state != STATE.DJUMP:
				sprite.play("fall")
			if previous_state == STATE.FLOOR:
				$CoyoteTimer.start()
		STATE.FLOOR:
			can_DJump = true
			can_dash = true
		STATE.JUMP:
			$jump.play()
			sprite.play("jump")
			velocity.y = JUMP_SPEED
			$CoyoteTimer.stop()
			$JumpBuffer.stop()
			
		STATE.DJUMP:
			$jump.play()
			sprite.play("djump")
			velocity.y = DJUMP_SPEED
			can_DJump = false
			await sprite.animation_finished
			sprite.play("fall")
		
		STATE.DASH:
			$dash.play()
			sprite.play("dash")
			velocity.y = 0
			velocity.x = DASH_SPEED * current_dir
			
func process_state(delta: float) -> void:
	var sprite = $AnimatedSprite2D

	match active_state:
		STATE.FALL:
			velocity.y = move_toward(velocity.y, FALL_SPEED, GRAVITY * delta)
			movement(delta)
 
			if is_on_floor():
				switch_state(STATE.FLOOR)
				
			if Input.is_action_just_pressed("Jump"):
				if $CoyoteTimer.time_left > 0:
					switch_state(STATE.JUMP)
				elif can_DJump:
					switch_state(STATE.DJUMP)
				else:
					$JumpBuffer.start()
					
			if Input.is_action_just_pressed("Dash"):
				switch_state(STATE.DASH)
				
					
		STATE.FLOOR:
			if $JumpBuffer.time_left > 0:
				switch_state(STATE.JUMP)
				
			if Input.get_axis("Left", "Right"):
				sprite.play("run")
				playing_anim = false
			elif not playing_anim:
				sprite.play("idle")
			
			if Input.is_action_just_pressed("Dash"):
				switch_state(STATE.DASH)
				
			movement(delta)
 
			if not is_on_floor():
				switch_state(STATE.FALL)
			elif Input.is_action_just_pressed("Jump"):
				switch_state(STATE.JUMP)
 
		STATE.JUMP, STATE.DJUMP:
			velocity.y = move_toward(velocity.y, 0, JUMP_DECEL * delta)
			if Input.is_action_just_released("Jump") or velocity.y >= 0:
				velocity.y = move_toward(velocity.y, 0, JUMP_STOP * delta)
				switch_state(STATE.FALL)
			if Input.is_action_just_pressed("Dash"):
				switch_state(STATE.DASH)
			movement(delta)
			
		STATE.DASH:
			velocity.x = move_toward(velocity.x, 0, DASH_DECEL * delta)
			switch_state(STATE.FALL)

func take_damage(amount: int = 1) -> void:
	$hurt.play()
	health -= amount
	health = max(0, health)
	$HealthBar.visible = true
	self.modulate = Color(100, 100, 100)
	await get_tree().create_timer(0.1).timeout
	self.modulate = Color(1, 1, 1)
	Globals.shake(2.5)
	if health > 0:
		await get_tree().create_timer(2).timeout
		$HealthBar.visible = false
	else:
		on_player_death()

func on_player_death() -> void:
	print("Game Over!")
	Globals.won = false
	Globals.lost = true
	get_tree().change_scene_to_file("res://UI/GameOver.tscn")
