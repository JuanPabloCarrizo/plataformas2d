extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

#Acá traigo la gravedad del proyecto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_jump: AudioStreamPlayer2D = $PlayerJump



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		player_jump.play() # Reproducir sonido de salto

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
		#Get the input direction: -1,0 or 1

	var direction := Input.get_axis("player_left", "player_right")
	
	#flip
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	#play animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")	
	else:
		if direction != 0:
			animated_sprite.play("jump_side")
			#player_jump.play()
		else:
			animated_sprite.play("jump_up")
			#player_jump.play()

		
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
