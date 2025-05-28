extends Node2D
var touched = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var e: Sprite2D = $E

func _ready():
	await get_tree().process_frame
	e.hide()
	e.global_position = Vector2(160,170)
	animated_sprite_2d.play("default")
func _on_area_2d_body_entered(body: Node2D):
	touched = true
	e.show()

func _on_area_2d_body_exited(body: Node2D):
	touched = false
	e.hide()
func _process(delta: float):
	if touched == true:
		e.show()
	if touched == true and Input.is_action_just_pressed("Interact"):
		animated_sprite_2d.play("Cracked")
		area_2d.queue_free()
