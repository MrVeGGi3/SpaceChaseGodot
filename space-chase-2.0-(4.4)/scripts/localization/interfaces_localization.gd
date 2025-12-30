extends Control

@onready var interfaces_back_buttons = [$"../BotanicsInterface/Voltar", $"../MechanicsInterface/Voltar",
										$"../ElectronicInterface/Voltar"]

@onready var actual_level_labels = [$"../BotanicsInterface/ActualLevelEffects/Upgrades", 
								$"../MechanicsInterface/ActualLevelEffects/Upgrades",
								 $"../ElectronicInterface/ActualLevelEffects/Upgrades"]

@onready var next_level_labels = [$"../BotanicsInterface/LevelEffects/Label",
									$"../MechanicsInterface/LevelEffects/Label", 
									$"../ElectronicInterface/LevelEffects/Label"]
func _set_back_buttons_text():
	for button in interfaces_back_buttons:
		button.text = tr("BACK_HIDE")
func _set_actual_up_labels():
	for label in actual_level_labels:
		label.text = tr("ACTUAL_UPGRADE")
func _set_next_level_labels():
	for label in next_level_labels:
		label.text = tr("NEXT_LVL_UPGRADE")

func _process(delta: float) -> void:
	_set_actual_up_labels()
	_set_back_buttons_text()
	_set_next_level_labels()		
	
