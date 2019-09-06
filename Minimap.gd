extends ViewportContainer

export var MAX_ZOOM = 10
export var MIN_ZOOM = 1
export var DEFULT_ZOOM = 1.5
export var ZOOM_SPEED = 0.25
export var MOVE_SPEED = 20

onready var Global = $"/root/Global"
onready var Camera = $Viewport/MinimapCamera

var dragMouse = false
var lastMousePosition = null

func _ready():
	pass
	
func _input(InputEvent):
	
	if !Global.paused:
		return
	
	var zoom = 0
	
	if InputEvent.is_action_pressed("ui_scroll_up") and Camera.zoom.x > MIN_ZOOM:
		zoom = -1
	if InputEvent.is_action_pressed("ui_scroll_down") and Camera.zoom.x < MAX_ZOOM:
		zoom = 1
	
	if InputEvent is InputEventMouseButton:
		dragMouse = InputEvent.is_pressed()
		
	Camera.zoom += Vector2(1, 1) * zoom * ZOOM_SPEED

# warning-ignore:unused_argument
func _process(delta):
	
	if Input.is_action_just_pressed("ui_map"):
		toggle_minimap()
		
	if !Global.paused:
		return
		
	var move = Vector2(0, 0)
	
	if Input.is_action_pressed("ui_left"):
		move.x -= 1
	if Input.is_action_pressed("ui_right"):
		move.x += 1
	if Input.is_action_pressed("ui_up"):
		move.y -= 1
	if Input.is_action_pressed("ui_down"):
		move.y += 1
		
	move *= MOVE_SPEED
		
	if dragMouse:
		move = (lastMousePosition - get_viewport().get_mouse_position()) * Vector2(1.33, 1) * (1 + pow((Camera.zoom.x / MAX_ZOOM), 2))
	
	lastMousePosition = get_viewport().get_mouse_position()
		
	Camera.offset += move
	
func toggle_minimap():
	
	# Pauses the game
	Global.paused = !Global.paused
	
	# Make the minimap and minimap hud elements visible
	visible = !visible
	for MinimapInfo in get_tree().get_nodes_in_group("MinimapInfo"):
		MinimapInfo.visible = !MinimapInfo.visible
	
	# Resets the minimap position
	Camera.offset = Vector2(0, 0)
	Camera.zoom = Vector2(1.5, 1.5)
	Camera.position = Vector2(Global.player.global_position.x, Global.player.global_position.y)
