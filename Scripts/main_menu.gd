extends CanvasLayer
@onready var start: Button = $PauseMenu/VBoxContainer/Start
var in_save_data_menu =false
func back():
	if Input.is_action_just_pressed("Geodes"):
		if in_save_data_menu == true:
			animation_player.play_backwards("save data")
			in_save_data_menu =false
			start.grab_focus()
func _ready() -> void:
	start.grab_focus()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
			get_tree().quit()
	back()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	Global.load_data()


func _on_settings_pressed() -> void:
	null

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var save_1: Button = $Black/VBoxContainer/Save1

func _on_save_data_pressed() -> void:
	in_save_data_menu = true
	animation_player.play("save data")
	save_1.grab_focus()


func _on_save_1_pressed() -> void:
	Global.save_path_number = 1
	Global.load_data()


func _on_save_2_pressed() -> void:
	Global.save_path_number = 2
	Global.load_data()


func _on_save_3_pressed() -> void:
	Global.save_path_number = 3
	Global.load_data()


func _on_del_1_pressed() -> void:
	if FileAccess.file_exists(Global.save_path):
		var dir := DirAccess.open("user://")
		if dir != null:
			var err := dir.remove("save1.save")
			if err == OK:
				print("Save file deleted successfully.")
				Global.load_data()
			else:
				print("Failed to delete the save file. Error code:", err)
		else:
			print("Failed to access user directory.")
	else:
		print("No save file exists to delete.")


func _on_del_2_pressed() -> void:
	if FileAccess.file_exists(Global.save_path):
		var dir := DirAccess.open("user://")
		if dir != null:
			var err := dir.remove("save2.save")
			if err == OK:
				print("Save file deleted successfully.")
				Global.load_data()
			else:
				print("Failed to delete the save file. Error code:", err)
		else:
			print("Failed to access user directory.")
	else:
		print("No save file exists to delete.")


func _on_del_3_pressed() -> void:
	if FileAccess.file_exists(Global.save_path):
		var dir := DirAccess.open("user://")
		if dir != null:
			var err := dir.remove("save3.save")
			if err == OK:
				print("Save file deleted successfully.")
				Global.load_data()
			else:
				print("Failed to delete the save file. Error code:", err)
		else:
			print("Failed to access user directory.")
	else:
		print("No save file exists to delete.")
