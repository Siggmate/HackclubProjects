extends Camera2D

var zoomTarget : Vector2
@export var zoomSpeed := 10
@export var moveSpeed := 1000
var dragStartMousePos := Vector2.ZERO
var dragStartCameraPos := Vector2.ZERO
var isDragging := false


func _ready():
	zoomTarget = zoom
	pass # Replace with function body.


func _process(delta):
	Zoom(delta)
	SimplePan(delta)
	ClickAndDrag()
	
	
func Zoom(delta):
	if Input.is_action_just_pressed("CameraZoomIn"):
		zoomTarget *= 1.1
	if Input.is_action_just_pressed("CameraZoomOut"):
		zoomTarget /= 1.1
		
	zoom = zoom.slerp(zoomTarget, zoomSpeed * delta)
	
func SimplePan(delta):
	var moveAmount = Vector2.ZERO
	if Input.is_action_pressed("CameraMoveRight"):
		moveAmount.x += 1
	if Input.is_action_pressed("CameraMoveLeft"):
		moveAmount.x -= 1
	if Input.is_action_pressed("CameraMoveUp"):
		moveAmount.y -= 1
	if Input.is_action_pressed("CameraMoveDown"):
		moveAmount.y += 1
	
	moveAmount.normalized()
	position += moveAmount * moveSpeed * delta * (1/zoom.x)
	
func ClickAndDrag():
	if !isDragging and Input.is_action_just_pressed("CameraPan"):
		dragStartMousePos = get_viewport().get_mouse_position()
		dragStartCameraPos = position
		isDragging = true
	
	if isDragging and Input.is_action_just_released("CameraPan"):
		isDragging = false
		
	if isDragging:
		var moveVector = get_viewport().get_mouse_position() - dragStartMousePos
		position = dragStartCameraPos - moveVector * 1/zoom.x
