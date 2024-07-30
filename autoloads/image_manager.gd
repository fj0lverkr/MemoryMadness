extends Node

const FRAMES: Array[CompressedTexture2D] = [
	preload("res://assets/frames/blue_frame.png"),
	preload("res://assets/frames/green_frame.png"),
	preload("res://assets/frames/yellow_frame.png"),
	preload("res://assets/frames/red_frame.png")
]

var _item_images: Array[Dictionary]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_item_images()

func _add_file_to_list(fn: String, path: String) -> void:
	var full_path: String = path + "/" + fn
	var ii_dict: Dictionary = {
		"item_name": fn.rstrip("." + fn.get_extension()),
		"item_texture": load(full_path)
	}

	_item_images.append(ii_dict)

func _load_item_images() -> void:
	var glitch_path: String = "res://assets/glitch/"
	var glitch_dir: DirAccess = DirAccess.open(glitch_path)

	if !glitch_dir:
		print("Error opening glitch folder at: %s" % glitch_path)
		return
	
	var file_names: PackedStringArray = glitch_dir.get_files()
	for fn: String in file_names:
		if fn.get_extension() != "import":
			_add_file_to_list(fn, glitch_path)

func get_random_image() -> Dictionary:
	return _item_images.pick_random()

func get_image(index: int) -> Dictionary:
	return _item_images[index]

func get_random_frame() -> CompressedTexture2D:
	return FRAMES.pick_random()

func shuffle_images() -> void:
	_item_images.shuffle()