class_name MechanicsStudiesUI
extends StudiesUI


func _ready() -> void:
	set_initial_status()
	set_text_nodes($ActualLevelEffects/ActualUpgrade, $LevelEffects/NextUpgrade, $LevelNumber)
	set_progress_nodes($FocusBoostBar, $ExperienceBar)
	set_buttons($StudyButton, $LevelButton)
	set_effects_nodes($LevelEffects, $ActualLevelEffects)
	
func _process(delta: float) -> void:
	_set_bonus_metal_gain_per_level()
	adjust_bars(delta)
	see_buttons_hovered()
	
	if actual_experience >= level_experience_upgrade:
		_upgrade_level()

	

func _on_voltar_pressed() -> void:
	hide()
	studies_ui.show()
