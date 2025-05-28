extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
var geode = false
func _on_body_entered():
	geode =true
func _on_body_exited():
	geode = false
func _process(delta):
	if geode and Input.is_action_pressed("Interact"):
		animated_sprite_2d.play("Cut")
