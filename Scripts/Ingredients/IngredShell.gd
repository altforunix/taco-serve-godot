extends Node3D

var area: Area3D

func _ready() -> void:
	area = $Area3D
	area.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.add_to_inventory("shell")
		queue_free()
