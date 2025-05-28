extends CollisionShape2D
var Touchable = false
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

func _on_geode_body_entered(body: Node2D) -> void:
	Touchable = true

func _on_geode_body_exited(body: Node2D) -> void:
	Touchable = false

func _process(delta: float):
	if Touchable==true and Input.is_action_just_pressed("Interact"):
		animated_sprite_2d.play("Cracked")
	
