extends KinematicBody2D

export var max_speed = 500
export var acceleration = 8000
var velocity: Vector2

func _physics_process(delta):
	var move_up = Input.get_action_strength("move_up")
	var move_down = Input.get_action_strength("move_down")
	
	var move_right = Input.get_action_strength("move_right")
	var move_left = Input.get_action_strength("move_left")
	
	var move_input = Vector2(move_right - move_left, move_up - move_down);
	move_input.y = -move_input.y
	
	if move_input != Vector2.ZERO:
		var current_acceleration = move_input.clamped(1.0) * acceleration
		velocity += current_acceleration * delta
	else:
		var acc_this_frame = acceleration * delta
		acc_this_frame = min(acc_this_frame, velocity.length())
		var current_acceleration = -velocity.normalized() * acc_this_frame
		velocity += current_acceleration
	
	velocity = velocity.clamped(max_speed)
	velocity = move_and_slide(velocity)
	update_walk_anim(velocity)
	
	if velocity != Vector2.ZERO:
		#var direction = look_at(velocity)
		#print(direction)
		pass #set_rotation(velocity.angle())

export var texture_up:Texture
export var texture_down:Texture
export var texture_side:Texture
export var texture_walk_up:Texture
export var texture_walk_down:Texture
export var texture_walk_side:Texture


var scale_x = 7

func update_walk_anim(speed: Vector2):
	var sprite = $Sprite
	if speed.length() < 0.1:
		if sprite.texture == texture_walk_up:
			sprite.texture = texture_up
		elif sprite.texture == texture_walk_down:
			sprite.texture = texture_down
		elif sprite.texture == texture_walk_side:
			sprite.texture = texture_side
	else:
		if abs(speed.x) > abs(speed.y):
			sprite.texture = texture_walk_side
			sprite.scale.x = scale_x * sign(speed.x)
		else:
			sprite.scale.x = scale_x
			if speed.y > 0:
				sprite.texture = texture_walk_down
			else:
				sprite.texture = texture_walk_up
				
			
	