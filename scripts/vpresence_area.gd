extends Node3D

@onready var anim = $"Panel/AnimationPlayer"

func _on_area_3d_body_entered(body):
	if (body.name == "Player"):
		anim.play("fade_in")

func _on_area_3d_body_exited(body):
	if (body.name == "Player"):
		anim.play("fade_out")
