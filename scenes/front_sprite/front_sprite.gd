extends TextureRect

const SCALE_SMALL: Vector2 = Vector2(0.1, 0.1)
const SCALE_NORMAL: Vector2 = Vector2(1.0, 1.0)
const SPIN_TIME_RANGE: Vector2 = Vector2(.10, 2.0)
const SCALE_SPEED: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	run_tween()

func _get_spin_time() -> float:
	return randf_range(SPIN_TIME_RANGE.x, SPIN_TIME_RANGE.y)

func _get_rotation() -> float:
	return deg_to_rad(randf_range(-360.0, 360.0))

func run_tween() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.set_loops()
	tween.tween_property(self, "scale", SCALE_NORMAL, SCALE_SPEED)
	tween.tween_property(self, "rotation", _get_rotation(), _get_spin_time())
	tween.tween_property(self, "rotation", _get_rotation(), _get_spin_time())
	tween.tween_property(self, "scale", SCALE_SMALL, SCALE_SPEED)