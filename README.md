# 🎮 TACO SERVE 3.0 - The Ultimate Horror Experience

**Version 3.0 - Complete Edition**

## 🚀 WHAT'S NEW IN 3.0?

### 🎯 **Quest System** ✨
Fully-featured quest system with 6 unique quests:
- **Serve Your First Taco** - Learn the ropes (100 pts)
- **Survive the Smiling Man** - Encounter and survive (500 pts)
- **Escape Inspector Detection** - Evade successfully (300 pts)
- **Efficient Service** - Serve 5 customers (250 pts)
- **See the Unseen** - Detect 3 entities (200 pts)
- **Ultimate Survivor** - Complete the full shift (bonus)

Features:
- Quest tracking in HUD
- Progress indicators
- Reward points
- State management (NOT_STARTED, IN_PROGRESS, COMPLETED, FAILED)

### 🏆 **Achievement System** ✨
**8 Achievements** to unlock:
1. **First Serve** 🌮 - Serve your first taco
2. **Speed Demon** ⚡ - Complete HARD without failures
3. **Nightmare Survivor** 💀 - Beat NIGHTMARE mode
4. **Entity Whisperer** 👽 - Encounter all 5 entity types
5. **Perfectionist** ✨ - Achieve 1000+ score
6. **Smiling Friend** 😊 - Successfully interact with Smiling Man
7. **Inspector Evader** 🎩 - Evade inspector 3 times
8. **Leaderboard King** 👑 - Reach #1 on leaderboard

Features:
- Automatic tracking
- Unlock notifications
- Completion percentage
- Hidden achievements

### 🧠 **Sanity System** ✨
Psychological horror mechanics:
- **Sanity Meter** (0-100%)
- **Drains from:**
  - Entity encounters (-10 each)
  - Jumpscares (-20)
  - Time passage (-0.5 per second)
- **Visual Effects:**
  - Screen distortion based on sanity
  - FOV changes
  - Color overlay shifts
- **Critical State:** When sanity hits 0%, game over

### 🍲 **Enhanced Recipe System** ✨
**5 Unique Recipes:**
1. **Classic Taco** (100 pts) - Shell, Meat, Cheese, Lettuce
2. **Cheese Blast** (150 pts) - Shell, Cheese x3, Lettuce
3. **Meat Lover** (150 pts) - Shell, Meat x2, Cheese
4. **Veggie Delight** (100 pts) - Shell, Lettuce x2, Cheese
5. **Master Taco** (300 pts) - Shell x2, Meat x2, Cheese x2, Lettuce x2

Features:
- Difficulty ratings
- Point rewards
- Ingredient tracking
- Recipe selection menu

### 💬 **Dialogue System** ✨
Fully-featured dialogue system with:
- **4 Character Types:**
  - Smiling Man (eerie greetings)
  - Inspector (authoritative)
  - Customers (friendly/neutral)
  - Entities (terrifying whispers)
- Multi-line conversations
- Character-specific dialogues
- Signal-based triggering

### ⚔️ **Weapon System** ✨
**4 Protective Tools:**
1. **Flashlight** 🔦
   - Reveals hidden entities
   - 20m range
   - 0.5s cooldown

2. **EMF Detector** 📡
   - Detects supernatural presence
   - 10m range
   - 1s cooldown

3. **Charm Shield** ✨
   - Temporarily repels entities
   - 5m range
   - 5s cooldown

4. **Prayer Book** 📖
   - Weakens entities
   - 15m range
   - 3s cooldown

Features:
- Equipment system
- Cooldown tracking
- Range-based effectiveness

### 💾 **Save System** ✨
Complete save/load functionality:
- **Multiple Save Slots** (10 slots)
- **Auto-Save** during gameplay
- **Save Data Includes:**
  - Current inventory
  - Score/stats
  - Game state
  - Timestamp
  - Progress tracking
- **JSON Format** for easy debugging
- **Save Location:** `user://taco_serve_saves/`

### 📊 **Advanced Analytics** ✨
Comprehensive gameplay tracking:
- **Session Data:**
  - Session ID
  - Start time
  - Game version
  - Duration tracking
- **Event Logging:**
  - Customer served
  - Achievements unlocked
  - Game completions
  - Difficulty/score data
- **Performance Metrics**
- **Player Behavior Analysis**

### 🤖 **AI System** ✨
Entity AI with states:
- **IDLE** - Waiting
- **PATROL** - Moving through areas
- **CHASE** - Pursuing player
- **INTERACT** - Special behaviors
- **DEAD** - Defeated state

Features:
- Pathfinding
- Player detection
- Distance tracking
- State transitions

