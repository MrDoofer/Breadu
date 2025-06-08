extends Control

@onready var main = $"../.."
@onready var resume = $Resume
@onready var pickaxe: RigidBody2D = $"../../../map/Items/Pickaxe"

var save_path = "user://variable.save"
func _ready() -> void:
	load_data()
func _on_resume_pressed():
	main.toggle_pause()
	resume.grab_focus()

func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(Global.pickaxeinhand)
	file.store_var(Global.pickeduppickaxe)
	file.store_var(Global.geodes_opened)
	file.store_var($"../../../Burbur".global_position)  # 👈 Save the item's world position

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		Global.pickaxeinhand = file.get_var()
		Global.pickeduppickaxe = file.get_var()
		Global.geodes_opened = file.get_var()

		var saved_position = file.get_var()
		$"../../../Burbur".global_position = saved_position  # 👈 Reapply saved position

		# Optionally reapply states to pickaxe or geodes


		# Re-apply geode cracked state
		for geode in get_tree().get_nodes_in_group("Geodes"):
			if geode.has_method("apply_loaded_state"):
				geode.apply_loaded_state()

		# Re-apply pickaxe (if you've added a method for it)
		if pickaxe and pickaxe.has_method("apply_loaded_state"):
			pickaxe.apply_loaded_state()


func _on_quit_pressed():
	get_tree().quit()

func _on_save_pressed():
	save()

func _on_load_pressed():
	load_data()


func _on_del_save_pressed() -> void:
	if FileAccess.file_exists(save_path):
		var dir := DirAccess.open("user://")
		if dir != null:
			var err := dir.remove("variable.save")
			if err == OK:
				print("Save file deleted successfully.")
			else:
				print("Failed to delete the save file. Error code:", err)
		else:
			print("Failed to access user directory.")
	else:
		print("No save file exists to delete.")
