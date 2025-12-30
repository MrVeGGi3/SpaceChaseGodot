extends Control
@onready var go_out_button: Button = $"../HBoxContainer/GoOutButton"
@onready var go_cabin_button: Button = $"../HBoxContainer/GoCabinButton"

func _process(delta: float) -> void:
	go_cabin_button.text = tr("COCKPIT_GO")
	go_out_button.text = tr("GO_OUT_BUTTON")
