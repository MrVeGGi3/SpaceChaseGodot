class_name SintetyzorProgressBar
extends ConstructionProgressBar


func _ready() -> void:
	set_node_local($"..",$"../AnimatedSprite2D", $"../ChangeSintetyzorStats")
	

func _process(delta: float) -> void:
	switch_progress_bar_value()
