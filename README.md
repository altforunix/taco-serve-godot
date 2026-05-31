# Taco Serve - 3D Horror Game for Godot 4.3

**Version 2.0 - Enhanced Edition**

A spine-tingling 3D horror game where you work the night shift at a mysterious taco restaurant from 12 AM to 6 AM. Serve tacos to customers (both human and supernatural entities), survive encounters with the Smiling Man, evade the Inspector, and avoid detection by security cameras.

## New Features (Version 2.0)

### 🎵 Audio System
- **Dynamic Audio Manager** with separate buses for Music, SFX, and Ambient sounds
- **Background Music** that plays throughout the game
- **Sound Effects** for all interactions:
  - Jumpscare sounds
  - Alarm alerts
  - Footsteps (random variation)
  - Interaction/pickup sounds
  - Serve/fail sounds
  - Camera detection alerts
  - Smiling Man encounter sounds
  - Inspector arrival sounds
  - Victory/Game Over music
- **Volume Controls** for master, music, and SFX in settings menu

### 🎨 Enhanced Graphics
- **Improved Lighting System**
  - Better ambient light setup
  - Enhanced shadows
  - Atmospheric color grading
- **Advanced Materials**
  - Metallic surfaces (refrigerators, metal counters)
  - Plastic materials (chairs, utensils)
  - Wood textures (tables, shelves)
  - Neon glow effects (signs, emergency lights)
- **Graphics3DHelper** utility class for easy mesh and material creation
- **Improved Environment** with ceiling and better wall construction

### 👥 Extended Customer Types
**Human Customers:**
- HUMAN_WORKER
- HUMAN_CUSTOMER
- HUMAN_DELIVERY

**Supernatural Entities:**
- ENTITY_SHADOW (Threat Level 2)
- ENTITY_WHISPER (Threat Level 1)
- ENTITY_FACELESS (Threat Level 3)
- ENTITY_CONSTRUCT (Threat Level 2)
- SMILING_MAN (Threat Level 5)

Each entity has unique properties:
- Threat levels
- Visual colors
- Movement speeds

### 🎮 Difficulty Levels

**EASY**
- 60s customer spawn interval
- 8s Smiling Man interaction window
- 10% non-human ratio
- 0.5x game speed
- 1.2x ingredient spawn rate

**NORMAL** (Default)
- 45s customer spawn interval
- 5s Smiling Man interaction window
- 20% non-human ratio
- 1.0x game speed
- 1.0x ingredient spawn rate

**HARD**
- 30s customer spawn interval
- 3s Smiling Man interaction window
- 40% non-human ratio
- 1.5x game speed
- 0.8x ingredient spawn rate

**NIGHTMARE**
- 20s customer spawn interval
- 2s Smiling Man interaction window
- 60% non-human ratio
- 2.0x game speed
- 0.5x ingredient spawn rate

### 🏆 Leaderboard System
- **Persistent High Scores** saved locally
- **Top 10 Rankings** with player names
- **Difficulty Tracking** for fair competition
- **Time Survived** recording
- **Score Calculation** based on difficulty and performance
- **Timestamp** recording for each score

## Game Features

- **3D First-Person Gameplay** with smooth WASD movement and mouse-look
- **Dynamic Customer System** with 8 unique customer types
- **Smiling Man Encounter** at 3 AM (survival mechanic)
- **Inspector Visits** with inside/outside detection
- **Security Cameras** detecting non-humans
- **Ingredient Collection** system
- **Taco Recipe Mechanics**
- **Hide Mechanic** (press TAB for black screen overlay)
- **6-Hour Night Shift** (12 AM - 6 AM)
- **Score System** with points for correct recipes, surviving encounters, etc.
- **Audio Settings** with volume sliders
- **Main Menu** for easy navigation

## Controls

- **WASD**: Move around
- **Mouse**: Look around (captured when in-game)
- **E**: Interact with objects
- **TAB**: Hide (black screen overlay)
- **ESC**: Access menus

## Project Structure

