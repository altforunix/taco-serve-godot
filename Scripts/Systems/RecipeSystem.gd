extends Node

class_name RecipeSystem

var recipes: Dictionary = {}
var player_inventory: Dictionary = {}

signal recipe_completed(recipe_id: String, correct: bool)
signal ingredient_used(ingredient: String)

func _ready() -> void:
	name = "RecipeSystem"
	add_to_group("recipes")
	initialize_recipes()

func initialize_recipes() -> void:
	recipes = {
		"classic_taco": {
			"name": "Classic Taco",
			"ingredients": {"shell": 1, "meat": 1, "cheese": 1, "lettuce": 1},
			"difficulty": 1,
			"points": 100
		},
		"cheese_blast": {
			"name": "Cheese Blast",
			"ingredients": {"shell": 1, "cheese": 3, "lettuce": 1},
			"difficulty": 2,
			"points": 150
		},
		"meat_lover": {
			"name": "Meat Lover",
			"ingredients": {"shell": 1, "meat": 2, "cheese": 1},
			"difficulty": 2,
			"points": 150
		},
		"veggie_delight": {
			"name": "Veggie Delight",
			"ingredients": {"shell": 1, "lettuce": 2, "cheese": 1},
			"difficulty": 1,
			"points": 100
		},
		"master_taco": {
			"name": "Master Taco",
			"ingredients": {"shell": 2, "meat": 2, "cheese": 2, "lettuce": 2},
			"difficulty": 3,
			"points": 300
		}
	}

func set_player_inventory(inventory: Dictionary) -> void:
	player_inventory = inventory

func check_recipe(recipe_id: String) -> bool:
	if recipe_id not in recipes:
		return false
	
	var recipe = recipes[recipe_id]
	var required_ingredients = recipe["ingredients"]
	
	for ingredient in required_ingredients:
		if player_inventory.get(ingredient, 0) < required_ingredients[ingredient]:
			return false
	
	return true

func complete_recipe(recipe_id: String) -> int:
	if not check_recipe(recipe_id):
		return 0
	
	var recipe = recipes[recipe_id]
	var required_ingredients = recipe["ingredients"]
	
	# Consume ingredients
	for ingredient in required_ingredients:
		player_inventory[ingredient] -= required_ingredients[ingredient]
		ingredient_used.emit(ingredient)
	
	recipe_completed.emit(recipe_id, true)
	return recipe["points"]

func get_recipe_info(recipe_id: String) -> Dictionary:
	return recipes.get(recipe_id, {})

func get_all_recipes() -> Dictionary:
	return recipes.duplicate()
