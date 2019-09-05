extends KinematicBody2D

onready var camera = $Camera2D

func _process(delta):
	
	var move = Vector2(0, 0)
	
	if Input.is_action_pressed("ui_left"):
		move.x -= 1000
	if Input.is_action_pressed("ui_right"):
		move.x += 1000
	if Input.is_action_pressed("ui_up"):
		move.y -= 1000
	if Input.is_action_pressed("ui_down"):
		move.y += 1000
		
	move_and_slide(move)
			
	pass
