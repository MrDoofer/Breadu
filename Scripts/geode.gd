extends Node2D

var geode_id := ""
var touched = false

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var area_2d = $Area2D
@onready var e: Sprite2D = $"../../screen things/Camera2D/CanvasLayer/E"

func _ready():
	add_to_group("Geodes")
	await get_tree().process_frame
	if geode_id == "":
		geode_id = Global.get_next_geode_id()
	apply_loaded_state()

func apply_loaded_state():
	if Global.geodes_opened.has(geode_id):
		animated_sprite_2d.play("Cracked")
		area_2d.set_deferred("monitoring", false)
		e.hide()
	else:
		animated_sprite_2d.play("default")

func _on_area_2d_body_entered(body: Node2D):
	if Global.pickaxeinhand:
		touched = true

func _on_area_2d_body_exited(body: Node2D):
	if Global.pickaxeinhand:
		touched = false

func _process(_delta):
	if Global.geodes_opened.has(geode_id):
		e.hide()
		return

	if touched and Global.pickaxeinhand and Input.is_action_just_pressed("Geodes"):
		animated_sprite_2d.play("Cracked")
		area_2d.set_deferred("monitoring", false)
		Global.geodes_opened[geode_id] = true
	elif touched and Global.pickaxeinhand:
		e.show()
	else:
		e.hide()
