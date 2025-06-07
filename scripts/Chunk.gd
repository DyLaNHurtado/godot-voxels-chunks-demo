extends Node3D

@export var size: Vector3i = Vector3i(8, 8, 8)
@export var floor_block_scene: PackedScene
@export var dirt_block_scene: PackedScene

func _ready():
	generate_chunk()

func generate_chunk():
	for x in size.x:
		for y in size.y:
			for z in size.z:
				var block;
				if y == 0:
					block = floor_block_scene.instantiate()
				else: 
					block = dirt_block_scene.instantiate()
				block.position = Vector3(x, -y , z );
				add_child(block)
