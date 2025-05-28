extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
var Loaf1 = false
var interactable = true
func _on_body_entered(body):
	Loaf1 =true
	interactable =true

func _on_body_exited(body):
	Loaf1 = false
	interactable = false

func _process(delta):
	if Loaf1 and Input.is_action_pressed("Interact"):
		animated_sprite_2d.play("Cut")
	
		interactable =false
