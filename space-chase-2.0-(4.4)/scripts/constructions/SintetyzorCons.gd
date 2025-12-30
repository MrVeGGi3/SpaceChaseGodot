class_name SintetyzorView
extends Construction

@onready var show_sintetyzor: Button = $ShowSintetyzor

signal interface_pressed(state)

func _ready() -> void:
	set_initial_nodes($ConstructSintetyzor, $SintetyzorProgressBar, $Area2D)
	hide_construction_UI()
	show_sintetyzor.hide()
	decrease_time_with_bonus()


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



func _on_area_2d_body_entered(body: Player) -> void:
	player_entered_area()
	if is_constructed:
		show_sintetyzor.show()

func _on_area_2d_body_exited(body: Player) -> void:
	player_exited_area()
	show_sintetyzor.hide()


func _on_show_sintetyzor_pressed() -> void:
	GameManager.can_activate_sint_ui = true


func _on_construct_sintetyzor_pressed() -> void:
	construction_button_pressed()
