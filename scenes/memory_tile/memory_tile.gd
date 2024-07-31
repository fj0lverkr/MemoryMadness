extends TextureButton

class_name MemoryTile

@onready var frame_image: TextureRect = $FrameImage
@onready var item_image: TextureRect = $ItemImage

var _item_name: String
var _can_select_me: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.on_select_disabled.connect(_on_select_disabled)
	SignalBus.on_select_enabled.connect(_on_select_enabled)

func _on_select_disabled() -> void:
	_can_select_me = false

func _on_select_enabled() -> void:
	_can_select_me = true

func get_item_name() -> String:
	return _item_name

func toggle_reveal(r: bool) -> void:
	item_image.visible = r
	frame_image.visible = r

func setup(ii_dict: Dictionary, fi: CompressedTexture2D) -> void:
	toggle_reveal(false)
	frame_image.texture = fi
	item_image.texture = ii_dict.item_texture
	_item_name = ii_dict.item_name

func _on_pressed() -> void:
	if _can_select_me:
		SignalBus.on_tile_selected.emit(self)
