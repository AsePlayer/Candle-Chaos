extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -900.0
@onready var sprite_2d = $Sprite2D
@onready var game_manager: GamesManager = $"../GameManager"

@onready var candle: AnimatedSprite2D = $Candle

@export var candle_color:String
var cache_candle_color:String
@onready var candle_audio: AudioStreamPlayer2D = $CandleAudio
@onready var audio = $OtherAudio

var blow_audio = preload("res://Sounds/Fast Mouth Blow.ogg")

var candle_blown_out:bool = false

var coyote_time = 15
var coyote_timer = 0

var last_direction
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var canMove:bool = true

func _ready():
	if game_manager.get_current_scene_name() != "menu":
		cache_candle_color = candle_color
		candle_color = "no"
	
func _physics_process(delta):
	$Candle/ProgressBar.value = 100 - ($Candle/CooldownTimer.time_left / $Candle/CooldownTimer.wait_time) * 100
	if candle_color != "":
		candle.play(candle_color + "_candle")
	# Animations
	if (velocity.x > 1 or velocity.x < -1):
		sprite_2d.play("walk")
	else:
		sprite_2d.play("idle")
		
	if not canMove:
		return
		
	if Input.is_action_just_pressed("teleport") and candle_color != "no" and not game_manager.gameOver:
		candle_color = "no"
		candle_blown_out = true
		candle_audio.stream = blow_audio
		candle_audio.play()
		$Candle/Timer.start()
	

	
	# Add the gravity.
	if not is_on_floor():
		# Start coyote time
		if coyote_timer < coyote_time:
			coyote_timer += 1
		
		# Update gravity
		velocity.y += gravity * delta

		if velocity.y > 0:
			sprite_2d.play("up")

		else:
			sprite_2d.play("up")
	else:
		coyote_timer = 0  # Reset coyote timer on the ground
		sprite_2d.rotation_degrees = 0

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_timer < coyote_time):
		if candle_blown_out:
			candle_blown_out = false
			return
		audio.play()
		velocity.y = JUMP_VELOCITY
		coyote_timer = coyote_time


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
		last_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	move_and_slide()
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
	
	if sprite_2d.animation == "up":
		if isLeft or (direction == 0 and last_direction == -1):
			sprite_2d.rotation_degrees = clamp(sprite_2d.rotation_degrees - 10, -180, 180)
		else:
			sprite_2d.rotation_degrees = clamp(sprite_2d.rotation_degrees + 10, -180, 180)


func _on_timer_timeout():
	if not game_manager.gameOver:
		game_manager.swap_screen()
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("enemy"):
		game_manager.game_over()
	if area.get_parent().is_in_group("star"):
		game_manager.save_game.stars += 1
	pass # Replace with function body.


func _on_cooldown_timer_timeout():
	candle_color = cache_candle_color
	print("candle ready")
	pass # Replace with function body.
