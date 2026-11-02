extends Node2D

@onready var game_manager: Node2D = $"../GameManager"


# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.score_reached()
