extends Node

const TILES_GROUP: String = "tiles"

const LEVELS: Dictionary = {
	1: {"rows": 2, "cols": 2},
	2: {"rows": 3, "cols": 4},
	3: {"rows": 4, "cols": 4},
	4: {"rows": 4, "cols": 6},
	5: {"rows": 5, "cols": 6},
	6: {"rows": 6, "cols": 6}
}

func get_level_selection(level: int) -> Dictionary:
	var level_data: Dictionary = LEVELS[level]
	var num_tiles: int = level_data.rows * level_data.cols
	var target_pairs: int = int(num_tiles / 2.0)
	var level_images: Array[Dictionary] = []

	ImageManager.shuffle_images()
	for i in range(target_pairs):
		level_images.append(ImageManager.get_image(i))
		level_images.append(ImageManager.get_image(i))
	level_images.shuffle()

	return {
		"pairs": target_pairs,
		"cols": level_data.cols,
		"images": level_images
	}

func clear_nodes_of_group(group_name: String) -> void:
	for n in get_tree().get_nodes_in_group(group_name):
		n.queue_free()