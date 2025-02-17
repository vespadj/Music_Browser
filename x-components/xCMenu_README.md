# xCMenu Component

A lightweight contextual menu component built with Alpine.js and daisyUI.

## Features

- Right-click context menu for data tables
- Theme-aware using daisyUI
- Customizable menu items with icons
- Automatic positioning within viewport
- Click-outside to close

## Dependencies

- Alpine.js
- Tailwind CSS
- daisyUI
- Iconify (for icons)

## Usage

```html
<div x-data="xCMenu">
  <!-- Your table or clickable element -->
  <div @click="xCMenu_open($event, row, 'music_track')">
    <!-- Content -->
  </div>
  
  <!-- Include the menu component -->
  <div x-html="xCMenu.html"></div>
</div>
