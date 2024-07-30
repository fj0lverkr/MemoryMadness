extends Control

@onready var audio: AudioStreamPlayer = $Sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_exit_button_pressed() -> void:
	AudioManager.play_button_clicked(audio)
	SignalBus.on_game_exit_pressed.emit()
