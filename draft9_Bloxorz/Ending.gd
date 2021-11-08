extends Area

const BlockClass = preload("res://Block.gd")

func _on_Ending_body_entered(body):
	var block = body.get_parent()
	if block.rest_position == BlockClass.RestPosition.STANDING:
		block.won = true
		$GravityTimer.connect("timeout", self, "_on_GravityTimer_timeout", [block, body])
		$GravityTimer.wait_time = block.movement_duration
		$GravityTimer.one_shot = true
		$GravityTimer.start()


func _on_GravityTimer_timeout(block, body):
	block.win()
	$GravityTimer.disconnect("timeout", self, "_on_GravityTimer_timeout")
	

