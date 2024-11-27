extends CanvasLayer

@onready var panel: Panel = $Control/Panel
@onready var timer: Timer = $Control/Panel/Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $Control/Panel/AudioStreamPlayer2D

func _ready() -> void:
	# Asegurarse de que el panel esté oculto inicialmente
	panel.visible = false
	
	# Asegúrate de que el panel y el botón no bloqueen clics
	panel.mouse_filter = Control.MOUSE_FILTER_PASS  # El panel no debe bloquear el clic en el botón

func _on_player_died() -> void:
	if not panel.visible:  # Solo activar si no está visible
		print("Activando KillScreen")
		audio_stream_player_2d.play()
		panel.visible = true  # Mostrar la pantalla de muerte
		timer.start(2)  # Iniciar el temporizador de 3 segundos

# Función que se llama cuando el temporizador termina
func _on_timer_timeout() -> void:
	panel.visible = false
	print("3 segundos pasaron, reiniciando la escena...")
	get_tree().reload_current_scene()  # Recargar la escena después de 3 segundos
