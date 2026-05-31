extends Node

class_name WeaponSystem

enum WEAPON_TYPE { FLASH, EMF, CHARM, PRAYER }

var weapons: Dictionary = {}
var player_weapons: Dictionary = {}
var equipped_weapon: String = ""

signal weapon_equipped(weapon_id: String)
signal weapon_used(weapon_id: String, target: Node3D)
signal weapon_cooldown_started(weapon_id: String, duration: float)

func _ready() -> void:
	name = "WeaponSystem"
	add_to_group("weapons")
	initialize_weapons()

func initialize_weapons() -> void:
	weapons = {
		"flashlight": {
			"name": "Flashlight",
			"type": WEAPON_TYPE.FLASH,
			"damage": 0,
			"range": 20.0,
			"cooldown": 0.5,
			"effect": "Reveals hidden entities",
			"description": "Essential tool for seeing in the dark"
		},
		"emf_detector": {
			"name": "EMF Detector",
			"type": WEAPON_TYPE.EMF,
			"damage": 0,
			"range": 10.0,
			"cooldown": 1.0,
			"effect": "Detects supernatural presence",
			"description": "Alerts you to nearby entities"
		},
		"charm_shield": {
			"name": "Charm Shield",
			"type": WEAPON_TYPE.CHARM,
			"damage": 0,
			"range": 5.0,
			"cooldown": 5.0,
			"effect": "Temporarily repels entities",
			"description": "Protective charm of ancient origin"
		},
		"prayer_book": {
			"name": "Prayer Book",
			"type": WEAPON_TYPE.PRAYER,
			"damage": 0,
			"range": 15.0,
			"cooldown": 3.0,
			"effect": "Weakens entities temporarily",
			"description": "Holy texts of power"
		}
	}

func equip_weapon(weapon_id: String) -> void:
	if weapon_id in weapons:
		equipped_weapon = weapon_id
		weapon_equipped.emit(weapon_id)

func use_weapon(target: Node3D) -> void:
	if equipped_weapon.is_empty() or equipped_weapon not in weapons:
		return
	
	var weapon = weapons[equipped_weapon]
	weapon_used.emit(equipped_weapon, target)
	weapon_cooldown_started.emit(equipped_weapon, weapon["cooldown"])

func get_equipped_weapon() -> Dictionary:
	if equipped_weapon.is_empty():
		return {}
	return weapons.get(equipped_weapon, {})

func grant_weapon(weapon_id: String) -> void:
	if weapon_id in weapons:
		player_weapons[weapon_id] = weapons[weapon_id]

func get_player_weapons() -> Dictionary:
	return player_weapons.duplicate()
