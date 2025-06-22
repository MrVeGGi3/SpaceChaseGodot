class_name ConstructionProgressBar
extends ProgressBar

@onready var construction
@onready var cons_anim_sprite_2d 
@onready var change_progress_bar_color

var progress_bar_mode = ["Construction", "Manutence"]
var actual_progress_bar_mode


func _process(delta: float) -> void:
	switch_progress_bar_value()

func set_node_local(cons_node : Node2D
, anim_sprite : AnimatedSprite2D
, anim_change_color : AnimationPlayer):
	
	construction = cons_node
	cons_anim_sprite_2d = anim_sprite
	change_progress_bar_color = anim_change_color

func switch_progress_bar_value():
	if not construction.is_constructed:
		change_progress_bar_color.play("construction_progress_color")
		value = (construction.time_constructed / construction.time_to_construct) * 100
		
	elif construction.is_broken:
		change_progress_bar_color.play("manutence_progress_color")
		value = (construction.time_to_fix / construction.fixing_time) * 100
