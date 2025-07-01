extends Control

@onready var game_type_labels = [$"../Save1/GameType", $"../Save2/GameType", $"../Save3/GameType"]
@onready var last_time_labels = [$"../Save1/LastTimeContainer/LastTime Played",
								$"../Save2/LastTimeContainer/LastTime Played",
								$"../Save3/LastTimeContainer/LastTime Played"]

@onready var confirm: Button = $"../SaveLoadWindow/Confirm"
@onready var cancel: Button = $"../SaveLoadWindow/Cancel"


func set_game_type_text():
	for label in last_time_labels:
		label.text = tr("LAST_TIME_PLAY")
		
func _process(delta: float) -> void:
	confirm.text = tr("YES_WINDOW_CONFIRM")
	cancel.text = tr("NO_WINDOW_CONFIRM")
	set_game_type_text()
