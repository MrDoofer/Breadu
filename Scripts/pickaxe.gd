extends Sprite2D
var touchable = false
@onready var pickaxe: Sprite2D = $"."
@onready var item_popup: Sprite2D = $CanvasLayer/ItemPopup

func _ready():
	await get_tree().process_frame
	item_popup.hide()
	item_popup.position = Vector2(160,160)
func _on_area_2d_body_entered(body: Node2D) -> void:
	touchable = true
	item_popup.show()
func _on_area_2d_body_exited(body: Node2D) -> void:
	touchable = false
	item_popup.hide()

func _process(delta: float):
	if touchable==true and Input.is_action_just_pressed("Items"):
		self.hide()
		Global.pickaxeinhand =true
