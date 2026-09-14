# Jujutsu Shenanigans - Auto Script

A comprehensive Roblox script for **Jujutsu Shenanigans** with auto-farm, combat assist, teleport, and GUI features.

## Features ✨

✅ **Auto Farm** - Automatically farms enemies within range  
✅ **Auto Combat** - Automatically attacks nearby enemies  
✅ **Auto Spam** - Spam attacks for maximum damage  
✅ **Auto Heal** - Automatically heals when health is low  
✅ **Teleport** - Quick teleportation to enemies  
✅ **GUI Interface** - Easy-to-use on-screen controls  
✅ **No Key Required** - Auto-runs when injected  
✅ **Keyboard Shortcuts** - Quick toggle with F, C, S, H keys  

## Installation 🚀

### Method 1: Copy-Paste (Easiest)
1. Open your Roblox executor (Synapse X, Script-Ware, Krnl, etc.)
2. Copy the entire code from `jujutsu_shenanigans_main.lua`
3. Paste into your executor console
4. Click Execute
5. Script will auto-run!

### Method 2: Direct Link
Use this raw GitHub link in your executor:
```
https://raw.githubusercontent.com/flash12345677/jujutsu-shenanigans-script/main/jujutsu_shenanigans_main.lua
```

## Controls 🎮

### GUI Buttons
- **Auto Farm** - Toggle automatic farming
- **Auto Combat** - Toggle automatic combat
- **Auto Spam** - Toggle attack spamming
- **Auto Heal** - Toggle automatic healing
- **STOP SCRIPT** - Stop the script completely

### Keyboard Shortcuts
| Key | Function |
|-----|----------|
| **F** | Toggle Auto Farm |
| **C** | Toggle Auto Combat |
| **S** | Toggle Auto Spam |
| **H** | Toggle Auto Heal |
| **End** | Stop Script |

## Configuration ⚙️

Edit these values in the script to customize:

```lua
local Config = {
    AutoFarm = true,      -- Start with auto farm enabled
    AutoCombat = true,    -- Start with auto combat enabled
    AutoSpam = true,      -- Start with auto spam enabled
    AutoHeal = true,      -- Start with auto heal enabled
    Teleport = true,      -- Enable teleportation
    ShowGUI = true,       -- Show GUI on startup
    FarmRange = 100,      -- Range to find enemies (studs)
    CombatRange = 50,     -- Range to start attacking (studs)
    SpamDelay = 0.1,      -- Delay between attacks (seconds)
}
```

## How It Works 📊

### Auto Farm Loop
- Scans for enemies within `FarmRange`
- Teleports to the closest enemy
- Automatically attacks when in range
- Continues until toggled off

### Auto Combat
- Attacks enemies in proximity
- Uses spam attacks for maximum damage
- Works together with auto farm

### Auto Heal
- Monitors player health
- Heals automatically when health drops below 50%
- Uses the H key (adjust if different in your game)

### GUI Updates
- Real-time enemy count display
- Status indicators
- One-click toggles for all features
- Draggable interface

## Troubleshooting 🔧

**Script not working?**
- Make sure you're using a working executor
- Check that the game hasn't patched the script
- Verify you're running on the correct game (Jujutsu Shenanigans)

**Getting killed too fast?**
- Lower `SpamDelay` for faster attacks
- Increase `FarmRange` to find enemies earlier
- Enable `AutoHeal` and adjust health threshold

**Script not detecting enemies?**
- Check if `FarmRange` is set high enough
- Make sure enemies are visible/alive
- Try restarting the script

**GUI not showing?**
- Make sure `ShowGUI = true` in config
- Check Player GUI settings aren't blocking it

## Safety & Disclaimer ⚠️

- **Use at your own risk** - Roblox can ban accounts for using scripts
- **Test on alt account first** - Never use on your main account
- **Use VPN/Proxy** - Some games detect script usage patterns
- **Don't be obvious** - Rapid movements/teleports can trigger detection
- **Take breaks** - Don't farm 24/7

## Updates & Support 📝

For updates and improvements, check back here regularly!

**Last Updated:** 2026-09-14  
**Version:** 1.0  
**Status:** Working ✅

---

*Made for educational purposes. Use responsibly!*
