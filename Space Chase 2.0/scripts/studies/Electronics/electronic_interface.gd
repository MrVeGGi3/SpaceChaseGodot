class_name ElectronicStudiesUI
extends StudiesUI


func _ready() -> void:
	interface_type = "Electronics"
	set_initial_status()
	set_text_nodes($ActualLevelEffects/ActualUpgrade,$LevelEffects/NextUpgrade, $LevelNumber)
	set_progress_nodes($FocusBoostBar, $ExperienceBar)
	set_buttons($StudyButton, $LevelButton)
	set_effects_nodes($LevelEffects, $ActualLevelEffects)
	hide_effects()
	
func _process(delta: float) -> void:
	_set_bonus_electronic_gain_per_level()
	adjust_bars(delta)
	see_buttons_hovered()
	show_upgrades_bars()
	
	if actual_experience >= level_experience_upgrade:
		_upgrade_level()


func _on_voltar_pressed() -> void:
	hide()
	studies_ui.show()
