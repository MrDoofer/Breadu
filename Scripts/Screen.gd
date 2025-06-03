extends Sprite2D

func _process(delta: float) -> void:
	if Global.pickeduppickaxe == true:
		self.show()
	else:
		self.hide()
