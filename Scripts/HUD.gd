extends CanvasLayer

var inventory_label: Label
var score_label: Label
var timer_label: Label
var difficulty_label: Label
var interact_label: Label
var difficulty_manager: Node

func _ready() -> void:
	inventory_label = $Control/InventoryLabel
	score_label = $Control/ScoreLabel
	timer_label = $Control/TimerLabel
	difficulty_label = $Control/DifficultyLabel
	interact_label = $Control/InteractLabel
	difficulty_manager = get_tree().get_first_child_in_group("difficulty")
	
	if difficulty_manager:
		difficulty_label.text = "Difficulty: " + difficulty_manager.get_difficulty_name()
	update_inventory({})


func update_inventory(inventory: Dictionary) -> void:
	if inventory.is_empty():
		inventory_label.text = "Inventory: Empty"
		return
	
	var inv_text = "Inventory: "
	var items = []
	
	if inventory.get("shell", 0) > 0:
		items.append("Shell x%d" % inventory["shell"])
	if inventory.get("meat", 0) > 0:
		items.append("Meat x%d" % inventory["meat"])
	if inventory.get("cheese", 0) > 0:
		items.append("Cheese x%d" % inventory["cheese"])
	if inventory.get("lettuce", 0) > 0:
		items.append("Lettuce x%d" % inventory["lettuce"])
	
	if items.is_empty():
		inv_text += "Empty"
	else:
		inv_text += " | ".join(items)
	
	inventory_label.text = inv_text


func update_time(hours: int, minutes: int) -> void:
	var period = "AM" if hours < 12 else "PM"
	var display_hours = hours if hours <= 12 else hours - 12
	if display_hours == 0:
		display_hours = 12
	
	timer_label.text = "%02d:%02d %s" % [display_hours, minutes, period]


func update_score(score: int) -> void:
	score_label.text = "Score: %d" % score


func show_interact_prompt() -> void:
	interact_label.visible = true


func hide_interact_prompt() -> void:
	interact_label.visible = false


func _on_game_over(reason: String) -> void:
	print("Game Over: ", reason)


func _on_victory() -> void:
	print("Victory!")
