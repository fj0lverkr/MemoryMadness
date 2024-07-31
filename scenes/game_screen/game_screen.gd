extends Control

@export var memory_tile: PackedScene

@onready var audio: AudioStreamPlayer = $Sound
@onready var tiles_grid: GridContainer = $"HB/MCLeft/TilesGrid"
@onready var scorer: Scorer = $Scorer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.on_level_selected.connect(_on_level_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_exit_button_pressed() -> void:
	GameManager.clear_nodes_of_group(GameManager.TILES_GROUP)
	AudioManager.play_button_clicked(audio)
	SignalBus.on_game_exit_pressed.emit()

func _add_tile(item_info: Dictionary, frame_texture: CompressedTexture2D) -> void:
	var tile: Node = memory_tile.instantiate()
	tiles_grid.add_child(tile)
	tile.setup(item_info, frame_texture)

func _on_level_selected(level: int) -> void:
	var level_selection: Dictionary = GameManager.get_level_selection(level)
	var frame: CompressedTexture2D = ImageManager.get_random_frame()
	tiles_grid.columns = level_selection.cols
	for item_info: Dictionary in level_selection.images:
		_add_tile(item_info, frame)
	scorer.clear_game(level_selection.pairs)
