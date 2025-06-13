extends Node2D

@onready var burbur: CharacterBody2D = $"../../Burbur"
@onready var pickaxe: RigidBody2D = $"../../../map/Items/Pickaxe"
@onready var yes: Button = $"../../screen things/Camera2D/CanvasLayer/SavePopup/Yes"
var save_path = "user://variable.save"
var paused = false
func toggle_pause():
	paused = !paused
	get_tree().paused =paused

	if paused:
		self.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		yes.grab_focus()
	else:
		self.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _on_del_save_pressed() -> void:
	if FileAccess.file_exists(save_path):
		var dir := DirAccess.open("user://")
		if dir != null:
			var err := dir.remove("variable.save")
			if err == OK:
				print("Save file deleted successfully.")
				load_data()
			else:
				print("Failed to delete the save file. Error code:", err)
		else:
			print("Failed to access user directory.")
	else:
		print("No save file exists to delete.")
func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(Global.pickaxeinhand)
	file.store_var(Global.pickeduppickaxe)
	file.store_var(Global.geodes_opened)
	file.store_var(Global.player_pos)
func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		Global.pickaxeinhand = file.get_var()
		Global.pickeduppickaxe = file.get_var()
		Global.geodes_opened = file.get_var()
		Global.player_pos =file.get_var()  # 👈 Reapply saved position


		# Optionally reapply states to pickaxe or geodes


		# Re-apply geode cracked state
		for geode in get_tree().get_nodes_in_group("Geodes"):
			if geode.has_method("apply_loaded_state"):
				geode.apply_loaded_state()

		# Re-apply pickaxe (if you've added a method for it)
		if pickaxe and pickaxe.has_method("apply_loaded_state"):
			pickaxe.apply_loaded_state()



func _on_yes_pressed() -> void:
	save()
	self.toggle_pause()


func _on_no_pressed() -> void:
	self.toggle_pause()

func _process(delta: float) -> void:
	if !self.hidden:
		self.toggle_pause()
