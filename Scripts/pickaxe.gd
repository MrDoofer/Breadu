extends Node2D
var geodes_available = false
var body_entered = false
var touchable = false
@onready var item_popup: Sprite2D = $"../../screen things/Camera2D/CanvasLayer/ItemPopup"
@onready var burbur: CharacterBody2D = $"../../Burbur"

func _hide_all(node):
	if node is CanvasItem:
		node.visible = false
	elif node.has_method("hide"): # fallback
		node.hide()
	# Disable collisions if applicable
	if node is CollisionObject2D:
		node.set_deferred("disabled", true)
	elif node is CollisionShape2D:
		node.set_deferred("disabled", true)
	for child in node.get_children():
		_hide_all(child)
func _show_all(node):
	if node is CanvasItem:
		node.visible = true
	elif node.has_method("show"):
		node.show()

	# Re-enable collisions if applicable
	if node is CollisionObject2D:
		node.set_deferred("disabled", false)
	elif node is CollisionShape2D:
		node.set_deferred("disabled", false)

	for child in node.get_children():
		_show_all(child)
func _ready():
	await get_tree().process_frame
	item_popup.hide()
	item_popup.position = Vector2(160,160)
func _on_area_2d_body_entered(body: Node2D) -> void:
	body_entered = true
	if body == burbur and Global.pickaxeinhand == false:
		touchable = true
		item_popup.show()
func _on_area_2d_body_exited(body: Node2D) -> void:
	body_entered = false
	if body == burbur and Global.pickaxeinhand == false:
		touchable = false
		item_popup.hide()
func _process(delta: float):
	if Input.is_action_just_pressed("Items"):
		if touchable and not Global.pickaxeinhand:
			self.rotation = 0
			Global.pickaxeinhand = true
			touchable = false  # 💡 Important: Reset it
			body_entered = false  # Also reset
			_hide_all(self)
			item_popup.hide()
		elif not touchable and Global.pickaxeinhand:
			Global.pickaxeinhand = false
			_show_all(self)
			item_popup.hide()  # 👈 Force it to hide when re-spawning
			self.position = burbur.position + Vector2(4, -20)
