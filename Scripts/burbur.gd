extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var is_in_air : bool
# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var eyes: AnimatedSprite2D = $eyes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var pause_menu = $"../Camera2D/Pause Menu"
@onready var DUST = preload("res://Scenes/dust.tscn")
@onready var animated_sprite = $AnimatedSprite2D
var isGrounded = true
func _physics_process(delta):
	# Add the gravity.
	if isGrounded == false && is_on_floor() == true:
		var instance = DUST.instantiate()
		instance.global_position = $Marker2D.global_position
		get_parent().add_child(instance)
	isGrounded = is_on_floor()

	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("Left", "Right")
	
	# Flip the Sprite
	if direction > 0:
		eyes.flip_h = false
	elif direction < 0:
		eyes.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Walking")
#else:
		#animated_sprite.play("jump")
# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
