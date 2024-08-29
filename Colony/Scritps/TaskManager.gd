extends Node

class_name TaskManager
# Called when the node enters the scene tree for the first time.

func RequestTask():
	var task = Task.new()
	task.initFindAndEatFood()
	return task
