extends Control

@export var memory_tile: PackedScene

@onready var audio: AudioStreamPlayer = $Sound
@onready var tiles_grid: GridContainer = $"HB/MCLeft/TilesGrid"
@onready var moves_label: Label = $"HB/MCRight/VB/HB/MovesLabel"
@onready var pairs_label: Label = $"HB/MCRight/VB/HB2/PairsLabel"
@onready var mc_right: MarginContainer = $"HB/MCRight"
@onready var scorer: Scorer = $Scorer

var _total_pairs: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.on_level_selected.connect(_on_level_selected)
	SignalBus.on_move_made.connect(_update_moves_label)
	SignalBus.on_pair_made.connect(_update_pairs_label)
	SignalBus.on_game_over.connect(_on_game_over)

func _update_pairs_label(count: int) -> void:
	pairs_label.text = "%s/%s" % [str(count), str(_total_pairs)]

func _update_moves_label(count: int) -> void:
	moves_label.text = str(count)

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
	_total_pairs = level_selection.images.size() / 2
	for item_info: Dictionary in level_selection.images:
		_add_tile(item_info, frame)
	scorer.clear_game(level_selection.pairs)
	_update_moves_label(0)
	_update_pairs_label(0)
	mc_right.show()

func _on_game_over(_m: int) -> void:
	mc_right.hide()
