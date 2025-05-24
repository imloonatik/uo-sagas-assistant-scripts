# 🪓 Safe Lumberjack

Originally written for UO Sagas by **Hawks 🌽**
Modified and extended by **Loonatik**

---

## 📋 Overview

Safe Lumberjack is a scripting macro for the UO Sagas Assistant. It automates lumberjacking with smart targeting, automatic tool handling, and weight-based log processing. It’s designed to be safe, responsive, and efficient for use in UO Sagas.

---

## ✅ Features

* Automatically equips a hatchet if one is not equipped
* Prompts for tree targeting and reprompts on invalid targets
* Converts logs into boards when approaching your character’s weight limit
* Detects and handles tree exhaustion or invalid clicks
* Exits safely if targeting is canceled or no hatchet is found

---

## 🔧 How to Install in UO Sagas Assistant

1. Open the **UO Sagas Assistant** (click the feather icon on the menu bar)
2. Go to the **Script Editor** tab
3. Click **New Script** and name it something like `Safe Lumberjack`
4. Paste in the contents of `safe_lumberjack.lua`
5. Save the script

---

## ⚙️ Configuration

The script automatically uses your character’s current weight limit via:

```lua
Player.MaxWeight
```

You can control how close you get to that limit before the script starts converting logs into boards using:

```lua
local MAX_WEIGHT_DIFF = 10
```

This sets the **buffer threshold**. For example:

* If your `Player.MaxWeight` is 390
* And `MAX_WEIGHT_DIFF = 10`
* The script will begin chopping boards when you hit 380 weight

Adjust this value if you want to carry more (or less) before converting.

---

## 🎯 How to Assign a Hotkey

1. Go to the **Hot Keys** tab in the Assistant
2. Under the **Scripts** section, select `Safe Lumberjack`
3. Assign a keybind (e.g., `F6`)
4. Press the key in-game to start the script

---

## 💡 Usage Notes

* When starting, the script prompts you to select a tree
* If you misclick (e.g., wall or rock), it will ask again
* If you cancel targeting (ESC or right-click), you may have to stop the script and start it again
* If no hatchet is equipped or found, the script also stops safely
* Logs are automatically converted to boards when weight is near your max

---

## 📄 License

This script is licensed under the [MIT License](../LICENSE)
