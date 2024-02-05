extends AudioStreamPlayer

@onready var game_manager: GamesManager = $"../GameManager"
var music_off:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if game_manager.gameOver:
		if music_off:
			pitch_scale = 0.001
			return
		
		if pitch_scale > 0.001:
			pitch_scale -= delta
		else:
			music_off = true
	pass
