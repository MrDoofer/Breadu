extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func _on_static_body_2d_body_entered(body: Node2D) -> void:
	animated_sprite_2d.play("stepped on")


func _on_static_body_2d_body_exited(body: Node2D) -> void:
	animated_sprite_2d.play("steepped off")
