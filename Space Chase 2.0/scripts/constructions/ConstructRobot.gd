class_name ConstructRobot
extends Construction

var is_allocated : bool = false
var time_decrease : float = 0.25
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_to_construct = 7200.00
	metal_price = 100.00

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_in_construction:
		GameManager.fix_robot_status = "Em Construção"
		time_to_construct -= delta * boost_construction
		
	elif time_to_construct <= 0.0:
			is_in_construction = false
			is_constructed = true
			GameManager.fix_robot_status = "Completo"
	
	elif is_broken:
		GameManager.fix_robots_status = "Quebrado(s)"
	
	elif is_being_fixed:
		GameManager.fix_robot_status = "Em Conserto"
		manutence_time -= boost_construction * delta
		if manutence_time <= 0.0:
			is_being_fixed = false
			GameManager.fix_robot_status = "Completo"

func fix_decrease(decrease_rate : float):
	manutence_time -= (1 - decrease_rate) * manutence_time

func construct_decrease(decrease_rate : float):
	time_to_construct -= (1 - decrease_rate) * manutence_time

func _start_construction():
	GameManager.metal -= metal_price
	is_in_construction = true
		
