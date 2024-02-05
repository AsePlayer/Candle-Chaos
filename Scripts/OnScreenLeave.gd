extends VisibleOnScreenNotifier2D
var leftScreen = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if leftScreen and not get_parent().game_manager.swappingScreen:
		if get_parent().position.y > 400 or get_parent().position.y < -500:
			$Timer.start()
			leftScreen = false
	pass


func _on_timer_timeout():
	get_parent().game_manager.game_over()
	pass # Replace with function body.


func _on_screen_exited():
	leftScreen = true
	pass # Replace with function body.
