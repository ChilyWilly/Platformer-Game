extends Node2D

var score = 0
var last_checkpoint_position : Vector2 = Vector2.ZERO
var current_checkpoint: Area2D = null

@onready var game_score: Label = %GameScore

func score_change():
	score += 1
	game_score.text = "Score: " + str(score)
	
func update_checkpoint(new_checkpoint: Vector2) -> void:
	pass
	
