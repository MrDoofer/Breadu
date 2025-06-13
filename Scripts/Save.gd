extends Node2D

@onready var yes: Button = $HBoxContainer/Yes
@onready var no: Button = $HBoxContainer/No

func _process(delta: float) -> void:
	if !self.hidden:
		yes.grab_focus()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Global.Save_popup_hidden =false
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
		Global.Save_popup_hidden = true
		Global.saved = false

func _on_yes_pressed() -> void:
	Global.save()
	Global.toggle_pause()
	Global.saved = true
	Global._hide_all(self)
func _on_no_pressed() -> void:
	Global.toggle_pause()
	Global._hide_all(self)
func _on_visibility_changed() -> void:
	if self.visible == true:
		Global.toggle_pause()
		yes.grab_focus()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
