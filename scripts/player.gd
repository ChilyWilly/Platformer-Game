extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const WALL_JUMP = -300
const Wall_SLIDE = 50
const WALL_JUMP_PUSH = 800
var double_jump = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	animations()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jumps.
	if Input.is_action_just_pressed("jump") and is_on_floor(): # Normal jump
		velocity.y = JUMP_VELOCITY
		double_jump = true
	
	elif Input.is_action_just_pressed("jump") and is_on_wall() and not is_on_floor(): # Wall jump
		velocity.y = JUMP_VELOCITY
		double_jump = true
		
		var wall_normal = get_wall_normal()
		velocity.x = wall_normal.x * WALL_JUMP_PUSH
		
	if Input.is_action_just_pressed("jump") and not is_on_floor() and not is_on_wall():
		if double_jump == true:
			velocity.y = JUMP_VELOCITY
			double_jump = false
		else: double_jump = false
	
	else:
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	move_and_slide()


func animations():
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Run, jump, or idle animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	elif is_on_wall():
		animated_sprite.play("wall_slide")
	elif not is_on_floor() and not is_on_wall() and double_jump == true:
		animated_sprite.play("jump")
	else:
		animated_sprite.play("double_jump")
	
