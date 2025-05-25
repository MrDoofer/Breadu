extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animated_sprite = $"../G2/AnimatedSprite2D"


func _on_body_entered(CharacterBody2D):
	animated_sprite_2d.play("Stepped on")
func _on_body_exited(CharacterBody2D):
	animated_sprite_2d.play("Released")

func _on_g_2_body_entered(CharacterBody2D):
	animated_sprite.play("Stepped On")
func _on_g_2_body_exited(CharacterBody2D):
	animated_sprite.play("Released")
