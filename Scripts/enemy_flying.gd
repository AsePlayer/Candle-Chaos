extends CharacterBody2D


const SPEED = 100.0
const GHOST_SPEED = 50.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var game_manager = $"../../GameManager"
var player_pos
var target_pos

var canMove:bool = true;

var fadeDir:int = 1

@export var isGhost:bool

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	animated_sprite_2d.play("default")
	if not canMove:
		return
	player_pos = game_manager.player.position
	target_pos = (player_pos - position).normalized()
	
	if not isGhost:
		if position.distance_to(player_pos) > 0:
			velocity = (target_pos * SPEED)
			move_and_slide()
	else:
		if $AnimatedSprite2D.modulate.a > 0.8 or $AnimatedSprite2D.modulate.a < 0.05:
			fadeDir *= -1
		$AnimatedSprite2D.modulate.a += 0.025 * fadeDir / 2
		velocity = (target_pos * GHOST_SPEED)
		$AnimatedSprite2D.flip_h = velocity.x > 0
		move_and_slide()
