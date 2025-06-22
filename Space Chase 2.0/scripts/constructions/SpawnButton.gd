extends Control


@onready var cons_robot_build: Button = $ConsRobotBuild
@onready var miner_robot_build: Button = $MinerRobotBuild
@onready var water_condenser_build: Button = $WaterCondenserBuild
@onready var hidroponics_build: Button = $HidroponicsBuikd
@onready var sintetizor_build: Button = $SintetizorBuild
@onready var solar_panel_build: Button = $SolarPanelBuild



func _on_cons_robot_build_pressed() -> void:
	if GameManager.fix_robots < GameManager.max_fix_robots:
		InstantiateConstructionsManager.build_item(0)
	else:
		disable_button(cons_robot_build)
		
func _on_miner_robot_build_pressed() -> void:
	if GameManager.miner_robots < GameManager.max_miner_robots:	
		InstantiateConstructionsManager.build_item(1)
	else:
		disable_button(miner_robot_build)

func _on_water_condenser_build_pressed() -> void:
	if GameManager.has_water_cond:
		disable_button(water_condenser_build)
	InstantiateConstructionsManager.build_item(2)

func _on_hidroponics_buikd_pressed() -> void:
	if GameManager.hidroponics < GameManager.max_hidroponics:
		InstantiateConstructionsManager.build_item(3)
	else:
		disable_button(hidroponics_build)
		
func _on_sintetizor_build_pressed() -> void:
	if GameManager.has_sint:
		disable_button(sintetizor_build)
	else:
		InstantiateConstructionsManager.build_item(4)

func _on_solar_panel_build_pressed() -> void:
	if GameManager.solar_panel < GameManager.max_solar_panel:
		InstantiateConstructionsManager.build_item(5)
	else:
		disable_button(solar_panel_build)
		
func disable_button(button : Button):
	button.disabled = true
	button.text = "Construído"
