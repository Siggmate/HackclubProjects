extends Node

class_name Task

enum TaskType {BaseTask, FindItem, WalkTo, Pickup, Eat, Manipulate, Harvest}

var taskName: String
var taskType: TaskType = TaskType.BaseTask

var subTasks = []
var currentSubTask := 0

var targetItem
var targetItemType

func isFinished() -> bool:
	return currentSubTask == len(subTasks)
	
func finish():
	currentSubTask = len(subTasks)
	
func getCurrentSubTask():
	return subTasks[currentSubTask]
	
func onFinishedSubTask():
	currentSubTask += 1
	
func onFoundItem(item):
	onFinishedSubTask()
	getCurrentSubTask().targetItem = item
	
func onReachedDestination():
	onFinishedSubTask()
	getCurrentSubTask().targetItem = subTasks[currentSubTask - 1].targetItem
	
func initFindAndEatFood():
	taskName = "Find and eat food"
	
	var subTask = Task.new()
	subTask.taskType = TaskType.FindItem
	subTask.targetItemType = ItemManager.ItemCategory.food
	subTasks.append(subTask)
	
	subTask = Task.new()
	subTask.taskType = TaskType.WalkTo
	subTasks.append(subTask)
	
	subTask = Task.new()
	subTask.taskType = TaskType.PickUp
	subTasks.append(subTask)
	
	subTask = Task.new()
	subTask.taskType = TaskType.Eat
	subTasks.append(subTask)
	
