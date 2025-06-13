extends Node2D

var geodes_available = false
var body_entered = false
var touchable = false

@onready var item_popup: Sprite2D = $"../../../screen things/Camera2D/CanvasLayer/Items"
@onready var burbur: CharacterBody2D = $"../../../Burbur"

func Items_succesful():
	self.rotation = 0
	Global.pickaxeinhand = true
	Global.pickeduppickaxe = true
	touchable = false
	body_entered = false
	Global._hide_all(self)
	item_popup.hide()

func Items_failed():
	Global.pickaxeinhand = false
	Global._show_all(self)
	item_popup.hide()

func _spawn_if_safe(polygon: PackedVector2Array, target_position: Vector2):
	var space_state = get_world_2d().direct_space_state
	var shape := ConvexPolygonShape2D.new()
	shape.points = polygon
	var transform := Transform2D(0, target_position)
	var query := PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.transform = transform
	query.collide_with_areas = false
	query.collide_with_bodies = true
	var result = space_state.intersect_shape(query, 1)
	if result.is_empty():
		global_position = target_position
		Global.pickspawn_failed = false
	else:
		Global.pickspawn_failed = true
		# You can play Burbur's annoyed animation here if desired




func _ready():
	await get_tree().process_frame
	item_popup.hide()


	# Automatically apply saved state when game starts
	apply_loaded_state()

func _on_area_2d_body_entered(body: Node2D) -> void:
	body_entered = true
	if body == burbur and not Global.pickaxeinhand:
		touchable = true
		item_popup.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	body_entered = false
	if body == burbur and not Global.pickaxeinhand:
		touchable = false
		item_popup.hide()

func _process(delta: float):
	Global.dont_stay_rendered()
	if Input.is_action_just_pressed("Items") and not Global.Saving:
		if touchable and not Global.pickaxeinhand:
			Items_succesful()
		elif not touchable and Global.pickaxeinhand:
			var polygon = $CollisionPolygon2D.polygon
			var offset: Vector2
			if Global.playerFliped:
				offset = Vector2(-6, -20)
			else:
				offset = Vector2(6, -20)

			_spawn_if_safe(polygon, burbur.position + offset)
			if not Global.pickspawn_failed:
				Items_failed()

func apply_loaded_state():
	if Global.pickeduppickaxe:
		if Global.pickaxeinhand:
			Global._hide_all(self)
			self.rotation = 0
		else:
			var polygon = $CollisionPolygon2D.polygon
			var offset: Vector2
			if Global.playerFliped:
				offset = Vector2(-6, -20)
			else:
				offset = Vector2(6, -20)
			_spawn_if_safe(polygon, burbur.position + offset)
	else:
		Global._show_all(self)
