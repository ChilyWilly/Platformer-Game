extends Control

@onready var timer: Label = $Time


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.text = "TIME: " + str(GameManager.time) + " SECONDS"
