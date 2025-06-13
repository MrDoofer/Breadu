extends Node2D  # or just Node if you're not using `_process` etc.
var Saving = false
var saved
var pickaxeinhand = false
var pickeduppickaxe = false
var playerFliped = false
var player_on_screen= true
var player_pos = Vector2(0,0)
# ✅ This is needed to avoid "null" errors
var pickspawn_failed = false

# ✅ For geode save/load tracking
var geodes_opened: Dictionary = {}
var _geode_counter := 0

# ✅ Auto-assigns unique IDs to each geode
func get_next_geode_id() -> String:
	var id = "geode_" + str(_geode_counter)
	_geode_counter += 1
	return id

func dont_stay_rendered():
	if player_on_screen == false:
		_hide_all(self)

func _hide_all(node):
	if node is CanvasItem:
		node.visible = false
	elif node.has_method("hide"):
		node.hide()
	if node is CollisionObject2D or node is CollisionShape2D:
		node.set_deferred("disabled", true)
	for child in node.get_children():
		_hide_all(child)


func _show_all(node):
	if node is CanvasItem:
		node.visible = true
	elif node.has_method("show"):
		node.show()
	if node is CollisionObject2D or node is CollisionShape2D:
		node.set_deferred("disabled", false)
	for child in node.get_children():
		_show_all(child)

#saves stuff
var save_path = "user://save1.save"
var save_path_number = 1
var Save_popup_hidden = true
@onready var burbur: CharacterBody2D = $"../../Burbur"
@onready var pickaxe: RigidBody2D = $"../../../map/Items/Pickaxe"
func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(Global.pickaxeinhand)
	file.store_var(Global.pickeduppickaxe)
	file.store_var(Global.geodes_opened)
	file.store_var(Global.player_pos)
func load_data():
	if save_path_number == 1:
		save_path = "user://save1.save"
	elif save_path_number == 2:
		save_path = "user://save2.save"
	elif save_path_number == 3:
		save_path = "user://save3.save"
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

#pausing
var paused = false
func toggle_pause() -> void:
	paused = !paused
	get_tree().paused = paused

	if paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
