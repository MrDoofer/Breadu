extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
var playerInteracting = false
func _on_body_entered(body):
	playerInteracting =true

func _on_body_exited(body):
	playerInteracting = false

func _process(delta):
	if playerInteracting and Input.is_action_pressed("Interact"):
		animated_sprite_2d.play("Cut")
