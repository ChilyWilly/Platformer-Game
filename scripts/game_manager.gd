extends Node2D

signal score_reached

var score = 0

@onready var game_score: Label = %GameScore

func score_change():
	score += 1
	game_score.text = "Score: " + str(score)
	
	if score == 4:
		score_reached.emit()
