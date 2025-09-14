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

The tool will:
1. Create the necessary directory structure
2. Generate a new entry file if it doesn't exist
3. Open the file in your editor with cursor positioned at the end

### Write Mode (`-w`)
When using `clog -w`, the tool adds a new timestamped subheader (e.g., `## 14:30`) to the current day's entry, allowing you to add multiple entries throughout the day. You can also provide text directly: `clog -w "Your entry text"` to add an entry without opening the editor.

## Example

Running `clog` creates and opens:
```
~/Documents/captains-log/2024/09/14.md
```

With content like:
```markdown
# Captain's Log - Saturday, September 14, 2024

```

Using `clog -w` throughout the day creates:
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

