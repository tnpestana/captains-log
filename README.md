# Captain's Log ⚓

A simple command-line daily journaling tool for maintaining organized daily logs.

## What It Does

Captain's Log creates and manages daily journal entries organized by date. Each day gets its own markdown file stored in a clean directory structure.

- **Creates daily entries** automatically organized as `entries/YYYY/MM/DD.md`
- **Opens entries in your editor** (nvim by default) for writing
- **Generates entry templates** with date headers and sections
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
```

That's it! The tool will:
1. Create the necessary directory structure
2. Generate a new entry file if it doesn't exist
3. Open the file in your editor for writing

## Example

Running `clog` creates and opens:
```
~/Documents/CaptainsLog/2024/09/14.md
```

With content like:
```markdown
# Captain's Log - Saturday, September 14, 2024

## Goals for Today


## What Happened


## Reflections

```

## Requirements

- Lua 5.4+
- nvim (or configure a different editor)

---

*Keep a steady course through your daily thoughts and experiences.* 🧭