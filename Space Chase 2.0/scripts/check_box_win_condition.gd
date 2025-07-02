extends VBoxContainer

@onready var check_box: CheckBox = $CheckBox
@onready var check_box_2: CheckBox = $CheckBox2

@onready var check_buttons = [check_box, check_box_2]

func _ready() -> void:
	disable_buttons()

func _process(delta: float) -> void:
	check_robot()
	check_fuel()

func check_robot():
	if GameManager.fix_robots == GameManager.max_fix_robots:
		check_box.button_pressed = true
		GameManager.have_enough_robot = true

func check_fuel():
	if GameManager.fuel >= 2000.0:
		check_box_2.button_pressed = true
		GameManager.have_enough_fuel = true

func disable_buttons():
	for button in check_buttons:
		button.disabled = true
	
