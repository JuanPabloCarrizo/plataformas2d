extends Area2D

@onready var timer: Timer = $Timer
@onready var killzone_sound: AudioStreamPlayer2D = $KillzoneSound


func _on_body_entered(body: Node2D) -> void:
	print("You DIED!") # Replace with function body.
	killzone_sound.play()
	Engine.time_scale = 0.5	
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
