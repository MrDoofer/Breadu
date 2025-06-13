extends AnimatedSprite2D
@onready var in_hand: AnimatedSprite2D = $"."

func _process(delta: float) -> void:
	if Global.pickeduppickaxe == true:
		self.show()
		if Global.pickaxeinhand:
			in_hand.frame = 0
		else:
			in_hand.frame = 1
	else:
		self.hide()
