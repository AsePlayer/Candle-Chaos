extends TextureRect
@onready var game_manager = $"../GameManager"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x = (game_manager.player.global_position.x - 10 * size.x) / 15 - 250
	global_position.y = (game_manager.player.global_position.y - 10 * size.y) / 15 - 150
	pass
