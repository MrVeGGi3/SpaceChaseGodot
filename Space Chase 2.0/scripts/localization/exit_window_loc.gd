extends Window
@onready var label: Label = $Label
@onready var confirm: Button = $Confirm
@onready var cancel: Button = $Cancel


func _process(delta):
	label.text = tr("EXIT_WINDOW_TEXT")
	title = tr("EXIT_WINDOW_TITLE")
	confirm.text = tr("YES_WINDOW_CONFIRM")
	cancel.text = tr("NO_WINDOW_CONFIRM")
