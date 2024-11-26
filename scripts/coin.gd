extends Area2D
#Click derecho en el arbol a GameManager, elegir %Access as Unique Name
#Luego arrastrarlo y pegarlo acá con Ctrl.
#Esto solo funciona si el GameManager y las Coins están en la misma escena!!!!!

#@onready var game_manager: Node = %GameManager





func _on_body_entered(body: Node2D) -> void:
	print("plus 1")
	queue_free()
