extends KinematicBody2D

export (int) var speed = 65

var velocity = Vector2.ZERO

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

func _physics_process(delta):
	var horizontal_direction = 	Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = horizontal_direction * speed
	velocity = move_and_slide(velocity)
	
	if is_zero_approx(velocity.x):
		animation_player.play("Idle")
	else:
		animation_player.play("Move")
		
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false

