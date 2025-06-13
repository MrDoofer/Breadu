extends CanvasLayer
@onready var resume: Button = $VBoxContainer/Resume

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _on_resume_pressed():
	Global.toggle_pause()
	self.hide()


func _on_quit_pressed():
	get_tree().quit()
	
func _process(delta):
	if Input.is_action_just_pressed("Pause") and not Global.paused:
		Global.toggle_pause()
		self.show()
		resume.grab_focus()


func _on_settings_pressed() -> void:
	null
