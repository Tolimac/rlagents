extends AIController3D

var move = Vector3.ZERO
var jump = false

@onready var character_body_3d = $"../CharacterBody3D"
@onready var eyes = $"../CharacterBody3D/Eyes"
	


func get_obs() -> Dictionary:
	var obs := [
		character_body_3d.global_position.x,
		character_body_3d.global_position.z,
		Goal.goalpos.x,
		Goal.goalpos.z,
		eyes.eye1a.x,
		eyes.eye1a.y,
		eyes.eye2a.x,
		eyes.eye2a.y,
		eyes.eye3a.x,
		eyes.eye3a.y,
		eyes.eye4a.x,
		eyes.eye4a.y
	]
	#print(obs)
	return {"obs": obs}


func get_reward() -> float:
	reward = character_body_3d.potential_based_compute(reward)
	#print(reward)
	return reward


func get_action_space() -> Dictionary:
	return {
		"move": 
			{"size": 3, "action_type": "continuous"}
	}


func set_action(action) -> void:
	move.x = action["move"][0]
	move.z = action["move"][1]
	jump = action["move"][2]
