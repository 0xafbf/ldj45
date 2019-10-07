extends KinematicBody2D

var dir = Vector2.ZERO;
var player;
var following = false;
var path : = PoolVector2Array()
var speed : = 500;
var dest : Vector2;
var player_vars : Node
onready var line_2d : = $Line2D


func _ready():
	$Area2D.connect("body_entered",self,"follow");
	$Area2D.connect("body_exited",self,"unfollow");
	player_vars = get_node("/root/globals")

func _physics_process(delta):
	$Sprite.flip_h = true
	$Sprite/AnimationPlayer.set_current_animation("WalkRight")
	if(following):
		var player_vars = get_node("/root/globals")
		path = player_vars.nav_2d.get_simple_path(position,player.position);

func _process(delta : float):
	var distance : = delta * speed
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			position  = path[0]
			set_process(false)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
		
func _unhandled_input(event:InputEvent):
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.is_pressed():
		return
		
	dest = event.global_position
	path = player_vars.nav_2d.get_simple_path(position,dest);
	line_2d.points = path
	
func follow(body):
	if(body.name == "Player"):
		following = true
		player = body

func unfollow(body):
	if(body.name == "Player"):
		dir = Vector2.ZERO
		following = false