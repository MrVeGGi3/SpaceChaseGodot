extends Control

@onready var anim_mouse_left_clicked = $MouseLeftClicked
@onready var anim_mouse_right_clicked = $MouseRightClicked
@onready var is_player_interacting = GameManager.is_player_touching_interaction_area

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_mouse_right_clicked.stop()
	anim_mouse_right_clicked.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_player_interacting:
		anim_mouse_left_clicked.play()
