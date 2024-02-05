extends Resource
class_name SavesGame

const SAVE_GAME_PATH := "user://savegame.tres"

@export var swaps: int
@export var enemies1: int = 0
@export var enemies2: int = 0
@export var score: int = 0
@export var stars: int = 0

@export var muteMusic:bool = false
@export var muteSfx:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	load_save()
	pass # Replace with function body.

func add_swap():
	swaps += 1
	write_save()
	print(swaps)
	
func add_enemies_world_1():
	enemies1 += 1
	pass

func add_enemies_world_2():
	enemies2 += 1
	pass
	
func write_save() -> void:
	ResourceSaver.save(self, SAVE_GAME_PATH)

func load_save() -> Resource:
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH)
	print("NO SAVE DETECTED")
	return null