### 🎮 **Enhanced HUD** ✨
New HUD elements:
- **Sanity Bar** (visual + text)
- **Quest Display** (active quests)
- **Dialogue Box** (character conversations)
- **Dynamic Colors** (sanity-based)
- **Toast Notifications** (events)

## 📦 Complete Feature List

✅ 8-part quest system
✅ 8 unique achievements
✅ Psychological sanity meter
✅ 5 taco recipes
✅ Dynamic dialogue system
✅ 4 protective weapons
✅ Entity AI with states
✅ Advanced save/load
✅ Analytics tracking
✅ Enhanced graphics
✅ Full audio system
✅ 4 difficulty levels
✅ Persistent leaderboard
✅ 8+ customer types
✅ Smiling Man encounter
✅ Inspector mechanics
✅ Security cameras
✅ Hide mechanic
✅ Inventory system
✅ Score system
✅ Professional UI

## 🎮 Game Flow

1. **Main Menu** → Start, Settings, Leaderboard, Quit
2. **Difficulty Selection** → Choose EASY/NORMAL/HARD/NIGHTMARE
3. **Quest Briefing** → See your missions
4. **Gameplay**
   - Collect ingredients
   - Serve customers (match recipes)
   - Survive encounters
   - Track sanity
   - Complete quests
   - Unlock achievements
5. **Victory/Defeat**
   - Final stats
   - Score calculation
   - Quest rewards
   - Achievement unlocks
   - Leaderboard position
6. **Post-Game** → Save, Review Stats, Play Again

## 🚀 Getting Started

1. Open Godot 4.3
2. Import project from repository
3. Run the project (F5)
4. Start at Main Menu
5. Enjoy the full horror experience!

## 💾 Project Structure

```
res://
├── Scripts/
│   ├── GameManager.gd (Enhanced)
│   ├── Player.gd
│   ├── HUD.gd (Enhanced)
│   ├── AudioManager.gd
│   ├── DifficultyManager.gd
│   ├── CustomerManager.gd
│   ├── LeaderboardManager.gd
│   ├── Graphics3DHelper.gd
│   ├── SoundEffects.gd
│   ├── AI/
│   │   └── EntityAI.gd (NEW)
│   ├── Entities/
│   │   └── InteractiveEntity.gd (NEW)
│   ├── Systems/ (NEW)
│   │   ├── QuestSystem.gd
│   │   ├── AchievementSystem.gd
│   │   ├── RecipeSystem.gd
│   │   ├── DialogueSystem.gd
│   │   ├── WeaponSystem.gd
│   │   ├── HorrorEffectsSystem.gd
│   │   ├── SaveSystem.gd
│   │   └── AnalyticsSystem.gd
│   ├── Components/
│   ├── Ingredients/
│   └── UI/
├── Scenes/
│   ├── MainScene.tscn (Enhanced)
│   ├── Components/
│   ├── Ingredients/
│   └── UI/
├── Audio/
│   ├── Music/
│   ├── SFX/
│   ├── Ambient/
│   └── AudioBuses.tres
└── project.godot
```

## 🎨 Advanced Features

### Sanity System
- Visual distortion increases with low sanity
- FOV expands as sanity decreases
- Color overlay effects
- Critical alert at 0%

### Quest Tracking
- Progress percentage display
- Completion rewards
- Auto-triggers on conditions
- Failure conditions

### Achievement Unlocking
- Automatic detection
- Toast notifications
- Completion counter
- Badge system

### Save System
- Automatic saves every 5 minutes
- Manual save slots
- Load from any slot
- Save deletion

## 📊 Analytics Captured

- Session duration
- Event timestamps
- Customer service data
- Achievement unlock patterns
- Game completion stats
- Difficulty-based performance
- Player behavior analysis

## 🔧 Customization

Easily modify:
- Quest conditions
- Achievement thresholds
- Sanity drain rates
- Recipe ingredients
- Weapon ranges/cooldowns
- AI patrol paths
- Dialogue text
- Save slot limits

## 🎯 Design Philosophy

TACO SERVE 3.0 combines:
- **Gameplay Depth** - Multiple systems working together
- **Psychological Horror** - Sanity mechanics
- **Progression** - Quests and achievements
- **Replayability** - Multiple difficulties and quests
- **Accessibility** - Save/load system
- **Analytics** - Track player engagement

## 🏁 Version History

- **v1.0** - Core game mechanics
- **v2.0** - Audio, graphics, difficulty, leaderboard
- **v3.0** - Quest system, achievements, sanity, dialogue, weapons, save/load, analytics

---

**Made with Godot 4.3** | **Version 3.0** | **The Ultimate Edition**

**Status:** ✅ FULLY FUNCTIONAL - NO PLACEHOLDERS
