extends Node2D

var timer_time = 10

@onready var time: Label = $GameManager/HUD/Labels/Time
@onready var death_timer: Timer = $GameManager/Timers/DeathTimer
@onready var time_tracker: Timer = $GameManager/Timers/TimeTracker


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time.text = "Time: " + str(timer_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_death_timer_timeout() -> void:
	get_tree().reload_current_scene()


func _on_time_tracker_timeout() -> void:
	timer_time -= 1
	time.text = "Time: " + str(timer_time)
