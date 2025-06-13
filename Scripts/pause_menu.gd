extends CanvasLayer
@onready var resume: Button = $VBoxContainer/Resume
var paused = false
func toggle_pause():
	paused = !paused
	get_tree().paused =paused

	if paused:
		self.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		resume.grab_focus()
	else:
		self.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _on_resume_pressed():
	self.toggle_pause()
	resume.grab_focus()

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		toggle_pause()


func _on_settings_pressed() -> void:
	null
