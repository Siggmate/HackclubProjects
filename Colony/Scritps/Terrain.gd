@tool
extends TileMap

@export var mapWidth : int
@export var mapHeight : int

@export var generateTerrain : bool
@export var clearTerrain : bool
@export var terrainSeed : int

@export var snowThreshold : float
@export var rock3Threshold : float
@export var rock2Threshold : float
@export var rock1Threshold : float
@export var grassThreshold : float
@export var forestThreshold : float
@export var dirtThreshold : float
@export var mudThreshold : float
@export var sandThreshold : float
@export var water1Threshold : float
@export var water2Threshold : float
@export var water3Threshold : float

func _ready():
	pass


func _process(delta):
	if generateTerrain:
		generateTerrain = false
		GenerateTerrain()
		
	if clearTerrain:
		clearTerrain = false
		clear()


func GenerateTerrain():
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	
	var rng = RandomNumberGenerator.new()
	
	if terrainSeed == 0:
		noise.seed = rng.randi()
	else:
		noise.seed = terrainSeed
	
	for x in mapWidth:
		for y in mapHeight:
			if noise.get_noise_2d(x,y) > water3Threshold:
				set_cell(0, Vector2i(x,y), 0, Vector2i(2,2))
			elif noise.get_noise_2d(x,y) > water2Threshold:
				set_cell(0, Vector2i(x,y), 0, Vector2i(1,2))
			elif noise.get_noise_2d(x,y) > water1Threshold:
				set_cell(0, Vector2i(x,y), 0, Vector2i(0,2))
			elif noise.get_noise_2d(x,y) > sandThreshold:
				set_cell(0, Vector2i(x,y), 0, Vector2i(3,2))
			elif noise.get_noise_2d(x,y) > dirtThreshold:
				set_cell(0, Vector2i(x,y), 0, Vector2i(2,0))
			elif noise.get_noise_2d(x,y) > forestThreshold:
				set_cell(0, Vector2i(x,y), 0, Vector2i(1,0))
			elif noise.get_noise_2d(x,y) > grassThreshold:
				set_cell(0, Vector2i(x,y), 0, Vector2i(0,0))
			elif noise.get_noise_2d(x,y) > rock1Threshold:
				set_cell(0, Vector2i(x,y), 0, Vector2i(2,1))
			elif noise.get_noise_2d(x,y) > rock2Threshold:
				set_cell(0, Vector2i(x,y), 0, Vector2i(1,1))
			elif noise.get_noise_2d(x,y) > rock3Threshold:
				set_cell(0, Vector2i(x,y), 0, Vector2i(0,1))
			elif noise.get_noise_2d(x,y) > snowThreshold:
				set_cell(0, Vector2i(x,y), 0, Vector2i(3,1))
			else:
				set_cell(0, Vector2i(x,y), 0, Vector2i(3,0))
