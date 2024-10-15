extends AIController3D

var move = Vector3.ZERO


@onready var character_body_3d = $".."
@onready var target = $"../../Target"

func get_obs() -> Dictionary:
	var obs := [
		character_body_3d.position.x,
		character_body_3d.position.z,
		target.position.x,
		target.position.z
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
