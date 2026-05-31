extends StaticBody3D

var game_manager: Node

func _ready() -> void:
	game_manager = get_tree().get_first_child_in_group("game_manager")


func interact(player: Node3D) -> void:
	print("Prep Table interacted with - preparing taco")
	if game_manager:
		# Check if player has all ingredients
		var inventory = game_manager.inventory
		if inventory["shell"] > 0 and inventory["meat"] > 0 and inventory["cheese"] > 0 and inventory["lettuce"] > 0:
			# Remove ingredients and serve
			game_manager.remove_ingredient("shell")
			game_manager.remove_ingredient("meat")
			game_manager.remove_ingredient("cheese")
			game_manager.remove_ingredient("lettuce")
			game_manager.serve_taco(true)
			print("Taco served!")
		else:
			print("Missing ingredients")
