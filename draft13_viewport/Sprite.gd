extends Sprite


func _process(delta):
	if Input.is_key_pressed(KEY_LEFT):
		self.translate(Vector2(-100*delta,0))
		
	if Input.is_key_pressed(KEY_RIGHT):
		self.translate(Vector2(100*delta,0))
