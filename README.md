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

# Add a new timestamped entry to today's log
clog -w

# Quick entry without opening editor
clog -w "Meeting notes: discussed project timeline"
```

**Write Mode (`-w`)**: Adds timestamped entries (e.g., `## 14:30`) for multiple entries per day. Include text to skip the editor.

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

## Requirements

- Lua 5.4+
- nvim (or configure a different editor)

