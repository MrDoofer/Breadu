extends Sprite2D
var touchable = false
var pickedup =false
@onready var item_popup: Sprite2D = $CanvasLayer/ItemPopup
@onready var animatable_body_2d: AnimatableBody2D = $AnimatableBody2D
@onready var burbur: CharacterBody2D = $"../../Burbur"

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
	if touchable and Input.is_action_just_pressed("Items"):
		pickedup = true
		_hide_all(self)
		Global.pickaxeinhand = true

func _hide_all(node):
	node.hide()
	for child in node.get_children():
		if child is Node:
			_hide_all(child)
