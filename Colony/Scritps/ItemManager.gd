extends Node

var foodPrototypes = []
var itemsInWorld = []
var itemCategories = ["Item", "Food", "Weapon", "MeleeWeapon", "RangedWeapon"]

enum ItemCategory {
	item = 0,
	food = 1,
	weapon = 2,
	meleeweapon = 3,
	rangedweapon = 4,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	LoadFood()
	SpawnItem(foodPrototypes[0],Vector2(80,90))
	SpawnItem(foodPrototypes[1],Vector2(84,98))
	SpawnItem(foodPrototypes[1],Vector2(73,100))
	SpawnItem(foodPrototypes[0],Vector2(91,88))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func MTWPos(mapPosX : int, mapPosY: int) -> Vector2:
	return Vector2(mapPosX * 16 + 8, mapPosY * 16 + 8)

func SpawnItem(item,pos):
	var newitem = item.instantiate()
	add_child(newitem)
	itemsInWorld.append(newitem)
	newitem.position = MTWPos(pos.x, pos.y)
	
func FindNearestItem(itemCategory : ItemCategory, worldPos : Vector2):
	if len(itemsInWorld) == 0:
		return null
		
	var nearestItem = null
	var nearestDistance = 999999
	
	for item in itemsInWorld:
		if isItemInCategory(item, itemCategory):
			var distance = worldPos.distance_to(item.position)
			
			if nearestItem == null:
				nearestItem = item
				nearestDistance = distance
				continue
			
			if distance < nearestDistance:
				nearestItem = item
				nearestDistance = distance
				
	return nearestItem
	
func isItemInCategory(item, itemCategory) -> bool:
	return item.is_in_group(itemCategories[itemCategory])

func LoadFood():
	var path = "res://Scenes/Items/Food"
	var dir = DirAccess.open(path)
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var filename = dir.get_next()
		if filename == "":
			break
		elif filename.ends_with(".tscn"):
			foodPrototypes.append(load(path+"/"+filename))
	dir.list_dir_end()
