extends Sprite2D
var touchable = false
@onready var pickaxe: Sprite2D = $"."
@onready var item_popup: Sprite2D = $CanvasLayer/ItemPopup
@onready var burbur: CharacterBody2D = $"../../Burbur"
@onready var detector: CollisionShape2D = $Area2D/detector
@onready var oneway: CollisionShape2D = $StaticBody2D/oneway
var playerpos
func _ready():
	oneway.hide()
	await get_tree().process_frame
	item_popup.hide()
	item_popup.position = Vector2(160,160)
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == burbur:
		oneway.show()
		touchable = true
		item_popup.show()
	else:
		oneway.hide()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == burbur:
		oneway.hide()
		touchable = false
		item_popup.hide()
	else:
		oneway.show()
func _process(delta: float):
	playerpos = burbur.global_position + Vector2(2,4)
	if touchable==true and Input.is_action_just_pressed("Items"):
		pickaxe.visible = false
		Game.pickaxe =true
