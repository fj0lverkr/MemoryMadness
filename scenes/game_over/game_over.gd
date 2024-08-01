extends Control

@onready var moves_label: Label = $"NinePatchRect/MC/VB/HB/MovesLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	hide()
	SignalBus.on_game_exit_pressed.emit()
