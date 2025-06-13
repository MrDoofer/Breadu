extends Node2D
var inside_area = true

@onready var area_2d: Area2D = $Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer
@onready var items: Sprite2D = $"../../screen things/Camera2D/CanvasLayer/Items"
@onready var save_popup: Sprite2D = $"../../screen things/Camera2D/CanvasLayer/SavePopup"


func _ready() -> void:
	inside_area = false
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "save":
		animated_sprite_2d.play("default")
		animation_player.play("RESET")

func _on_area_2d_body_entered(body: Node2D) -> void:
	Global.Saving = true
	inside_area = true
	items.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	inside_area = false
	items.hide()
	Global.Saving = false

func  _process(delta: float) -> void:
	if Global.Saving == true and Input.is_action_just_pressed("Items"):
		Global._show_all(save_popup)
	if Global.saved == true:
		animated_sprite_2d.play("BEER")
		animation_player.play("save")
