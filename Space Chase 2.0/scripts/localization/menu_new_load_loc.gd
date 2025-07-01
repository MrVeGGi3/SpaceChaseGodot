extends Control
@onready var select_slot: Label = $"../SelectSlot"
@onready var game_type_labels = [$"../Save1/GameType", $"../Save2/GameType", $"../Save3/GameType"]
@onready var last_time_labels = [$"../Save1/LastTimeContainer/LastTime Played",
								$"../Save2/LastTimeContainer/LastTime Played",
								$"../Save3/LastTimeContainer/LastTime Played"]


func set_game_type_text():
	for label in last_time_labels:
		label.text = tr("LAST_TIME_PLAY")
		
func _process(delta: float) -> void:
	select_slot.text = tr("SELECT_SLOT")
	set_game_type_text()
