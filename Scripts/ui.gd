extends Node2D

@onready var play_button = $PlayButton
@onready var game_manager : GamesManager = $"../GameManager"
@onready var player = $"../Player"
@onready var controls_ui:Node2D = $"../ControlsUI"


# Called when the node enters the scene tree for the first time.
func _ready():
	player.canMove = false
	pass # Replace with function body.


func _on_play_button_button_down():
	game_manager.swap_screen()
	pass # Replace with function body.


func _on_how_to_play_button_button_down():
	controls_ui.visible = !controls_ui.visible
	pass # Replace with function body.
