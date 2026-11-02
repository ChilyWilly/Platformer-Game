extends StaticBody2D

@onready var door: StaticBody2D = $Door


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.score_reached.connect(_on_score_reached)
	
func _on_score_reached():
	door.queue_free()
