extends TextureButton

@onready var level_label: Label = $LevelLabel
@onready var button_sound: AudioStreamPlayer = $Sound

var level_number: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = "3x4"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
