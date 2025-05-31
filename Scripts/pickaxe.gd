extends Node2D
var touchable = false
var pickedup =false
@onready var item_popup: Sprite2D = $CanvasLayer/ItemPopup
@onready var animatable_body_2d: CollisionShape2D = $CollisionShape2D
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
	animatable_body_2d.hide()
	item_popup.hide()
	item_popup.position = Vector2(160,160)
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == burbur and pickedup == false:
		touchable = true
		item_popup.show()
		animatable_body_2d.show()
	elif pickedup == false:
		animatable_body_2d.hide()
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == burbur and pickedup == false:
		touchable = false
		item_popup.hide()
		animatable_body_2d.hide()
	elif pickedup == false:
		animatable_body_2d.show()
func _process(delta: float):
	if Input.is_action_just_pressed("Items"):
		if touchable and not pickedup:
			pickedup = true
			_hide_all(self)
			Global.pickaxeinhand = true
		elif pickedup:
			pickedup = false
			_show_all(self)
			self.position = burbur.position + Vector2(4, -8)
			item_popup.position = Vector2(160, 160)
			Global.pickaxeinhand = false
			print("Self position:", self.position)
			print("Area2D position:", $Area2D.position)
			print("Area2D global:", $Area2D.global_position)