```
res://
├── project.godot              # Project configuration
├── Audio/
│   ├── AudioBuses.tres        # Audio bus configuration
│   ├── Music/
│   │   └── night_shift.ogg    # Background music (placeholder)
│   ├── SFX/
│   │   ├── jumpscare.ogg
│   │   ├── alarm.ogg
│   │   ├── footstep_1.ogg
│   │   ├── footstep_2.ogg
│   │   ├── interaction.ogg
│   │   ├── pickup.ogg
│   │   ├── serve.ogg
│   │   ├── fail.ogg
│   │   ├── camera_detect.ogg
│   │   ├── smiling_man_laugh.ogg
│   │   ├── inspector_knock.ogg
│   │   ├── victory.ogg
│   │   └── gameover.ogg
│   └── Ambient/
│       └── restaurant_hum.ogg
├── Scenes/
│   ├── MainScene.tscn
│   ├── Components/
│   │   ├── Counter.tscn
│   │   ├── PrepTable.tscn
│   │   ├── SodaMachine.tscn
│   │   └── Door.tscn
│   ├── Ingredients/
│   │   ├── IngredShell.tscn
│   │   ├── IngredMeat.tscn
│   │   ├── IngredCheese.tscn
│   │   └── IngredLettuce.tscn
│   └── UI/
│       ├── MainMenuScene.tscn
│       ├── DifficultySelectScene.tscn
│       ├── SettingsScene.tscn
│       ├── LeaderboardScene.tscn
│       ├── GameOverScene.tscn
│       └── VictoryScene.tscn
├── Scripts/
│   ├── GameManager.gd
│   ├── Player.gd
│   ├── HUD.gd
│   ├── GlobalGameState.gd
│   ├── AudioManager.gd
│   ├── SoundEffects.gd
│   ├── DifficultyManager.gd
│   ├── CustomerManager.gd
│   ├── LeaderboardManager.gd
│   ├── Graphics3DHelper.gd
│   ├── Components/
│   │   ├── Counter.gd
│   │   ├── PrepTable.gd
│   │   ├── SodaMachine.gd
│   │   └── Door.gd
│   ├── Ingredients/
│   │   ├── IngredShell.gd
│   │   ├── IngredMeat.gd
│   │   ├── IngredCheese.gd
│   │   └── IngredLettuce.gd
│   └── UI/
│       ├── MainMenuScene.gd
│       ├── DifficultySelectScene.gd
│       ├── SettingsScene.gd
│       ├── LeaderboardScene.gd
│       ├── GameOverScene.gd
│       └── VictoryScene.gd
└── README.md
```

## Getting Started

1. **Open Godot 4.3**
2. **Import the project** from the repository
3. **Run the project** - starts at the Main Menu
4. **Select a difficulty** and begin your night shift!
5. **Check the leaderboard** to see top scores

## Audio Setup

To add your own audio files:

1. Place music files in `res://Audio/Music/`
2. Place sound effects in `res://Audio/SFX/`
3. Place ambient sounds in `res://Audio/Ambient/`
4. Update the paths in `Scripts/SoundEffects.gd`

## Leaderboard Data

Leaderboard data is stored at: `user://taco_serve_leaderboard.json`

Format:
```json
[
  {
    "name": "Player Name",
    "score": 1500,
    "difficulty": "HARD",
    "time_survived": 6.0,
    "date": "2024-01-01 12:34:56"
  }
]
```

## Customization

### Add New Customer Types
Edit `Scripts/CustomerManager.gd` to add new entities with custom properties.

### Create Custom Difficulty
Edit `Scripts/DifficultyManager.gd` to add new difficulty presets.

### Add Sound Effects
Use `SoundEffects.play_sound("sound_name", volume)` anywhere in the code.

## Development Notes

- All game mechanics are fully implemented and functional
- Audio system is ready for integration with real audio files
- Graphics use basic Godot primitives but are enhanced with materials
- Leaderboard system uses JSON for persistence
- All difficulty modifiers are dynamically applied
- Customer type detection works with the graphics and threat system

## Performance Optimization

- Audio buses allow efficient volume management
- Difficulty modifiers adjust game speed appropriately
- Graphics use optimized materials and lighting
- Leaderboard loads on demand

## Future Enhancements

- Custom 3D models for entities and environments
- More sophisticated AI for non-human entities
- Multiplayer competitive leaderboard (online)
- Achievement system
- Custom taco recipes
- More dialogue and storytelling
- Advanced lighting and particles

## License

Open source - modify and distribute freely.

---

**Made with Godot 4.3** | **Version 2.0** | **Enhanced Edition**
