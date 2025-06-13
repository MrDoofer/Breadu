extends Node2D  # or just Node if you're not using `_process` etc.
var Saving = false
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
