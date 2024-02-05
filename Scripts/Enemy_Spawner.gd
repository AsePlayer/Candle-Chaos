extends Node2D

@export var enemy_list:Array = [PackedScene]
#@export var enemy:PackedScene
var viewport_rect = 0
var enemy_size = Vector2(150, 150)  # Replace with the actual size of your enemy

@export var spawnRate:float = 5.0
@onready var enemy_timer = $"../EnemyTimer"
@onready var game_manager:GamesManager = $"../GameManager"

var spawnEnemies = true

func get_current_scene_name() -> String:
	return get_tree().current_scene.name
	
func _ready():
	var enemies_to_spawn = 0
	if game_manager.get_current_scene_name() == "world1":
		enemies_to_spawn = game_manager.save_game.enemies1
		pass
	if game_manager.get_current_scene_name() == "world2":
		enemies_to_spawn = game_manager.save_game.enemies2
		
	while enemies_to_spawn > 0:
		spawn_enemy()
		enemies_to_spawn -= 1

	
	viewport_rect = get_viewport_rect().size.x
	enemy_timer.start()

func spawn_enemy() -> void:
	# Spawn the enemies in enemy_list
	for enemy in enemy_list:
		enemy = enemy.instantiate() # Pick enemy spawn position
		enemy.position = get_random_spawn_position() # Add the enemy to the scene
		add_child(enemy)
		
	# Speed up spawnrate
	if spawnRate > 1:
		spawnRate = spawnRate / 1.1
	else:
		spawnRate = 1
	
	# Adjust timer
	enemy_timer.wait_time = spawnRate
	print("Spawned new enemies. New spawn time of " + str(spawnRate))

func get_random_spawn_position() -> Vector2:
	var spawn_pos = Vector2(
		randi_range(-700, 700),
		randi_range(-700, 700)
	)
	while abs(spawn_pos.x) < 500:
		if spawn_pos.x > 0:
			spawn_pos.x += 10
		else:
			spawn_pos.x -= 10
			
	while abs(spawn_pos.y) < 400:
		if spawn_pos.y > 0:
			spawn_pos.y += 10
		else:
			spawn_pos.y -= 10		
	
	return spawn_pos


func _on_enemy_timer_timeout():
	if game_manager.gameOver:
		print("GAME OVER")
		enemy_timer.stop()
		return
		
	if game_manager.get_current_scene_name() == "world1":
		game_manager.save_game.enemies1 += 1

	if game_manager.get_current_scene_name() == "world2":
		game_manager.save_game.enemies2 += 1
		
	spawn_enemy()
	pass # Replace with function body.
