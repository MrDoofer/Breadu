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
	if touchable==true and Input.is_action_just_pressed("Items"):
		pickedup = true
		self.hide()
		Global.pickaxeinhand =true
