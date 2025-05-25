extends Control
@onready var main = $".."
@onready var resume = $Resume

func _on_resume_pressed():
	main.toggle_pause()
	resume.grab_focus()  # Ensure Resume button regains focus after resuming

func _on_quit_pressed():
	get_tree().quit() 
