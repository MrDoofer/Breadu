extends CharacterBody2D

const SPEED = 60.0
const JUMP_VELOCITY = -250.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var pause_menu = $"../Camera2D/Pause Menu"
@onready var DUST = preload("res://Scenes/dust.tscn")
@onready var animation_player: AnimatedSprite2D = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimationPlayer/AnimatedSprite2D
@onready var frustrated: AnimatedSprite2D = $AnimationPlayer/Frustrated
@onready var jump: AudioStreamPlayer2D = $Jump

var isGrounded = true
var frustrated_triggered := false

func _ready():
	frustrated.hide()

func _process(delta):
	# Add the gravity.
	if isGrounded == false and is_on_floor() == true:
		var instance = DUST.instantiate()
		instance.global_position = $Marker2D.global_position
		get_parent().add_child(instance)
	isGrounded = is_on_floor()

	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump.play()

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("Left", "Right")
	
	# Flip the Sprite
	if direction > 0:
		Global.playerFliped = false
		animation_player.flip_h = false
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		Global.playerFliped = true
		animation_player.flip_h = true
		animated_sprite_2d.flip_h = true

	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animation_player.play("default")
			animated_sprite_2d.play("default")
		else:
			animation_player.play("Walking")
			animated_sprite_2d.play("eys walking")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Frustrated animation logic: play once each time pickspawn fails

	# Frustrated animation logic (trigger-style)
	if Global.pickspawn_failed and not frustrated_triggered:
		frustrated.show()
		frustrated.play("Frustrated")
		frustrated_triggered = true
	elif frustrated_triggered and not frustrated.is_playing():
		frustrated.hide()
		frustrated_triggered = false
		Global.pickspawn_failed = false  # ✅ now it's safe to reset

	move_and_slide()

func _on_eyes_timeout() -> void:
	var total_dice_sides = 3
	animated_sprite_2d.frame = randi() % total_dice_sides
