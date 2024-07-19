extends CharacterBody2D

var speed := 150
var directions := ["left", "right", "up", "down"]
var acc := 2
var friction := 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()

func move():
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		accelerate(direction)
	else:
		apply_friction()
	move_and_slide()

func accelerate(direct: Vector2):
	velocity = velocity.move_toward(direct * speed, acc)
	
func apply_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)
