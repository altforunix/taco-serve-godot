# Taco Serve - 3D Horror Game for Godot 4.3

A spine-tingling 3D horror game where you work the night shift at a mysterious taco restaurant from 12 AM to 6 AM. Serve tacos to customers (both human and non-human), survive encounters with the Smiling Man, evade the Inspector, and avoid detection by security cameras.

## Features

- **3D First-Person Gameplay**: Navigate the restaurant using WASD movement and mouse-look controls
- **Dynamic Customer System**: Customers spawn every 45 seconds (80% human, 20% non-human)
- **Smiling Man Encounter**: A terrifying creature appears at 3 AM with a 5-second interaction window to survive
- **Inspector Visits**: Random inspector checks that require you to be inside the restaurant
- **Security Cameras**: Detect non-human customers and trigger "MONSTER DETECTED" alerts
- **Ingredient Collection**: Gather shells, meat, cheese, and lettuce
- **Taco Recipes**: Prepare correct recipes to serve satisfied customers
- **Hide Mechanic**: Press TAB to pull up a black screen and hide from threats
- **6-Hour Shift**: Time runs from 12 AM to 6 AM - survive until dawn for victory

## Controls

- **WASD**: Move around
- **Mouse**: Look around (captured when in-game)
- **E**: Interact with objects
- **TAB**: Hide (black screen overlay)
- **Click**: Confirm actions

## Game Mechanics

### Time System
The game runs in real-time (accelerated) from 12 AM to 6 AM. Survive until 6 AM to win.

### Customer Spawning
Customers spawn every 45 seconds. Each customer is:
- 80% chance: HUMAN (normal customer)
- 20% chance: NON-HUMAN (detected by security camera)

### Smiling Man (3 AM)
At 3 AM, the Smiling Man appears at the Soda Machine. You have 5 seconds to interact with him to survive. Failure results in instant game over.

### Inspector Visits
Random inspector checks occur between 1 AM and 5 AM. The inspector requires you to be inside the building (within bounds). Failure to meet this requirement results in immediate termination.

### Security Camera
Monitors the restaurant and displays "MONSTER DETECTED" if a non-human customer is spotted.

## Project Structure

```
res://
├── project.godot          # Project configuration
├── Scenes/
│   ├── MainScene.tscn     # Main game scene
│   ├── Components/        # Interactive objects
│   │   ├── Counter.tscn
│   │   ├── PrepTable.tscn
│   │   ├── SodaMachine.tscn
│   │   └── Door.tscn
│   ├── Ingredients/       # Collectible items
│   │   ├── IngredShell.tscn
│   │   ├── IngredMeat.tscn
│   │   ├── IngredCheese.tscn
│   │   └── IngredLettuce.tscn
│   └── UI/
│       ├── GameOverScene.tscn
│       └── VictoryScene.tscn
├── Scripts/
│   ├── GameManager.gd     # Core game logic
│   ├── Player.gd          # Player controller
│   ├── HUD.gd             # UI management
│   ├── GlobalGameState.gd # Persistent game data
│   ├── Components/        # Component scripts
│   │   ├── Counter.gd
│   │   ├── PrepTable.gd
│   │   ├── SodaMachine.gd
│   │   └── Door.gd
│   ├── Ingredients/       # Ingredient scripts
│   │   ├── IngredShell.gd
│   │   ├── IngredMeat.gd
│   │   ├── IngredCheese.gd
│   │   └── IngredLettuce.gd
│   └── UI/
│       ├── GameOverScene.gd
│       └── VictoryScene.gd
└── README.md
```

## Getting Started

1. Open the project in Godot 4.3
2. Open `Scenes/MainScene.tscn`
3. Press Play (F5) to start the game
4. Survive the night shift!

## Development Notes

- All gameplay mechanics are fully implemented
- Audio placeholders are ready for sound effects integration
- Lighting setup uses DirectionalLight3D and AmbientLight3D
- Assets use basic Godot primitives (CSGBox3D, BoxMesh) for placeholders
- All scripts are fully functional with no TODOs

## Future Enhancements

- Add sound effects and music
- Improve graphics with custom models
- Add more customer types
- Implement difficulty levels
- Add leaderboard system

## License

Open source - modify and distribute freely.
