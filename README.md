# SketchyBar Configuration

A clean and minimal SketchyBar configuration with the beautiful **Rosé Pine** colorscheme.

## Features

- 🎨 **Rosé Pine Theme**: Soft, warm color palette that's easy on the eyes
- ✨ **Elegant Design**: Purple accents for icons, subtle backgrounds
- 📦 **Modular**: Well-organized configuration with separate files for colors, settings, and items
- 🔧 **Customizable**: Easy to extend with new items and widgets

## Installation

1. Clone this repository to your SketchyBar config directory:
```bash
git clone https://github.com/yourusername/sketchybar-config ~/.config/sketchybar
```

2. Install SketchyBar if you haven't already:
```bash
brew install sketchybar
```

3. Reload the configuration:
```bash
sketchybar --reload
```

## Configuration Structure

```
.
├── colors.lua           # Rosé Pine color palette
├── bar.lua             # Bar styling and layout
├── default.lua         # Default styling for items
├── settings.lua        # Global settings (fonts, paddings)
├── icons.lua           # Icon definitions
├── init.lua            # Initialization logic
├── sketchybarrc        # Main configuration entry point
├── items/              # Item configurations
│   ├── apple.lua
│   ├── spaces.lua
│   ├── front_app.lua
│   ├── media.lua
│   └── ...
└── helpers/            # Helper functions and utilities
```

## Colors

All colors use the **Rosé Pine** palette:

- **Base**: `#191724` - Primary background
- **Surface**: `#1f1d2e` - Secondary background
- **Text**: `#e0def4` - Primary text color
- **Iris**: `#c4a7e7` - Purple accent (icons)
- **Foam**: `#3e8fb0` - Blue accent
- **Pine**: `#31748f` - Green accent
- **Love**: `#eb6f92` - Red/Pink accent
- **Gold**: `#f6c177` - Yellow accent

## Customization

Edit `colors.lua` to change the color palette, or modify `default.lua` to adjust the styling of items.

## License

Feel free to use and modify this configuration however you like!
