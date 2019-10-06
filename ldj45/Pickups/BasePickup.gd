extends Area2D
tool

export var texture: Texture setget set_texture
export var offset = Vector2() setget set_offset
export var description: String setget set_description

func set_texture(in_texture: Texture):
	texture = in_texture
	if $Sprite:
		$Sprite.texture = texture

func set_offset(in_offset: Vector2):
	offset = in_offset
	if $Sprite:
		$Sprite.position = in_offset

func body_entered(body: PhysicsBody2D):
	print(body)


func set_description(in_description):
	description = in_description
	if $TextField:
		$TextField.text = description

func _on_Pickup_body_entered(body):
	$TextField.visible = true

func _on_Pickup_body_exited(body):
	$TextField.visible = false
