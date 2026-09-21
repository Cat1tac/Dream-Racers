@abstract
class_name BaseLevel extends Node3D
## Abstract class for levels

##Provides a player spawn location
@abstract func get_default_player_spawn() -> Array[Marker3D]

@abstract func get_player_camera() -> Camera3D
