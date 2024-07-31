extends Item

class_name Food

@export var nutrition := 1.0
@export var foodType : FoodType
@export var foodQuality : FoodQuality

enum FoodType {
	OMNIVORE,
	HERBIVORE,
	CARNIVORE,
}
enum FoodQuality {
	bad,
	simple,
	ok,
	fancyy
}

func _init():
	super._init()
	add_to_group("Food")

func _ready():
	pass # Replace with function body.



func _process(delta):
	pass
