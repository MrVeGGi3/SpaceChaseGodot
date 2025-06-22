class_name FixRobotProgressBar
extends ConstructionProgressBar

func _ready() -> void:
	set_node_local($"..", $"../RobotAnimSprite2D", $"../ChangeProgressBarColor")

func _process(delta: float) -> void:
	switch_progress_bar_value()
	change_robot_animation()
	


func change_robot_animation():
	if not construction.is_constructed:
		if value < 25:
			cons_anim_sprite_2d.play("1")
		elif value >=25 and value < 50:
			cons_anim_sprite_2d.play("2")
		elif value >= 50 and value < 75:
			cons_anim_sprite_2d.play("3")
		elif value >= 75 and value < 100:
			cons_anim_sprite_2d.play("4")
	else:
		cons_anim_sprite_2d.play("Constructed")		
