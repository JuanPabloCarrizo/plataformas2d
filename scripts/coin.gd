extends Area2D
#Click derecho en el arbol a GameManager, elegir %Access as Unique Name
#Luego arrastrarlo y pegarlo acá con Ctrl.
#Esto solo funciona si el GameManager y las Coins están en la misma escena!!!!!
@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point()
	#queue_free()
	animation_player.play("pickup")
