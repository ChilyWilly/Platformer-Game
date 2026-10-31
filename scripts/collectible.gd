extends Area2D

@onready var game_manager: Node2D = $"../../../GameManager"


func _on_body_entered(body: Node2D) -> void:
	game_manager.score_change()
	queue_free()
