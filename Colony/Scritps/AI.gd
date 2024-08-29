extends Node

@onready var taskMgr = $"../../TaskManager"
@onready var itemMgr = $"../../ItemManager"

@onready var charCtrl = $".."

enum pawnAction {Idle, DoingSubTask}

var currentAction : pawnAction = pawnAction.Idle

var currentTask : Task = null

var inHand

func _process(delta):
	if currentTask != null:
		doCurrentTask(delta)
	else:
		currentTask = taskMgr.RequestTask()
		
func onPickupItem(item):
	inHand = item
	itemMgr.RemoveItemFromWorld(item)

func onFinishedSubtask():
	currentAction = pawnAction.Idle
	
	if currentTask.isFinished():
		currentTask = null

func doCurrentTask(delta):
	var subTask = currentTask.getCurrentSubTask()
	if currentAction == pawnAction.Idle:
		startCurrentSubTask(subTask)
	else:
		match subTask.taskType:
			Task.TaskType.WalkTo:
				if charCtrl.hasReachedDest():
					currentTask.onReachedDestination()
					onFinishedSubtask()
	
func startCurrentSubTask(subTask):
	match subTask.taskType:
		Task.TaskType.FindItem:
			var targetItem = itemMgr.FindNearestItem(subTask.targetItemType, charCtrl.position)
			if targetItem == null:
				currentTask.Finish()
			else:
				currentTask.onFoundItem(targetItem)
				
			onFinishedSubtask()
			
		Task.TaskType.WalkTo:
			charCtrl.setMoveTarget(subTask.targetItem.position)
			currentAction = pawnAction.DoingSubTask
			
		Task.TaskType.Pickup:
			onPickupItem(subTask.targetItem)
			currentTask.onFinishedSubTask()
			onFinishedSubtask()
	
