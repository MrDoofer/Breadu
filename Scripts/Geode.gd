extends Sprite2D
var Touchable = false
@onready var body: Area2D = $Body
@onready var e: AnimatedSprite2D = $E
func _ready():
	await get_tree().process_frame  # wait one frame
	e.play("default")
	self.hide()
	self.global_position =Vector2(160,160)
func _on_geode_body_entered(body: Node2D):
	Touchable = true 
	self.show()

func _on_geode_body_exited(body: Node2D):
	Touchable = false
	self.hide()

func _process(delta: float):
	if Touchable==true and Input.is_action_just_pressed("Interact"):
		e.play("Cracked")
		body.hide()
