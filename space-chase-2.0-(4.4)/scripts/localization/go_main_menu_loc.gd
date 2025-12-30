extends Window

@onready var close_window: Label = $CloseWindow
@onready var no: Button = $No
@onready var yes: Button = $Yes


func _process(delta: float) -> void:
	title = tr("GO_TO_MAIN_MENU")
	close_window.text = tr("EXIT_WINDOW_TEXT")
	no.text = tr("NO_WINDOW_CONFIRM")
	yes.text = tr("YES_WINDOW_CONFIRM")
