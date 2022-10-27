extends Node3D

#Variables
@onready var DirectionalLight3DRotation = $Sun_long_helper/DirectionalLight3D.get_rotation()
@onready var Sun_long_helperRotation = $Sun_long_helper.get_rotation()
@onready var Sun_latitude = rad_to_deg($Sun_long_helper/DirectionalLight3D.get_rotation().x)
@onready var Sun_longitude = rad_to_deg($Sun_long_helper.get_rotation().z)
@export var sunspeed = 4
@export var seasonspeed = 1
var long_modify = 1
var day_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug(Sun_latitude)
	print_debug(Sun_longitude)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	# Days - Latitude part
	if Sun_latitude > -360:
		Sun_latitude -= sunspeed*delta
	else:
		Sun_latitude = 0	
		day_counter += 1
		# Seasons - Longitude part
		if Sun_longitude < 45 and long_modify ==1:
			Sun_longitude += long_modify*seasonspeed
		else:
			long_modify = -1
		if Sun_longitude > -45 and long_modify ==-1:
			Sun_longitude += long_modify*seasonspeed
		else:
			long_modify = 1
		print_debug("Longitude:" + str(Sun_longitude))
		Sun_long_helperRotation.z = deg_to_rad(Sun_longitude)
		$Sun_long_helper.set_rotation(Sun_long_helperRotation)
	#print_debug("Latitude:" + str(Sun_latitude))
	DirectionalLight3DRotation.x = deg_to_rad(Sun_latitude)
	$Sun_long_helper/DirectionalLight3D.set_rotation(DirectionalLight3DRotation)
