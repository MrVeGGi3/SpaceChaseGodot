extends Control

@export_category("Quantity Labels")
@onready var construct_quantity_label: Label = $ConsertRobotContainer/ConsertRobotDesc/ConstructQuantityLabel
@onready var miner_quantity_label: Label = $MinerRobotContainer/MinerRobotContainer/MinerQuantityLabel
@onready var water_quantity_label: Label = $WaterCondenserContainer/WaterCondenser/Condenser/WaterQuantityLabel
@onready var hidro_quantity_label: Label = $HidroponicContainer/Hidroponic/HidroQuantityLabel
@onready var sint_quantity_label: Label = $Sintetizator/Sintetizator/SintQuantityLabel
@onready var solar_quantity_label: Label = $SolarPanelContainer/SolarPanel/SolarQuantityLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if visible:
		if event is InputEventKey:
			if event.keycode == KEY_ESCAPE and event.pressed:
				GameManager.is_paused = false
				hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	construct_quantity_label.text = "%d / %d" % [GameManager.fix_robots, GameManager.max_fix_robots]
	miner_quantity_label.text = "%d / %d" % [GameManager.miner_robots, GameManager.max_miner_robots]
	water_quantity_label.text = ""
	hidro_quantity_label.text = "%d / %d " % [GameManager.hidroponics, GameManager.max_hidroponics]
	sint_quantity_label.text = ""
	solar_quantity_label.text = "%d / %d" % [GameManager.solar_panel, GameManager.max_solar_panel]
	
