extends Node2D

var score = 0
var time = 0

@onready var game_score: Label = $HUD/Labels/GameScore
@onready var door: StaticBody2D = $Door


func score_change():
	score += 1
	game_score.text = "SCORE: " + str(score)
	score_reached()
	

func _process(delta: float) -> void:
	time += 1


func score_reached():
	if score >=6:
		door.queue_free()
