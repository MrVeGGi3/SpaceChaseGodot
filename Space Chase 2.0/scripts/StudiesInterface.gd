extends Control


@export var botanics_interface : Control
@export var mechanics_interface : Control
@export var electronics_interface : Control


@onready var studies_label: Label = $StudiesLabel
@onready var voltar: Button = $Voltar

func _unhandled_input(event: InputEvent) -> void:
	if visible:
		if event is InputEventKey:
			if event.keycode == KEY_ESCAPE and event.pressed:
				GameManager.is_paused = false
				hide()

func _process(delta: float) -> void:
	studies_label.text = tr("STUDIES_TITLE")
	voltar.text = tr("BACK_HIDE")
	
func _on_metalurgic_button_pressed() -> void:
	mechanics_interface.show()
	hide()

func _on_botanics_button_pressed() -> void:
	botanics_interface.show()
	hide()

func _on_electronic_button_pressed() -> void:
	electronics_interface.show()
	hide()

func _on_voltar_pressed() -> void:
	hide()
