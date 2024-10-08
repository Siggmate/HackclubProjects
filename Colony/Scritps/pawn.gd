extends CharacterBody2D

@onready var terrain = $"../Terrain"
@onready var pathfinding = $"../Pathfinding"
const SPEED = 1000
var path = []


func _physics_process(delta):
	if Input.is_action_just_pressed("click"):
		var pos = position / terrain.rendering_quadrant_size
		var targetPos = get_global_mouse_position() / terrain.rendering_quadrant_size
		
		path = pathfinding.findPath(pos, targetPos)
	
	if len(path):
		var direction = global_position.direction_to(path[0])
		var terrainDifficulty = pathfinding.getTerrainDifficulty(position/terrain.rendering_quadrant_size)
		velocity = direction * SPEED * delta * (1/terrainDifficulty)
		
		if (position.distance_to(path[0]) < SPEED * delta):
			path.remove_at(0)
			
	else:
		velocity = Vector2(0,0)
	
	move_and_slide()
