class_name Hidroponic
extends Construction

@onready var organics_earnt : float = 0.0
@export var max_organics_collect : float  = 14.0
@export var min_organics_collect: float = 2.0
const ORGANICS_GENERATED_PER_MINUTE = 0.003

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material_collect_button = $OrganicsEarnt
	set_initial_nodes($HidroponicsButton, $HidroponicsProgressBar, $Area2D)
	set_initial_status(60, 10, 20000, 20)
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
		check_organics_condition()
		organics_earnt += ORGANICS_GENERATED_PER_MINUTE * delta
		time_to_go_manutence += delta 
	
	elif is_broken:
		if is_being_fixed:
			check_time_to_fix()
			time_to_fix += GameManager.boost_construction * delta

func check_organics_condition():
	if organics_earnt >= min_organics_collect:
		material_collect_button.show()
		
	if organics_earnt >= max_organics_collect + GameManager.bonus_organic_increase:
		organics_earnt = max_organics_collect


func _on_area_2d_body_entered(body: Player) -> void:
	player_entered_area()


func _on_area_2d_body_exited(body: Player) -> void:
	player_exited_area()


func _on_hidroponics_button_pressed() -> void:
	construction_button_pressed()

func _on_organics_earnt_pressed() -> void:
	GameManager.organics += organics_earnt
	print("Coletei os Orgânicos")
	organics_earnt = 0.0
	material_collect_button.hide()
