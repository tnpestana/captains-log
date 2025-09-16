# Captain's Log ⚓

A simple command-line daily journaling tool for maintaining organized daily logs.

## What It Does

Captain's Log creates and manages daily journal entries organized by date. Each day gets its own markdown file stored in a clean directory structure.

- **Creates daily entries** automatically organized as `YYYY/MM/DD.md`
- **Multiple entries per day** with timestamped subheaders
- **Opens entries in your editor** (nvim by default) with cursor at the end
- **Quick inline entries** without opening the editor
- **Handles directory creation** automatically - no setup required

## Installation

```bash
brew tap tnpestana/tap
brew install captains-log
```

## Usage

```bash
# Create or open today's entry
clog

# Quick entry without opening editor
clog -w "Meeting notes: discussed project timeline"

# Show help
clog -h
```

**Write Mode (`-w`)**: Adds timestamped entries (e.g., `## 14:30`) for multiple entries per day. Requires text input.

## Example Output
```markdown
# Captain's Log - Saturday, September 14, 2024

## 09:30
Morning standup notes...

## 14:30
Afternoon progress update...

## 18:45
End of day summary...
```

## Configuration

Captain's Log supports user configuration through a Lua config file located at:
- `$XDG_CONFIG_HOME/captains-log/config.lua`
- Or `~/.config/captains-log/config.lua` if `XDG_CONFIG_HOME` is not set

### Default Configuration

If no config file exists, the following defaults are used:

```lua
{
  base_dir = os.getenv("HOME") .. "/Documents/captains-log",
  editor = "vi"
}
```

### Custom Configuration

Create a config file to customize settings:

```lua
-- ~/.config/captains-log/config.lua
return {
  base_dir = "/path/to/your/journal/directory",
  editor = "nvim"  -- or "vim", "code", "nano", etc.
}
```

The config file is loaded automatically on each run. If the file doesn't exist or has syntax errors, the default configuration is used instead.

## Requirements

- Lua 5.4+

