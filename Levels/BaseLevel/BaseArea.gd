extends Node2D

onready var Tilemap = $TileMap
onready var size = get_size()
onready var limits = get_limits()

func _ready():
	create_area2d()

func _activate_area(body):
	if body.name == "Player":
		body.camera.limit_top = limits[0]
		body.camera.limit_right = limits[1]
		body.camera.limit_bottom = limits[2]
		body.camera.limit_left = limits[3]
		print(name + " activated")
	pass

func _deactivate_area(body):
	if body.name == "Player":
		print(name + " deactivated")
	pass
	
func create_area2d():
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(size.x/2-32, size.y/2-32))
	
	var collision = CollisionShape2D.new()
	collision.set_shape(shape)
	
	var area2d = Area2D.new()
	area2d.set_position(size/2)
	area2d.add_child(collision)
	area2d.connect("body_entered", self, "_activate_area")
	area2d.connect("body_exited", self, "_deactivate_area")
	
	add_child(area2d)

func get_size():
	var map_limits = Tilemap.get_used_rect()
	var map_cellsize = Tilemap.cell_size
	var left = map_limits.position.x * map_cellsize.x
	var right = map_limits.end.x * map_cellsize.x
	var top = map_limits.position.y * map_cellsize.y
	var bottom = map_limits.end.y * map_cellsize.y
	return Vector2(right - left, bottom - top)

func get_limits():
	var map_limits = Tilemap.get_used_rect()
	var map_cellsize = Tilemap.cell_size
	var left = map_limits.position.x * map_cellsize.x + global_position.x
	var right = map_limits.end.x * map_cellsize.x + global_position.x
	var top = map_limits.position.y * map_cellsize.y + global_position.y
	var bottom = map_limits.end.y * map_cellsize.y + global_position.y
	return [top, right, bottom, left]