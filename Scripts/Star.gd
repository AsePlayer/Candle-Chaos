extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	position = $"../StarSpawnPoints".get_children().pick_random().global_position
	pass # Replace with function body.

func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("player"):
		$AudioStreamPlayer2D.play()
		var newPos = $"../StarSpawnPoints".get_children().pick_random().global_position
		while newPos == position:
			newPos = $"../StarSpawnPoints".get_children().pick_random().global_position

		position = newPos
