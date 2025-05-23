# 🪓 Safe Lumberjack

Originally written for UO Sagas by **Hawks 🏹**  
Modified and extended by **Loonatik**

---

## 📋 Overview

Safe Lumberjack is a Razor Enhanced macro designed for the UO Sagas shard. It automates the lumberjacking process while handling targeting, weight management, and tool usage intelligently and safely.

---

## ✅ Features

- Automatically equips a hatchet if one is not equipped
- Prompts for tree targeting and reprompts on invalid targets
- Converts logs into boards when overweight
- Detects and handles tree exhaustion or invalid targeting
- Exits safely if targeting is canceled or no tool is available

---

## 🔧 How to Install in UO Sagas Assistant

1. Launch **UO Sagas Assistant** (click the feather icon in your game bar).
2. Navigate to the **Script Editor** tab.
3. Click **New Script** and name it something like `Safe Lumberjack`.
4. Paste the contents of `safe_lumberjack.lua` into the editor and click **Save**.

---

## ⚙️ Configuration

Before using the script, **edit the top of the script** to set your desired max weight:

```lua
local MAX_WEIGHT = 390
local MAX_WEIGHT_DIFF = 10

- MAX_WEIGHT should be close to your character’s actual weight limit.
- MAX_WEIGHT_DIFF is the buffer zone — when your weight is above MAX_WEIGHT - MAX_WEIGHT_DIFF, the script will convert logs to boards.
