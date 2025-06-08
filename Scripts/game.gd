extends Node2D  # or just Node if you're not using `_process` etc.


var pickaxeinhand = false
var pickeduppickaxe = false
var playerFliped = false

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
