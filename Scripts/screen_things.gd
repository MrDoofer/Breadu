extends Node
@onready var pause_menu: Control = $"Camera2D/Pause Menu"

var paused = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		toggle_pause()

func toggle_pause():
	paused = !paused
	get_tree().paused = paused  # Pause/unpause the game tree

	if paused:
		pause_menu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause_menu.grab_focus.call_deferred()
	else:
		pause_menu.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
