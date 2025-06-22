class_name SolarPanel
extends Construction

const ENERGY_GENERATED_PER_MINUTE = 0.15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_initial_nodes($SolarPanelButton, $SolarPanelProgressBar, $Area2D)
	set_initial_status(360, 22, 10000, 100)
	hide_construction_UI()
	decrease_time_with_bonus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_button_mode()
	
	if is_in_construction:
		check_time_to_construct()
		time_constructed += delta * GameManager.boost_construction
		
	elif is_constructed:
		check_time_to_manutence()
		check_energy_catch_status(delta)
		time_to_go_manutence += delta 
	
	elif is_broken:
		if is_being_fixed:
			check_time_to_fix()
			time_to_fix += GameManager.boost_construction * delta
	
func check_energy_catch_status(delta : float):
	if GameManager.hour >= 06 and GameManager.hour < 18:
		GameManager.energy += ENERGY_GENERATED_PER_MINUTE * delta
	elif GameManager.hour >= 18 and GameManager.hour < 24:
		return
	elif GameManager.hour >= 0 and GameManager.hour < 6:
		return
	


func _on_area_2d_body_entered(body: Player) -> void:
	player_entered_area()

func _on_area_2d_body_exited(body: Player) -> void:
	player_exited_area()

func _on_solar_panel_button_pressed() -> void:
	construction_button_pressed()
