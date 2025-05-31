extends Camera2D
@onready var burbur: CharacterBody2D = $"../../Burbur"

func _process(delta):
	if is_instance_valid(burbur):
		if not is_player_in_view():
			var side = get_exit_side()
			print("Player exited to the %s!" % side)

			# Update the camera position accordingly
			match side:
				"left":
					position -= Vector2(320, 0)
				"right":
					position += Vector2(320, 0)
				"top":
					position -= Vector2(0, 180)
				"bottom":
					position += Vector2(0, 180)


func is_player_in_view() -> bool:
	var viewport_rect = get_viewport_rect()
	var half_size = viewport_rect.size * 0.5 * zoom
	var cam_pos = global_position
	var screen_rect = Rect2(cam_pos - half_size, half_size * 2)
	return screen_rect.has_point(burbur.global_position)

func get_exit_side() -> String:
	var cam_pos = global_position
	var half_size = get_viewport_rect().size * 0.5 * zoom
	var player_pos = burbur.global_position
	var dx = player_pos.x - cam_pos.x
	var dy = player_pos.y - cam_pos.y

	# Compare which axis is furthest out of bounds
	if abs(dx) > half_size.x:
		return "right" if dx > 0 else "left"
	elif abs(dy) > half_size.y:
		return "bottom" if dy > 0 else "top"
	return "inside"  # should never reach this if used with is_player_in_view
