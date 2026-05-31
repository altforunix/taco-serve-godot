extends CanvasLayer

var inventory_label: Label
var score_label: Label
var sanity_label: Label
var sanity_bar: ProgressBar
var timer_label: Label
var difficulty_label: Label
var interact_label: Label
var quest_label: Label
var dialogue_box: PanelContainer
var dialogue_text: Label
var difficulty_manager: Node
var horror_effects: Node
var quest_system: Node
var dialogue_system: Node

func _ready() -> void:
	inventory_label = $Control/InventoryLabel
	score_label = $Control/ScoreLabel
	sanity_label = $Control/SanityLabel
	sanity_bar = $Control/SanityBar
	timer_label = $Control/TimerLabel
	difficulty_label = $Control/DifficultyLabel
	interact_label = $Control/InteractLabel
	quest_label = $Control/QuestLabel
	dialogue_box = $Control/DialogueBox
	dialogue_text = $Control/DialogueBox/DialogueText
	
	difficulty_manager = get_tree().get_first_child_in_group("difficulty")
	horror_effects = get_tree().get_first_child_in_group("horror_effects")
	quest_system = get_tree().get_first_child_in_group("quests")
	dialogue_system = get_tree().get_first_child_in_group("dialogue")
	
	if difficulty_manager:
		difficulty_label.text = "Difficulty: " + difficulty_manager.get_difficulty_name()
	if quest_system:
		quest_system.quest_started.connect(_on_quest_started)
	if dialogue_system:
		dialogue_system.dialogue_line_displayed.connect(_on_dialogue_line)
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


func _on_sanity_changed(sanity: float) -> void:
	var sanity_percent = sanity / 100.0
	sanity_label.text = "Sanity: %.0f%%" % sanity
	sanity_bar.value = sanity
	
	if sanity_percent < 0.25:
		sanity_label.add_theme_color_override("font_color", Color.RED)
		sanity_bar.add_theme_color_override("fill", Color.RED)
	elif sanity_percent < 0.5:
		sanity_label.add_theme_color_override("font_color", Color.YELLOW)
		sanity_bar.add_theme_color_override("fill", Color.YELLOW)
	else:
		sanity_label.add_theme_color_override("font_color", Color.GREEN)
		sanity_bar.add_theme_color_override("fill", Color.GREEN)


func _on_quest_started(quest_id: String) -> void:
	if quest_system:
		var quest_info = quest_system.get_quest_info(quest_id)
		quest_label.text = "Quest: " + quest_info.get("title", "Unknown")


func _on_dialogue_line(text: String) -> void:
	dialogue_text.text = text
	dialogue_box.visible = true
	await get_tree().create_timer(3.0).timeout
	dialogue_box.visible = false


func _on_game_over(reason: String) -> void:
	print("Game Over: ", reason)


func _on_victory() -> void:
	print("Victory!")
