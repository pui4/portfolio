extends Camera3D

@onready var targ = get_parent().get_node("Player").get_node("TargetPos")

var lerp_speed: float = 1

func _process(delta):
	global_position = global_position.lerp(targ.global_position, lerp_speed * delta)
