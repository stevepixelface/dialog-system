extends CanvasLayer

export (String, FILE, "*json") var dialog_file

var dialog_for_scene = {}
var current_dialog = []
var dialog_in_progress = false

onready var background = $Background
onready var text_label = $TextLabel

func _ready():
	background.visible = false
	dialog_for_scene = load_dialog()
	SignalBus.connect("display_dialog", self, "on_display_dialog")

func load_dialog():
	var file = File.new()
	if file.file_exists(dialog_file):
		file.open(dialog_file, File.READ)
		return parse_json(file.get_as_text())

func show_dialog_text():
	text_label.text = current_dialog.pop_front()

func continue_dialog():
	if current_dialog.size() > 0:
		show_dialog_text()
	else:
		finish_dialog()

func finish_dialog():
	text_label.text = ""
	background.visible = false
	dialog_in_progress = false
	get_tree().paused = false
	
func on_display_dialog(dialog_key):
	if dialog_in_progress:
		continue_dialog()
	else:
		get_tree().paused = true
		background.visible = true
		dialog_in_progress = true
		current_dialog = dialog_for_scene[dialog_key].duplicate()
		show_dialog_text()

