extends Node

var customer_types = [
	"HUMAN_WORKER",
	"HUMAN_CUSTOMER",
	"HUMAN_DELIVERY",
	"ENTITY_SHADOW",
	"ENTITY_WHISPER",
	"ENTITY_FACELESS",
	"ENTITY_CONSTRUCT",
	"SMILING_MAN"
]

var customer_properties = {
	"HUMAN_WORKER": { "threat_level": 0, "color": Color.WHITE, "speed": 1.0 },
	"HUMAN_CUSTOMER": { "threat_level": 0, "color": Color.LIGHT_GRAY, "speed": 0.8 },
	"HUMAN_DELIVERY": { "threat_level": 0, "color": Color.YELLOW, "speed": 1.2 },
	"ENTITY_SHADOW": { "threat_level": 2, "color": Color.BLACK, "speed": 1.5 },
	"ENTITY_WHISPER": { "threat_level": 1, "color": Color.GRAY, "speed": 1.0 },
	"ENTITY_FACELESS": { "threat_level": 3, "color": Color.DIM_GRAY, "speed": 2.0 },
	"ENTITY_CONSTRUCT": { "threat_level": 2, "color": Color.BROWN, "speed": 1.3 },
	"SMILING_MAN": { "threat_level": 5, "color": Color.RED, "speed": 0.5 }
}

func get_random_customer_type(non_human_ratio: float = 0.2) -> String:
	var roll = randf()
	if roll < non_human_ratio:
		# Non-human entities
		var non_human = ["ENTITY_SHADOW", "ENTITY_WHISPER", "ENTITY_FACELESS", "ENTITY_CONSTRUCT"]
		return non_human[randi() % non_human.size()]
	else:
		# Human customers
		var humans = ["HUMAN_WORKER", "HUMAN_CUSTOMER", "HUMAN_DELIVERY"]
		return humans[randi() % humans.size()]


func is_non_human(customer_type: String) -> bool:
	return customer_type.begins_with("ENTITY_") or customer_type == "SMILING_MAN"


func get_customer_threat_level(customer_type: String) -> int:
	return customer_properties[customer_type]["threat_level"]


func get_customer_color(customer_type: String) -> Color:
	return customer_properties[customer_type]["color"]
