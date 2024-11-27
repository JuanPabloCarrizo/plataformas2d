extends Area2D

@onready var timer: Timer = $Timer
@onready var killzone_sound: AudioStreamPlayer2D = $KillzoneSound

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not body.is_dead:
		body.die()  # Llama al método die() del jugador
		killzone_sound.play()  # Reproducir sonido si corresponde
		print("Jugador murió por KillZone")
