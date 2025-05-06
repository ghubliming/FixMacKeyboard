# FixMacKeyboard

This small script helps automatically switch to a Windows-style keyboard layout on a Windows laptop when using a Mac-layout Bluetooth keyboard.

## 🧠 What It Does

- Detects if a **Bluetooth HID keyboard** is connected (e.g., Mac-style keyboard).
- If detected, it automatically launches **Key Mapper**:
  - Starts `keymapperd.exe` with ~admin rights~ (for full mapping support, like the Windows key).
  - Starts `keymapper.exe` normally to apply the custom key layout.

This setup is especially useful if you're using a **Mac layout keyboard on a Windows machine** and want to remap keys (e.g., Command ⌘ → Ctrl or Alt).

## ⚙️ Workflow

1. At login, the script checks for any connected Bluetooth keyboard.
2. If one is found:
   - Starts Key Mapper services to remap keys.
3. If not, it exits quietly.

## 🛠 Requirements

- Keymapper Tool https://github.com/houmain/keymapper
- Bluetooth keyboard (Mac layout preferred)
- This script set up to run via **Task Scheduler** with admin rights (optional but recommended)

## 📁 Files

- `fix_mac_keyboard.ps1` — Main PowerShell script

~## 🔒 Admin Privileges~

~The script starts `keymapperd.exe` with elevated privileges to allow remapping of special keys like the Windows key and keys in admin apps (like Task Manager).~

~## 📝 Tip~

~For silent startup without UAC prompts, schedule this script using **Windows Task Scheduler** with **"Run with highest privileges"**.~

