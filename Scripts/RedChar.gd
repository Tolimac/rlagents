extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 5


@onready var ai_controller_3d = $"../AIController3D"
@onready var eyes = $Eyes
@export var potential_factor = .5

var spawnloc = global_position
var fall_count = 0
var closest = 0
var jump_count = 0
var dist_comp = 0
var delta_count = 0 
var potential = 0

func _physics_process(delta):
	# Add the gravity.
	delta_count += 1
	if delta_count % 500 == 0 and jump_count > 1: jump_count -= 1
	#if delta_count % 10000 == 0: print("delta_count")
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		if float(ai_controller_3d.jump) > 0.5:
			velocity.y = JUMP_VELOCITY
			jump_count +=1
	velocity.x = ai_controller_3d.move.x * 3
	velocity.z = ai_controller_3d.move.z * 3
	move_and_slide()
	if global_position.y < -.1 or global_position.y > 10:
		position = spawnloc
		ai_controller_3d.reward -= 1
		fall_count +=1
	if global_position.distance_to(Goal.goalpos) < 1.5:
		print("Success Timestep: ",delta_count)
		position = spawnloc
		ai_controller_3d.reward += 100

func compute_reward_smoothed(prev):
	var off_edge = eyes.get_null()*.1
	var dist = global_position.distance_to(Goal.goalpos)/spawnloc.distance_to(Goal.goalpos)
	var t =  2 - dist - fall_count*.001 - off_edge/16
	var n = .2
	var curr = (1-n)*t+n*prev
	return curr

func compute_reward(prev):
	var dist = -global_position.distance_to(Goal.goalpos)/spawnloc.distance_to(Goal.goalpos)
	return dist
	
func potential_based_compute(prev):
	var smoothed_reward = compute_reward_smoothed(prev)
	return smoothed_reward + potential*potential_factor
	


func Reward1(area):
	potential = 1


func _on_reward_2_area_entered(area):
	potential = 2


func _on_reward_3_area_entered(area):
	potential = 3


func _on_reward_4_area_entered(area):
	potential = 4


func _on_reward_5_area_entered(area):
	potential = 5


func _on_reward_5_1_area_entered(area):
	potential = 5


func _on_reward_4_1_area_entered(area):
	potential = 4
