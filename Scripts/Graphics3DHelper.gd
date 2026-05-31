extends Node

class_name Graphics3DHelper

# Create a custom cylindrical shape for better visuals
static func create_cylinder_mesh(radius: float, height: float) -> MeshInstance3D:
	var mesh_instance = MeshInstance3D.new()
	var cylinder_mesh = CylinderMesh.new()
	cylinder_mesh.radius = radius
	cylinder_mesh.height = height
	mesh_instance.mesh = cylinder_mesh
	return mesh_instance

# Create a custom box with material
static func create_box_mesh(size: Vector3, material: Material = null) -> MeshInstance3D:
	var mesh_instance = MeshInstance3D.new()
	var box_mesh = BoxMesh.new()
	box_mesh.size = size
	mesh_instance.mesh = box_mesh
	if material:
		mesh_instance.set_surface_override_material(0, material)
	return mesh_instance

# Create metallic material
static func create_metallic_material(color: Color = Color.GRAY) -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	material.albedo_color = color
	material.metallic = 0.8
	material.roughness = 0.2
	return material

# Create plastic material
static func create_plastic_material(color: Color = Color.WHITE) -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	material.albedo_color = color
	material.metallic = 0.0
	material.roughness = 0.6
	return material

# Create wood material
static func create_wood_material() -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0.55, 0.35, 0.1)
	material.metallic = 0.0
	material.roughness = 0.8
	return material

# Create neon glow material
static func create_glow_material(color: Color) -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color
	material.emission_energy_multiplier = 2.0
	return material
