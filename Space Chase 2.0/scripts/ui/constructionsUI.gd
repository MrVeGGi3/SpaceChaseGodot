extends Node2D

@export_category("Quantity Labels")
@onready var construct_quantity_label: Label = $ConsertRobotContainer/ConsertRobotDesc/ConstructQuantityLabel
@onready var miner_quantity_label: Label = $MinerRobotContainer/MinerRobotContainer/MinerQuantityLabel
@onready var water_quantity_label: Label = $WaterCondenserContainer/WaterCondenser/Condenser/WaterQuantityLabel
@onready var hidro_quantity_label: Label = $HidroponicContainer/Hidroponic/HidroQuantityLabel
@onready var sint_quantity_label: Label = $Sintetizator/Sintetizator/SintQuantityLabel
@onready var solar_quantity_label: Label = $SolarPanelContainer/SolarPanel/SolarQuantityLabel

@export_category("Status")
@onready var consert_status: Label = $ConsertRobotContainer/ConsertRobotDesc/Status/ConsertStatus
@onready var miner_status: Label = $MinerRobotContainer/MinerRobotDesc/Status/MinerStatus
@onready var water_status: Label = $WaterCondenserContainer/WaterCondenserDesc/Status/WaterStatus
@onready var hidro_status: Label = $HidroponicContainer/HidroDesc/Status/HidroStatus
@onready var sint_status: Label = $Sintetizator/SintDesc/Status/SintStatus
@onready var solar_status: Label = $SolarPanelContainer/SolarPanelDesc/Status/SolarStatus

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	construct_quantity_label.text = "%d / %d" % [GameManager.fix_robots, GameManager.max_fix_robots]
	miner_quantity_label.text = "%d / %d " % [GameManager.miner_robots, GameManager.max_miner_robots]
	water_quantity_label.text = ""
	hidro_quantity_label.text = "%d / $d " % [GameManager.hidroponics, GameManager.max_hidroponics]
	sint_quantity_label.text = ""
	solar_quantity_label.text = " %d / %d" % [GameManager.solar_panel, GameManager.max_solar_panel]
	
	
	consert_status.text = str(GameManager.fix_robot_status)
	consert_status.font_color = GameManager.set_color_status(GameManager.fix_robot_status)
	
	miner_status.text = str(GameManager.miner_robot_status)
	miner_status.font_color = GameManager.set_color_status(GameManager.miner_robot_status)
	
	water_status.text = str(GameManager.water_condenser_status)
	water_status.font_color = GameManager.set_color_status(GameManager.water_condenser_status)
	
	hidro_status.text = str(GameManager.hidroponics_status)
	hidro_status.font_color = GameManager.set_color_status(GameManager.hidroponics_status)
	
	sint_status.text = str(GameManager.sintetizer_status)
	sint_status.font_color = GameManager.set_color_status(GameManager.sintetizer_status)

	solar_status.text = str(GameManager.solar_panel_status)
	solar_status.font_color = GameManager.set_color_status(GameManager.solar_panel_status)
