extends CharacterBody2D


var SPEED = 200.0

var JUMP_VELOCITY = -300.0
var double_jump = false
var double_unlocked = true
var has_gravity: = true

const WALL_JUMP = -300
const WALL_JUMP_PUSH = 800
var debug_on = false

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func debug():
	if Input.is_action_just_pressed("debug"):
		debug_on = not debug_on
	
	if debug_on:
		collision_shape.disabled = true
		has_gravity = false
		animated_sprite.modulate = Color.BLACK
		var vertical := Input.get_axis("up", "down")
		if vertical:
			velocity.y = vertical * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	else:
		has_gravity = true
		collision_shape.disabled = false
		animated_sprite.modulate = Color.WHITE

func _physics_process(delta: float) -> void:
	animations()
	
	if is_on_floor():
		double_jump = true
	
	# Add the gravity.
	if not is_on_floor() and has_gravity:
		velocity += get_gravity() * delta
	
	# Handle jumps.
	if Input.is_action_just_pressed("jump") and is_on_floor(): # Normal jump
		velocity.y = JUMP_VELOCITY
		if double_unlocked == true:
			double_jump = true
	
	elif Input.is_action_just_pressed("jump") and is_on_wall() and not is_on_floor(): # Wall jump
		velocity.y = JUMP_VELOCITY
		if double_unlocked == true:
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

	debug()
	
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
	
