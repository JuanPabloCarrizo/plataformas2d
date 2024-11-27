extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Traer la gravedad del proyecto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_jump: AudioStreamPlayer2D = $PlayerJump

var is_dead = false

signal player_died  # Señal para indicar que el jugador ha muerto

func _ready():
	# Asegúrate de que KillScreen esté presente en el árbol de nodos y usa Callable
	var kill_screen = get_tree().root.get_node("KillScreen")
	if kill_screen:
		connect("player_died", Callable(kill_screen, "_on_player_died"))
	else:
		print("KillScreen no encontrado en el árbol de nodos")


func die():
	if is_dead:
		return  # Evitar múltiples muertes
	is_dead = true
	velocity = Vector2.ZERO  # Detener el movimiento
	animated_sprite.play("diying")  # Cambiar a la animación de muerte (si existe)
	print("El jugador ha muerto")
	emit_signal("player_died")  # Emitir la señal de muerte

func _physics_process(delta: float) -> void:
	if is_dead:
		return  # No procesar lógica si está muerto

	# Gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Saltar
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		player_jump.play()

	# Movimiento horizontal
	var direction := Input.get_axis("player_left", "player_right")

	# Flip y animaciones
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if direction != 0:
			animated_sprite.play("jump_side")
		else:
			animated_sprite.play("jump_up")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
