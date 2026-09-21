extends Node

var _line_node : MeshInstance3D
var _line_mat : StandardMaterial3D
var _line_mesh  : ImmediateMesh

# queued lines
var _line_data = []

func _ready() -> void:
	_line_node = MeshInstance3D.new()
	_line_mat = StandardMaterial3D.new()
	_line_mat.vertex_color_use_as_albedo = true
	_line_mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	
	_line_mesh = ImmediateMesh.new()
	
	_line_node.mesh = _line_mesh
	_line_node.material_override = _line_mat
	_line_node.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	add_child(_line_node)
	
func _process(delta : float) -> void:
	#update the mesh
	_line_mesh.clear_surfaces()
	
	if (_line_data.size() == 0):
		return
		
	_line_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	
	var done_indices = []
	for i in range(_line_data.size()):
		var line = _line_data[i]
		var start = line ["start"]
		var end = line["end"]
		var color = line["color"]
		var remaining = line["remaining"]
		
		_line_mesh.surface_set_color(color)
		_line_mesh.surface_add_vertex(start)
		_line_mesh.surface_add_vertex(end)
		
		remaining -= delta
		line["remaining"] = remaining
		
		if (remaining <= 0.0):
			done_indices.push_back(i)
			
	_line_mesh.surface_end()
	
	done_indices.reverse()
	for i in done_indices:
		_line_data.remove_at(i)
		
func draw_line(start : Vector3, end : Vector3, color : Color, duration : float = 0) -> void:
	_line_data.push_back(
		{"start": start, "end":end, "color": color, "remaining": duration}
	)
