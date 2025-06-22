class_name  MinerProgressBar
extends ConstructionProgressBar

func _ready() -> void:
	set_node_local($"..", $"../AnimatedSprite2D", $"../ChangeProgressBarColor")

func _process(delta: float) -> void:
	switch_progress_bar_value()
