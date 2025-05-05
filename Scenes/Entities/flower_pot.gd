extends CSGBox3D

@export var current_flower : Flower;

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		plantFlower(GAME.dandelion);

func plantFlower(flower : Flower) -> void:
	print_debug("Planting Flower : " + flower.name);
	spawnFlower(flower);

func spawnFlower(flower : Flower) -> void:
	# Instantiate "res://Assets/Meshes/Proto/flower_head_proto.tscn" and "res://Assets/Meshes/Proto/flower_stem_proto.tscn" at $FlowerSpawn
	
	var flower_spawn : Node3D = $FlowerSpawn;
	
	# Spawn Stem
	if flower.stem_model:
		var stem_instance = flower.stem_model.instantiate();
		var mat := StandardMaterial3D.new();
		mat.albedo_color = flower.get_colour_from_name(flower.stem_colour);
		
		if (stem_instance is MeshInstance3D):
			stem_instance.set_surface_override_material(0, mat);
		
		flower_spawn.add_child(stem_instance);
	
	# Spawn Head
	if flower.head_model:
		var head_instance = flower.head_model.instantiate();
		var mat := StandardMaterial3D.new();
		mat.albedo_color = flower.get_colour_from_name(flower.natural_colours.pick_random());
		
		if (head_instance is MeshInstance3D):
			head_instance.set_surface_override_material(0, mat);
		
		flower_spawn.add_child(head_instance);
	
	current_flower = flower;

func destroyFlower() -> void:
	# Check if I have a Flower
	if (current_flower == null):
		return;
	
	# Delete the Stem and Head
	
	# Remove current Flower
	current_flower = null;
