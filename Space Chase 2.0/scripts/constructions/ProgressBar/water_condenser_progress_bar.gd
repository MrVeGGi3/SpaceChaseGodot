class_name WatewrConderserProgress
extends ConstructionProgressBar

func _ready() -> void:
	set_node_local($"..", $"../AnimatedSprite2D", $"../ChangeColorProgressBar" )

func _process(delta: float) -> void:
	switch_progress_bar_value()
