extends Control


@export var botanics_interface : Control
@export var mechanics_interface : Control
@export var electronics_interface : Control




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
