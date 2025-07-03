extends Node2D

@onready var check_box: CheckBox = $ItensToBuild/CheckBoxContainer/CheckBox
@onready var check_box_2: CheckBox = $ItensToBuild/CheckBoxContainer/CheckBox2
@onready var fix_robots_total_label: Label = $ItensToBuild/FixRobotsTotalLabel
@onready var max_fix_robots : int = 5
@onready var radar_conditions_animation_player: AnimationPlayer = $RadarConditionsAnimationPlayer


@onready var radar_closed: AudioStreamPlayer = $RadarClosed


func _unhandled_input(event: InputEvent) -> void:
	if visible:
		if event is InputEventKey:
			if event.keycode == KEY_ESCAPE and event.pressed:
				radar_closed.play()
				hide()

func _process(delta: float) -> void:
	fix_robots_total_label.text = str(GameManager.fix_robots) + "/" + str(max_fix_robots)
func _play_radar_animation():
	radar_conditions_animation_player.play("open_radar")
	
func _on_close_radar_pressed() -> void:
	radar_closed.play()
	radar_conditions_animation_player.play("close_radar")
