extends Control
@onready var main = $"../.."
@onready var resume = $Resume
var save_path = "user://variable.save"

func _on_resume_pressed():
	main.toggle_pause()
	resume.grab_focus()  # Ensure Resume button regains focus after resuming

func _on_quit_pressed():
	get_tree().quit() 


func _on_save_pressed():
	pass # Replace with function body.


func _on_load_pressed():
	pass # Replace with function body.
