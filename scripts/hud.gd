extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var game_manager: Node = %GameManager
@onready var level_complete: Label = $Control/LevelComplete
@onready var play_button: Button = $Control/PlayButton
@onready var exit_button: Button = $Control/ExitButton  # Referencia al nuevo botón
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $Control/AudioStreamPlayer2D

func _ready() -> void:
	# Conectar las señales utilizando Callable
	game_manager.connect("score_updated", Callable(self, "_on_score_updated"))
	game_manager.connect("level_completed", Callable(self, "_on_level_completed"))

	# Inicialmente, oculta el control de nivel completado
	level_complete.visible = false
	play_button.visible = false
	exit_button.visible = false

	# Conectar el botón de Play solo si no está conectado previamente
	if not play_button.is_connected("pressed", Callable(self, "_on_play_button_pressed")):
		play_button.connect("pressed", Callable(self, "_on_play_button_pressed"))

	# Conectar el botón de Salir solo si no está conectado previamente
	if not exit_button.is_connected("pressed", Callable(self, "_on_exit_button_pressed")):
		exit_button.connect("pressed", Callable(self, "_on_exit_button_pressed"))

func _on_score_updated(score: int) -> void:
	score_label.text = "%d/17" % score

func _on_level_completed() -> void:
	audio_stream_player_2d.play()
	get_tree().paused = true
	level_complete.visible = true
	play_button.visible = true
	exit_button.visible = true

func _on_play_button_pressed() -> void:
	print("entro al play button")
	# Reinicia el nivel
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_exit_button_pressed() -> void:
	print("Saliendo del juego...")
	get_tree().quit()  # Cierra la aplicación
