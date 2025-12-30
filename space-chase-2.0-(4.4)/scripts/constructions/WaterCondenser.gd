class_name WaterCondenser
extends Construction

@onready var water_collect_button: Button = $WaterCollect
@onready var water_earnt : float
@onready var maximum_water : float = 20.0
@onready var minimum_water_to_collect : float = 5.0
const WATER_GENERATED_PER_MINUTE = 0.007

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material_collect_button = water_collect_button
	set_initial_nodes($WaterConstructionButton, $WaterCondenserProgressBar, $Area2D)
	set_initial_status(3200, 20.0, 14000.0, 100.0)
	hide_construction_UI()
	decrease_time_with_bonus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_button_mode()
	check_water_condition()
	
	if is_in_construction:
		check_time_to_construct()
		time_constructed += delta * GameManager.boost_construction
		
	elif is_constructed:
		check_time_to_manutence()
		water_earnt += WATER_GENERATED_PER_MINUTE * delta
		time_to_go_manutence += delta 
	
	elif is_broken:
		if is_being_fixed:
			check_time_to_fix()
			time_to_fix += GameManager.boost_construction * delta

func check_water_condition():
	if water_earnt >= minimum_water_to_collect:
		material_collect_button.show()
		
	if water_earnt >= maximum_water:
		water_earnt = maximum_water



func _on_water_construction_button_pressed() -> void:
	construction_button_pressed()

func _on_area_2d_body_entered(body: Player) -> void:
	player_entered_area()

func _on_area_2d_body_exited(body: Player) -> void:
	player_exited_area()

func _on_water_collect_pressed() -> void:
	GameManager.water += water_earnt
	water_earnt = 0.0
	material_collect_button.hide()
