extends KinematicBody2D

const WALK_SPEED = 200
var dead = false
var direction = Vector2()
var current_animation = "idle"
var bomb_scene = preload("res://sub/Bomb.tscn")
var id = 0
onready var arena = get_node("/root/Arena")

var can_drop_bomb = true
onready var tilemap = get_node("/root/Arena/TileMap")

sync func damage(id):
	if (self.id == id) and dead != true:
		print("death %s" % id)
		dead = true
		$AnimationPlayer.play("Death")

func _physics_process(delta):
	if dead or not Gamestate.check_network_id(id):
		return
	
	if (Input.is_action_pressed("ui_up")):
		direction.y = - WALK_SPEED
		get_node("Sprite").rotation_degrees = -90
	elif (Input.is_action_pressed("ui_down")):
		direction.y = WALK_SPEED
		get_node("Sprite").rotation_degrees = 90
	else:
		direction.y = 0
	
	if (Input.is_action_pressed("ui_left")):
		direction.x = -WALK_SPEED
		get_node("Sprite").rotation_degrees = -180
	elif (Input.is_action_pressed("ui_right")):
		direction.x = WALK_SPEED
		get_node("Sprite").rotation_degrees = 0
	else:
		direction.x = 0
	
	move_and_slide(direction)
	
func _update_rot_and_animation():
	if dead:
		return
	
	rotation = atan2(direction.y, direction.x)
	var new_animation = "idle"
	if direction:
		new_animation = "Walking"
	if new_animation != current_animation:
		$AnimationPlayer.play(new_animation)
		current_animation = new_animation
		


func _process(delta):
	
	if dead or not Gamestate.check_network_id(id):
		return
	
	if Input.is_action_just_pressed("ui_select") and can_drop_bomb:
		var localPosition = tilemap.to_local(position)
		var mapPosition = tilemap.world_to_map(localPosition)
		var result = tilemap.map_to_world(mapPosition)
		result.x += tilemap.cell_size.x / 2
		result.y += tilemap.cell_size.y / 2
		rpc("_dropbomb", result, self.id)
		can_drop_bomb = false
		$DropBombCouldown.start()
		
	rpc_unreliable("_update_pos", position, direction)
		
sync func _dropbomb(pos, owner_id):
	var bomb = bomb_scene.instance()
	bomb.position = pos
	bomb.owner_id = owner_id
	arena.add_child(bomb)
	
sync func _update_pos(new_pos, new_direction):
	position = new_pos
	direction = new_direction
	_update_rot_and_animation()

func _on_DropBombCouldown_timeout():
	print("Can drop bomb")
	$DropBombCouldown.stop()
	can_drop_bomb = true
