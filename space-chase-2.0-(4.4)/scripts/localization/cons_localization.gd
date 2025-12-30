extends Control

@onready var cons_title: Label = $"../Title"

@onready var robot_fix_title_label: Label = $"../ConsertRobotContainer/ConsertRobotDesc/ConstructRobotTitleLabel"
@onready var robot_fix_description: Label = $"../ConsertRobotContainer/ConsertRobotDesc/Description"

@onready var miner_robot_title: Label = $"../MinerRobotContainer/MinerRobotDesc/MinerRobotTitleLabel"
@onready var miner_description: Label = $"../MinerRobotContainer/MinerRobotDesc/MinerDescription"

@onready var water_condenser_title_label: Label = $"../WaterCondenserContainer/WaterCondenserDesc/WaterCondenserTitleLabel"
@onready var water_description: Label = $"../WaterCondenserContainer/WaterCondenserDesc/WaterDescription"

@onready var hidro_title_label: Label = $"../HidroponicContainer/HidroDesc/HidroTitleLabel"
@onready var hidro_description: Label = $"../HidroponicContainer/HidroDesc/HidroDescription"

@onready var sint_title_label: Label = $"../Sintetizator/SintDesc/SintTitleLabel"
@onready var sint_description: Label = $"../Sintetizator/SintDesc/SintDescription"

@onready var solar_title_label: Label = $"../SolarPanelContainer/SolarPanelDesc/SolarTitleLabel"
@onready var solar_description: Label = $"../SolarPanelContainer/SolarPanelDesc/SolarDescription"

func _process(delta: float) -> void:
	cons_title.text = tr("CONS_TITLE")
	
	robot_fix_title_label.text = tr("CONS_FIX_ROBOT")
	robot_fix_description.text = tr("FIX_ROBOT_DESCRIPTION")
	
	miner_robot_title.text = tr("CONS_MINER_ROBOT")
	miner_description.text = tr("CONS_MINER_DES")
	
	water_condenser_title_label.text = tr("CONS_WATER_CONDENSER")
	water_description.text = tr("CONS_WATER_COND_DES")
	
	hidro_title_label.text = tr("CONS_HIDROPONIC")
	hidro_description.text = tr("CONS_HIDROPONIC_DES")
	
	sint_title_label.text = tr("CONS_SYNTETIZOR")
	sint_description.text = tr("CONS_SYNTETITOR_DES")
	
	solar_title_label.text = tr("CONS_SOLAR_PANEL")
	solar_description.text = tr("CONS_SOLAR_PANEL")
	
	
