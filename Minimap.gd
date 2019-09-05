extends ViewportContainer

func _process(delta):
	if Input.is_action_just_pressed("ui_map"):
		print("ui_map pressed")
		visible = !visible
	pass
