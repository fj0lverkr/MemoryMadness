extends Control

@onready var moves_label: Label = $"NinePatchRect/MC/VB/HB/MovesLabel"
@onready var audio: AudioStreamPlayer = $"Audio"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.on_game_over.connect(_on_game_over)

func _on_game_over(moves: int) -> void:
	moves_label.text = str(moves)
	show()

func _on_exit_button_pressed() -> void:
	hide()
	GameManager.clear_nodes_of_group(GameManager.TILES_GROUP)
	AudioManager.play_button_clicked(audio)
	SignalBus.on_game_exit_pressed.emit()
