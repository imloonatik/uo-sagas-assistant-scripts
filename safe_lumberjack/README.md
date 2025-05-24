# 🪓 Safe Lumberjack

Originally written for UO Sagas by **Hawks 🏹**  
Modified and extended by **Loonatik**

---

## 📋 Overview

Safe Lumberjack is a scripting macro for the UO Sagas Assistant. It automates lumberjacking with smart targeting, automatic tool handling, and weight-based log processing.

---

## ✅ Features

- Automatically equips a hatchet if one is not equipped
- Prompts for tree targeting and reprompts on invalid targets
- Converts logs into boards when approaching weight limit
- Detects and handles tree exhaustion or invalid clicks

---

## 🔧 How to Install in UO Sagas Assistant

1. Open the UO Sagas Assistant (feather icon in the game bar)
2. Go to the **Script Editor** tab
3. Click **New Script** and name it `Safe Lumberjack`
4. Paste in the contents of `safe_lumberjack.lua`
5. Save the script

---

## ⚙️ Configuration

You no longer need to configure your maximum weight manually.  
The script uses the character's actual weight limit via:

```lua
Player.MaxWeight
