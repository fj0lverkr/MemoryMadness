extends Node

var current_level: int = 0:
	set(val):
		current_level = val
	get:
		return current_level

const LEVELS: Dictionary = {
	1: {"rows": 2, "cols": 2},
	2: {"rows": 3, "cols": 4},
	3: {"rows": 4, "cols": 4},
	4: {"rows": 4, "cols": 6},
	5: {"rows": 5, "cols": 6},
	6: {"rows": 6, "cols": 6}
}
