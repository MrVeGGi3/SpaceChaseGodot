extends Node2D

@onready var check_box: CheckBox = $ItensToBuild/CheckBoxContainer/CheckBox
@onready var check_box_2: CheckBox = $ItensToBuild/CheckBoxContainer/CheckBox2
@onready var check_box_3: CheckBox = $ItensToBuild/CheckBoxContainer/CheckBox3
@onready var check_box_4: CheckBox = $ItensToBuild/CheckBoxContainer/CheckBox4
@onready var fix_robots_total_label: Label = $FixRobotsTotalLabel
@onready var max_fix_robots : int = 10
@onready var radar_conditions_animation_player: AnimationPlayer = $RadarConditionsAnimationPlayer

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	fix_robots_total_label.text = str("%02:%02" % [GameManager.fix_robots, max_fix_robots])
func _play_radar_animation():
	radar_conditions_animation_player.play("open_radar")
func _on_close_radar_pressed() -> void:
	radar_conditions_animation_player.play("close_radar")
