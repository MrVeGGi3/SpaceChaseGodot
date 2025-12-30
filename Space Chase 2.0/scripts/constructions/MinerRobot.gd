class_name MinerRobot
extends Construction

@onready var iron_earnt : float = 0.0
@export var maximum_iron_to_collect : float = 20.0
@export var minimum_iron_to_collect : float = 5.0
var iron_generated_per_minute = randf_range(0.15, 1.66)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material_collect_button = $CatchIronButton
	set_initial_nodes($MinerConstructButton,$MinerProgressBar, $Area2D)
	set_initial_status(7200, 100, 20000, 500)
	hide_construction_UI()
	decrease_time_with_bonus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_button_mode()
	check_iron_condition()
	
	if is_in_construction:
		check_time_to_construct()
		time_constructed += delta * GameManager.boost_construction
		
	elif is_constructed:
		check_time_to_manutence()
		iron_earnt += iron_generated_per_minute * delta
		time_to_go_manutence += delta 
	
	elif is_broken:
		if is_being_fixed:
			check_time_to_fix()
			time_to_fix += GameManager.boost_construction * delta
	
	


func _on_miner_construct_button_pressed() -> void:
	construction_button_pressed()
	
func _on_catch_iron_button_pressed() -> void:
	GameManager.iron += iron_earnt
	iron_earnt = 0.0
	material_collect_button.hide()


func _on_area_2d_body_entered(body: Player) -> void:
	player_entered_area()
	
func _on_area_2d_body_exited(body: Player) -> void:
	player_exited_area()

func check_iron_condition():
	if iron_earnt >= minimum_iron_to_collect:
		material_collect_button.show()
		
	if iron_earnt >= maximum_iron_to_collect + GameManager.bonus_metal_increase:
		iron_earnt = maximum_iron_to_collect
