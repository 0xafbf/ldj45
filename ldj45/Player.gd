extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
	
	if velocity != Vector2.ZERO:
		#var direction = look_at(velocity)
		#print(direction)
		set_rotation(velocity.angle())
	