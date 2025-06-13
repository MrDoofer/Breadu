extends StaticBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_timer_timeout() -> void:
	var total_dice_sides = 3
	animated_sprite_2d.frame = randi() % total_dice_sides
func _process(delta: float) -> void:
	Global.dont_stay_rendered()
