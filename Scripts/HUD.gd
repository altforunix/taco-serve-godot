extends CanvasLayer

var inventory_label: Label
var timer_label: Label
var interact_label: Label

func _ready() -> void:
	inventory_label = $Control/InventoryLabel
	timer_label = $Control/TimerLabel
	interact_label = $Control/InteractLabel
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


func show_interact_prompt() -> void:
	interact_label.visible = true


func hide_interact_prompt() -> void:
	interact_label.visible = false
