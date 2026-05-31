extends StaticBody3D

var game_manager: Node
var smiling_man_interaction_active = false

func _ready() -> void:
	game_manager = get_tree().get_first_child_in_group("game_manager")


func interact(player: Node3D) -> void:
	print("Soda Machine interacted with")
	
	if game_manager and game_manager.smiling_man_spawned and game_manager.smiling_man_timer < game_manager.SMILING_MAN_WINDOW:
		print("You interact with the Smiling Man at the Soda Machine...")
		game_manager.complete_smiling_man_interaction()
		print("You survived!")
