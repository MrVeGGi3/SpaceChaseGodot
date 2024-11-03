class_name Menu
extends Control

@onready var back_video: VideoStreamPlayer = $VideoStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back_video.play()
	back_video.loop = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
