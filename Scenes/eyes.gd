extends Node3D

@onready var eye1 = $RayCast3D
@onready var eye2 = $RayCast3D2
@onready var eye3 = $RayCast3D3
@onready var eye4 = $RayCast3D4

var raycasts = {
}
var eye1a = Vector2(-100,-100)
var eye2a = Vector2(-100,-100)
var eye3a = Vector2(-100,-100)
var eye4a = Vector2(-100,-100)
# Called when the node enters the scene tree for the first time.
func _ready():
	raycasts = {
	eye1: eye1a,
	eye2: eye2a,
	eye3: eye3a,
	eye4: eye4a
}

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(raycasts.values())
	for eye in raycasts:
		if eye.is_colliding():
			raycasts[eye] = [eye.get_collider().global_position.x , eye.get_collider().global_position.y]
		else:
			raycasts[eye] = [-100,-100]

func get_null():
	var count = 0
	for eye in raycasts:
		if raycasts[eye] == [-100,-100]:
			count +=1
	return count
