extends Node

@onready var constructions
signal set_cons_audio

func _ready() -> void: 
	set_cons_audio.connect(check_cons_audio_sound)
	
func _process(delta: float) -> void:
	constructions = get_tree().get_nodes_in_group("Construction")


func check_cons_audio_sound():
	if constructions:
		for construction in constructions:
			construction.check_stop_time()
	else:
		return
