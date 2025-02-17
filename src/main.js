import Copy from 'copy-text-to-clipboard'
window.Copy = Copy

// import { daisyuiThemes } from '../tailwind.config.js'
const daisyuiThemes = [
    "corporate",
    "cmyk",
    "emerald",
    // "pastel", // bad contrast in xCMenu
    "light",
    "dark",
    "abyss",
    "business",
    "dim",
    "dracula",
    "forest",
    "sunset",
  ];
window.daisyuiThemes = daisyuiThemes

import "iconify-icon"

import Alpine from 'alpinejs';
// import collapse from '@alpinejs/collapse'
import focus from '@alpinejs/focus'
import persist from '@alpinejs/persist'

//Alpine.plugin(collapse)
Alpine.plugin(focus)
Alpine.plugin(persist)

window.Alpine = Alpine

Alpine.start()

import * as Prism from 'prismjs';
window.Prism = Prism
Prism.manual = true;
Prism.highlightAll();
/*
*/

// Put 'src/index.js' link in:
//   \webpack.mix.js
// Then build with:
//   \>npx mix build --production
