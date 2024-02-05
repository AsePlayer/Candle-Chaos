extends Node2D
class_name GamesManager

@onready var player: CharacterBody2D = $"../Player"
@onready var enemies = $"../Enemies"

@export var save_game: SavesGame

@onready var transition = $"../Transition"
@onready var animation_player : AnimationPlayer = $"../Transition/AnimationPlayer"
@onready var texture_rect = $"../TextureRect"

var swappingScreen = false
var gameOver = false


# Called when the node enters the scene tree for the first time.
func _ready():
	transition.visible = true
	save_game.score = 0
	animation_player.play("open")
	animation_player.pause()
	$Timer.start()

	$"../GameOverUI".visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not gameOver:
		save_game.score = save_game.swaps * (save_game.enemies1 + save_game.enemies2) + save_game.stars
		$"../Label".text = "Score:\n" + str(save_game.score)
		pass
	else:
		$"../Label".text = ""
		$"../GameOverUI".visible = true
		$"../GameOverUI/ScoreLabel".text = "Final Score:\n" + str(save_game.score)
	pass

func change_screen(scene):
	animation_player.play("close")
	await animation_player.animation_finished
	save_game.add_swap()
	print("Changed scene to: " + scene)
	get_tree().change_scene_to_file("res://Scenes/" + scene + ".tscn")
	pass

func swap_screen():
	swappingScreen = true
	if get_tree().current_scene.name == "menu":
		change_screen("world1")
	if get_tree().current_scene.name == "world1":
		change_screen("world2")
	if get_tree().current_scene.name == "world2":
		change_screen("world1")
	pass
	
func get_current_scene_name() -> String:
	return get_tree().current_scene.name

func _on_timer_timeout():
	animation_player.play("open")
	pass # Replace with function body.

func game_over():
	gameOver = true
	texture_rect.set_process(false)
	for enemy in enemies.get_children():
		enemy.canMove = false
	player.set_collision_mask_value(1, false)
	save_game.enemies1 = 0
	save_game.enemies2 = 0
	save_game.swaps = 0
	save_game.stars = 0
	pass


func _on_retry_button_button_down():
	change_screen("world1")
	pass # Replace with function body.


func _on_main_menu_button_button_down():
	change_screen("menu")
	pass # Replace with function body.


func _on_jame_game_logo_button_button_down():
	OS.shell_open("https://itch.io/jam/jame-gam-36")
	pass # Replace with function body.
