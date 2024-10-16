extends AIController3D

var move = Vector3.ZERO


@onready var character_body_3d = $".."
@onready var target = $"../../BlueFlag"



func get_obs() -> Dictionary:
	var obs := [
		character_body_3d.global_position.x,
		character_body_3d.global_position.z,
		target.global_position.x,
		target.global_position.z
	]
	return {"obs": obs}


func get_reward() -> float:
	return reward


func get_action_space() -> Dictionary:
	return {
		"move": 
			{"size": 2, "action_type": "continuous"}
	}


func set_action(action) -> void:
	move.x = action["move"][0]
	move.z = action["move"][1]
