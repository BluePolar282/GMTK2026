# What this is
This is a platformer game submission for GMTK Game Jam 2026, built with Godot 4.7 in GDScript. The game features a player character that must dodge falling meteors while surviving until a countdown timer expires—a classic survival-against-the-elements mechanic.

# Stack
- Language: GDScript
- Framework / runtime: Godot 4.7 with GL Compatibility renderer
- Physics: Jolt Physics (3D engine configured, though game is 2D)
- Notable mechanics: State machine for player movement, procedural meteor spawning, countdown timer

# How it's organized

```
Player/
  scripts/
    character_body_2d.gd    Player state machine (fall, floor, jump, double-jump, dash)
  scenes/
    character_body_2d.tscn  Player scene with animations and collision
  assets/                   (sprites, animation frames)

World/
  scripts/
    world.gd              Scene coordinator (main setup)
    countdown.gd          60-second survival timer
    meteor.gd             Falling meteor physics and collision
    progress_bar.gd       UI for timer display
  scenes/
    world.tscn            Main game level (56KB scene file)
    meteor.tscn           Meteor prefab template
    countdown.tscn        Timer UI node

Utilities/
  scenes/                 Reusable UI/utility components
  scripts/

items/                     (Currently empty, likely for powerups)
```

How it fits together: The game loop runs within world.tscn, which instantiates the player character and spawns meteors on a timer. The player script implements a state machine (FALL → JUMP → DJUMP → DASH → FLOOR) handling input and platformer physics. The countdown timer tracks survival time, while meteors fall with gravity and check for collision with the player. A progress bar visually represents remaining time.
