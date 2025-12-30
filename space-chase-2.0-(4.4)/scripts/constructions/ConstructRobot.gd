class_name ConstructRobot
extends Construction


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_initial_nodes($ConstructFixButton, $RobotProgressBar, $RobotArea2D)
	set_initial_status(7200.00, 100.00, 8000.0, 100.00)
	hide_construction_UI()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_button_mode()
	
	if is_in_construction:
		check_time_to_construct()
		time_constructed += delta * GameManager.boost_construction
		
	elif is_constructed:
		check_time_to_manutence()
		time_to_go_manutence += delta 
	
	elif is_broken:
		if is_being_fixed:
			check_time_to_fix()
			time_to_fix += GameManager.boost_construction * delta
		
func _on_robot_area_2d_body_entered(body: Player) -> void:
	player_entered_area()
	
func _on_robot_area_2d_body_exited(body: Player) -> void:
	player_exited_area()

func _on_construct_fix_button_pressed() -> void:
	construction_button_pressed()
