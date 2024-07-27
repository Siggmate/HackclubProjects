@tool
extends Node2D

@onready var terrain = $"../Terrain"

var astar_grid = AStarGrid2D.new()

@export var start : Vector2i
@export var end : Vector2i
@export var calculate : bool
var path = []


func _ready():
	initPathfinding()
	pass
	

func _process(delta):
	if calculate:
		calculate = false
		initPathfinding()
		findPath(start, end)
	
	
func _draw():
	if len(path) > 0:
		for i in len(path)-1:
			draw_line(path[i], path[i+1], Color.PURPLE)


func findPath(start : Vector2i, end : Vector2i):
	path = astar_grid.get_point_path(start,end)
	return path
	queue_redraw()


func initPathfinding():
	astar_grid.region = Rect2i(0,0,terrain.mapWidth, terrain.mapHeight)
	astar_grid.cell_size = Vector2(16,16)
	astar_grid.update()
	
	for x in terrain.mapWidth:
		for y in terrain.mapHeight:
			astar_grid.set_point_weight_scale(Vector2i(x,y), getTerrainDifficulty(Vector2i(x,y)))


func getTerrainDifficulty(coords: Vector2i):
	var layer = 0
	var source_id = terrain.get_cell_source_id(layer, coords, false)
	var source: TileSetAtlasSource = terrain.tile_set.get_source(source_id)
	var atlas_coords = terrain.get_cell_atlas_coords(layer, coords, false)
	var tile_data = source.get_tile_data(atlas_coords, 0)
	
	return tile_data.get_custom_data("walkDifficulty")
