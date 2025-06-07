extends RayCast3D

@export var dirt_block_scene: PackedScene

var selected_block: Node3D = null
var original_materials := {}

func _ready():
	enabled = true
	_update_raycast_direction()

func _process(_delta):
	_update_raycast_direction()
	force_raycast_update()
	_update_selected_block()

func _update_raycast_direction():
	# El RayCast debe estar justo delante de la cámara (un poco adelante)
	var camera = get_viewport().get_camera_3d()
	if camera:
		# Posición del RayCast: un poco adelante de la cámara para evitar "taparla"
		global_transform.origin = camera.global_transform.origin + camera.global_transform.basis.z * -0.5
		# Dirección del RayCast: hacia donde mira la cámara (eje -Z)
		global_transform.basis = camera.global_transform.basis

func _update_selected_block():
	if is_colliding():
		var collider = get_collider()
		if collider != selected_block:
			if selected_block:
				_remove_highlight(selected_block)
			selected_block = collider
			_highlight_block(selected_block)
	else:
		if selected_block:
			_remove_highlight(selected_block)
			selected_block = null

func _highlight_block(block: Node3D):
	var mesh = block.get_node_or_null("MeshInstance3D")
	if mesh:
		_store_original_materials(mesh)
		_set_mesh_color(mesh, Color(1, 1, 0))  # Amarillo

func _remove_highlight(block: Node3D):
	var mesh = block.get_node_or_null("MeshInstance3D")
	if mesh:
		_restore_original_materials(mesh)

func _store_original_materials(mesh: MeshInstance3D):
	if mesh not in original_materials:
		var mats = []
		for i in range(mesh.get_surface_count()):
			mats.append(mesh.get_surface_material(i))
		original_materials[mesh] = mats

func _restore_original_materials(mesh: MeshInstance3D):
	if mesh in original_materials:
		var mats = original_materials[mesh]
		for i in range(mesh.get_surface_count()):
			mesh.set_surface_material(i, mats[i])
		original_materials.erase(mesh)

func _set_mesh_color(mesh: MeshInstance3D, color: Color):
	for i in range(mesh.get_surface_count()):
		var orig_mat = mesh.get_surface_material(i)
		if orig_mat:
			var mat = orig_mat.duplicate()
			if mat is StandardMaterial3D:
				mat.albedo_color = color
				mesh.set_surface_material(i, mat)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		force_raycast_update()
		if is_colliding():
			var collider = get_collider()
			
			if event.button_index == MOUSE_BUTTON_LEFT:
				if collider:
					# Subir hasta llegar al MeshInstance3D (el nodo raíz del bloque)
					var block_root = collider
					while block_root and not (block_root is MeshInstance3D and block_root.get_node_or_null("StaticBody3D")):
						block_root = block_root.get_parent()
					if block_root:
						block_root.queue_free()
						selected_block = null
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				var collision_point = get_collision_point()
				var collision_normal = get_collision_normal()

				var new_block_position = (collision_point + (collision_normal * 0.5)).snapped(Vector3.ONE)


				if not is_position_inside_player(new_block_position):
					var block = dirt_block_scene.instantiate()
					block.position = new_block_position

					# Encuentra el Chunk adecuado y añade el bloque ahí
					var chunk = find_chunk_for_position(new_block_position)
					if chunk:
						chunk.add_child(block)
					else:
						# Si no hay chunk que lo contenga, añadirlo a la raíz como fallback
						get_tree().get_root().get_node("WorldEnvironment").add_child(block)


func find_chunk_for_position(pos: Vector3) -> Node3D:
	for chunk in get_tree().get_root().get_node("WorldEnvironment").get_children():
		# Solo considera nodos que sean chunks reales
		if chunk.has_method("generate_chunk"):
			var chunk_pos = chunk.global_transform.origin
			var chunk_size = chunk.size
			if pos.x >= chunk_pos.x and pos.x < chunk_pos.x + chunk_size.x \
			and pos.y >= chunk_pos.y and pos.y < chunk_pos.y + chunk_size.y \
			and pos.z >= chunk_pos.z and pos.z < chunk_pos.z + chunk_size.z:
				return chunk
	return null


func is_position_inside_player(pos: Vector3) -> bool:
	var player = get_parent_node_3d().get_parent_node_3d()
	var player_pos = player.global_transform.origin
	# Aquí 0.75 es radio seguro para evitar solapamientos (ajusta según tamaño jugador)
	return player_pos.distance_to(pos) < 0.75
