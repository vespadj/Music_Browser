========================
CODE SNIPPETS
========================
TITLE: Quickstart: Install and Build Alpine.js
DESCRIPTION: Steps to clone the repository, install dependencies, and build the project for local use. This includes including the CDN build in a web page.

SOURCE: https://github.com/alpinejs/alpine/blob/main/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
git clone <repository-url>
cd alpine
npm install
npm run build
# Include /packages/alpinejs/dist/cdn.js in a <script> tag
```

----------------------------------------

TITLE: Include Alpine.js via CDN Script Tag (HTML)
DESCRIPTION: This method is the simplest way to get started with Alpine.js. Include the provided script tag in the head of your HTML page, ensuring the 'defer' attribute is present. For production stability, it's recommended to hardcode the specific version number in the CDN link.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/essentials/installation.md#_snippet_0

LANGUAGE: html
CODE:
```
<html>
    <head>
        ...

        <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
    </head>
    ...
</html>
```

LANGUAGE: html
CODE:
```
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.14.9/dist/cdn.min.js"></script>
```

----------------------------------------

TITLE: Basic Alpine.js HTML Setup
DESCRIPTION: This snippet shows the minimal HTML structure required to include Alpine.js via CDN and render a simple Alpine-powered element.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/start-here.md#_snippet_0

LANGUAGE: html
CODE:
```
<html>
<head>
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
</head>
<body>
    <h1 x-data="{ message: 'I ❤️ Alpine' }" x-text="message"></h1>
</body>
</html>
```

----------------------------------------

TITLE: Import and Start Alpine.js Module (JavaScript)
DESCRIPTION: After installing Alpine.js via NPM, import the library into your main JavaScript bundle and initialize it by calling `Alpine.start()`. It's optional but recommended to expose Alpine globally via `window.Alpine` for easier debugging and interaction.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/essentials/installation.md#_snippet_2

LANGUAGE: javascript
CODE:
```
import Alpine from 'alpinejs'

window.Alpine = Alpine

Alpine.start()
```

----------------------------------------

TITLE: Alpine.js Search Input Component
DESCRIPTION: Illustrates creating a search input component with Alpine.js. It features x-data for managing search state and item lists, computed properties (get filteredItems) for filtering, x-model for input binding, and x-for with x-text for rendering filtered results.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/start-here.md#_snippet_6

LANGUAGE: alpine
CODE:
```
<div
    x-data="{
        search: '',

        items: ['foo', 'bar', 'baz'],

        get filteredItems() {
            return this.items.filter(
                i => i.startsWith(this.search)
            )
        }
    }"
>
    <input x-model="search" placeholder="Search...">

    <ul>
        <template x-for="item in filteredItems" :key="item">
            <li x-text="item"></li>
        </template>
    </ul>
</div>
```

----------------------------------------

TITLE: Alpine.js Morphing: Start and Log Updates
DESCRIPTION: Demonstrates initializing Alpine.js morphing with custom logging and performing DOM updates. It sets up a logger to capture morphing messages and updates specific DOM elements with the 'from' and 'to' HTML. The `Alpine.morph` function is then called with debugging enabled and a custom key function.

SOURCE: https://github.com/alpinejs/alpine/blob/main/morph.html#_snippet_0

LANGUAGE: javascript
CODE:
```
function start() {
  Alpine.morph.log((message, from, to) => {
    console.log(message, from, to)
    document.querySelector('#log-from').innerHTML = escape(from.outerHTML)
    document.querySelector('#log-to').innerHTML = escape(to.outerHTML)
    let li = document.createElement('li')
    li.textContent = message
    message && document.querySelector('#log-message').appendChild(li)
  })
  Alpine.morph(
    document.querySelector('#before').firstElementChild,
    document.querySelector('#after').firstElementChild.outerHTML,
    {
      debug: true,
      key(el) {
        return el.dataset.key
      }
    }
  )
}

function next() {
  Alpine.morph.step()
  setTimeout(() => window.dispatchEvent(new CustomEvent('refresh', { bubbles: true })))
}

function escape(unsafe) {
  return unsafe
    .replace(/\n/g, "⬎\n")
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}
```

----------------------------------------

TITLE: Initialize Alpine CSP Build from NPM
DESCRIPTION: Initializes the Alpine.js CSP build after installing it via NPM. This involves importing Alpine and starting it, typically in your main JavaScript file.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/advanced/csp.md#_snippet_2

LANGUAGE: javascript
CODE:
```
import Alpine from '@alpinejs/csp'

window.Alpine = Alpine

Alpine.start()
```

----------------------------------------

TITLE: Install Alpine.js using NPM (Shell)
DESCRIPTION: For a more robust approach, Alpine.js can be installed as a project dependency using NPM. This allows you to import and bundle Alpine.js with your application's JavaScript code.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/essentials/installation.md#_snippet_1

LANGUAGE: shell
CODE:
```
npm install alpinejs
```

----------------------------------------

TITLE: Alpine.js x-on Directive
DESCRIPTION: Shows the `x-on` directive (shorthand `@`) for listening to DOM events. This example attaches a click listener to a button that executes a JavaScript expression to modify component state.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/start-here.md#_snippet_3

LANGUAGE: html
CODE:
```
<button x-on:click="count++">Increment</button>
```

----------------------------------------

TITLE: Install Collapse Plugin via NPM
DESCRIPTION: Install the Collapse plugin using NPM and import it into your JavaScript bundle to initialize it with Alpine.js.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/collapse.md#_snippet_1

LANGUAGE: shell
CODE:
```
npm install @alpinejs/collapse
```

LANGUAGE: javascript
CODE:
```
import Alpine from 'alpinejs'
import collapse from '@alpinejs/collapse'

Alpine.plugin(collapse)

...
```

----------------------------------------

TITLE: Install Resize Plugin via NPM
DESCRIPTION: Install the Resize plugin using NPM and import it into your JavaScript bundle. You then need to register the plugin with Alpine.js before using its directives.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/resize.md#_snippet_1

LANGUAGE: shell
CODE:
```
npm install @alpinejs/resize
```

LANGUAGE: javascript
CODE:
```
import Alpine from 'alpinejs'
import resize from '@alpinejs/resize'

Alpine.plugin(resize)

Alpine.start()
```

----------------------------------------

TITLE: Alpine.js Counter Component
DESCRIPTION: Demonstrates a basic interactive counter using Alpine.js. It utilizes `x-data` for state management and `x-on:click` to increment a counter value displayed with `x-text`.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/start-here.md#_snippet_1

LANGUAGE: html
CODE:
```
<div x-data="{ count: 0 }">
    <button x-on:click="count++">Increment</button>

    <span x-text="count"></span>
</div>
```

----------------------------------------

TITLE: Alpine.js Dropdown Component
DESCRIPTION: Demonstrates building a simple dropdown using Alpine.js directives. It utilizes x-data for state management, @click for toggling visibility, and @click.outside for closing the dropdown when clicking elsewhere.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/start-here.md#_snippet_5

LANGUAGE: alpine
CODE:
```
<div x-data="{ open: false }">
    <button @click="open = ! open">Toggle</button>

    <div x-show="open" @click.outside="open = false">Contents...</div>
</div>
```

----------------------------------------

TITLE: Basic CSP Build Example with CSP Header
DESCRIPTION: A complete HTML file demonstrating the Alpine.js CSP build with a basic counter component. It includes the necessary CSP meta tag and script nonce for security.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/advanced/csp.md#_snippet_3

LANGUAGE: html
CODE:
```
<html>
    <head>
        <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'nonce-a23gbfz9e'">

        <script defer nonce="a23gbfz9e" src="https://cdn.jsdelivr.net/npm/@alpinejs/csp@3.x.x/dist/cdn.min.js"></script>
    </head>

    <body>
        <div x-data="counter">
            <button x-on:click="increment"></button>

            <span x-text="count"></span>
        </div>

        <script nonce="a23gbfz9e">
            document.addEventListener('alpine:init', () => {
                Alpine.data('counter', () => {
                    return {
                        count: 1,

                        increment() {
                            this.count++;
                        },
                    }
                })
            })
        </script>
    </body>
</html>
```

----------------------------------------

TITLE: Importing and Initializing Alpine.js as a Module
DESCRIPTION: This JavaScript snippet demonstrates how to import Alpine.js into a module bundle and initialize it. It imports the `Alpine` object, optionally exposes it globally for debugging, and then calls `Alpine.start()` to activate Alpine.js on the page. Ensure `Alpine.start()` is called only once per page.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/essentials/installation.md#_snippet_3

LANGUAGE: JavaScript
CODE:
```
import Alpine from 'alpinejs'

window.Alpine = Alpine

Alpine.start()
```

----------------------------------------

TITLE: Initialize Alpine Store with init()
DESCRIPTION: Provides an example of an Alpine.js store that uses an `init()` method to set its initial state based on browser preferences, ensuring the store is ready before the UI renders.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/globals/alpine-store.md#_snippet_6

LANGUAGE: html
CODE:
```
<script>
    document.addEventListener('alpine:init', () => {
        Alpine.store('darkMode', {
            init() {
                this.on = window.matchMedia('(prefers-color-scheme: dark)').matches
            },

            on: false,

            toggle() {
                this.on = ! this.on
            }
        })
    })
</script>
```

----------------------------------------

TITLE: Install Alpine.js Intersect via NPM
DESCRIPTION: Provides instructions for installing the Alpine.js Intersect plugin using NPM and initializing it within a JavaScript bundle. This method is suitable for projects using module bundlers.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/intersect.md#_snippet_1

LANGUAGE: shell
CODE:
```
npm install @alpinejs/intersect
```

LANGUAGE: javascript
CODE:
```
import Alpine from 'alpinejs'
import intersect from '@alpinejs/intersect'

Alpine.plugin(intersect)

Alpine.start()
```

----------------------------------------

TITLE: Alpine.js Looping with x-for
DESCRIPTION: Demonstrates how to loop through an array of data using the `x-for` directive in Alpine.js. The directive is applied to a `<template>` element, and each iteration renders an `<li>` element displaying the current item.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/start-here.md#_snippet_11

LANGUAGE: alpine
CODE:
```
<ul>
    <template x-for="item in filteredItems">
        <li x-text="item"></li>
    </template>
</ul>
```

----------------------------------------

TITLE: Install Resize Plugin via CDN
DESCRIPTION: Include the Resize plugin from a CDN by adding a `<script>` tag before Alpine's core JS file. This makes the plugin's functionality available globally.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/resize.md#_snippet_0

LANGUAGE: html
CODE:
```
<!-- Alpine Plugins -->
<script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/resize@3.x.x/dist/cdn.min.js"></script>

<!-- Alpine Core -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
```

----------------------------------------

TITLE: Install Alpine Anchor via NPM
DESCRIPTION: Installs the Alpine.js Anchor plugin package using npm. This is the recommended method for use within modern JavaScript build processes.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/anchor.md#_snippet_1

LANGUAGE: shell
CODE:
```
npm install @alpinejs/anchor
```

----------------------------------------

TITLE: Install Collapse Plugin via CDN
DESCRIPTION: Include the Collapse plugin from a CDN before Alpine's core JS file to enable collapse/expand functionality.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/collapse.md#_snippet_0

LANGUAGE: html
CODE:
```
<script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/collapse@3.x.x/dist/cdn.min.js"></script>

<!-- Alpine Core -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
```

----------------------------------------

TITLE: Alpine Data init() Method
DESCRIPTION: Alpine automatically calls any `init()` methods stored on a data object before the element using this data initializes. This is useful for setup logic.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/essentials/lifecycle.md#_snippet_1

LANGUAGE: js
CODE:
```
Alpine.data('dropdown', () => ({
    init() {
        // I get called before the element using this data initializes.
    }
}))

```

----------------------------------------

TITLE: Live Demo Example of x-text in Alpine.js
DESCRIPTION: This snippet provides a complete HTML structure for a live demonstration of the `x-text` directive. It mirrors the basic example, showcasing how `x-text` dynamically updates the `<strong>` tag's content with the `username` data property within an Alpine.js component, typically used for interactive previews.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/directives/text.md#_snippet_1

LANGUAGE: HTML
CODE:
```
<div class="demo">
    <div x-data="{ username: 'calebporzio' }">
        Username: <strong x-text="username"></strong>
    </div>
</div>
```

----------------------------------------

TITLE: Interactive Demo of $refs and x-ref within x-data (Alpine.js)
DESCRIPTION: This example showcases the `x-ref` and `$refs` functionality within a typical Alpine.js setup, including the necessary `x-data` directive on a parent element. It illustrates a button triggering the removal of a referenced `div` element, highlighting the practical application of direct DOM access and the dependency on `x-data`.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/directives/ref.md#_snippet_1

LANGUAGE: html
CODE:
```
<div x-data>
        <button @click="$refs.text.remove()">Remove Text</button>

        <div class="pt-4" x-ref="text">Hello 👋</div>
    </div>
```

----------------------------------------

TITLE: Install Alpine Anchor via CDN
DESCRIPTION: Shows how to include the Alpine.js Anchor plugin using CDN links. Ensure the plugin script is loaded before the Alpine core script for proper initialization.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/anchor.md#_snippet_0

LANGUAGE: alpine
CODE:
```
<!-- Alpine Plugins -->
<script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/anchor@3.x.x/dist/cdn.min.js"></script>

<!-- Alpine Core -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
```

----------------------------------------

TITLE: Initialize Alpine Component with x-data
DESCRIPTION: Defines an HTML chunk as an Alpine component and provides reactive data. This is the fundamental way to start an Alpine.js component.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/directives/data.md#_snippet_0

LANGUAGE: alpine
CODE:
```
<div x-data="{ open: false }">
    <button @click="open = ! open">Toggle Content</button>

    <div x-show="open">
        Content...
    </div>
</div>
```

----------------------------------------

TITLE: Simple Custom Directive Example (`x-uppercase`)
DESCRIPTION: Provides a basic example of creating a custom directive named `x-uppercase` that converts the element's text content to uppercase. It demonstrates the core usage of `Alpine.directive()`.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/advanced/extending.md#_snippet_3

LANGUAGE: js
CODE:
```
Alpine.directive('uppercase', el => {
    el.textContent = el.textContent.toUpperCase()
})
```

LANGUAGE: alpine
CODE:
```
<div x-data>
    <span x-uppercase>Hello World!</span>
</div>
```

----------------------------------------

TITLE: Install Alpine.js Focus Plugin via NPM
DESCRIPTION: Install the Focus plugin using NPM for use within your JavaScript bundle. This is the recommended approach for modern JavaScript development workflows.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/focus.md#_snippet_1

LANGUAGE: shell
CODE:
```
npm install @alpinejs/focus
```

----------------------------------------

TITLE: Install Alpine CSP Build via NPM
DESCRIPTION: Installs the Alpine.js CSP build using NPM for use within a JavaScript bundle. This is the recommended approach for projects managed with a build system.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/advanced/csp.md#_snippet_1

LANGUAGE: shell
CODE:
```
npm install @alpinejs/csp
```

----------------------------------------

TITLE: Alpine.js x-data Directive
DESCRIPTION: Illustrates the `x-data` directive, which is fundamental for declaring reactive state within an Alpine.js component. It initializes a JavaScript object that Alpine.js will track.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/start-here.md#_snippet_2

LANGUAGE: html
CODE:
```
<div x-data="{ count: 0 }">
```

----------------------------------------

TITLE: Install Alpine Persist Plugin via NPM
DESCRIPTION: Install the Alpine Persist plugin into your project using npm. This allows you to import and use the plugin within your JavaScript build process.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/persist.md#_snippet_1

LANGUAGE: shell
CODE:
```
npm install @alpinejs/persist
```

----------------------------------------

TITLE: Testing Commands
DESCRIPTION: Commands to execute the test suite for Alpine.js. This includes running all tests, specifically Cypress integration tests, or Jest unit tests. Options can be passed to Jest using '--'.

SOURCE: https://github.com/alpinejs/alpine/blob/main/README.md#_snippet_2

LANGUAGE: bash
CODE:
```
npm run test
npm run cypress
npm run jest
npm run jest -- --watch
```

----------------------------------------

TITLE: x-anchor with Positioning Modifiers
DESCRIPTION: Customizes the anchored element's position relative to the reference element using modifiers like `.bottom-start`. This example positions the dropdown below and aligned to the start of the reference button.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/anchor.md#_snippet_4

LANGUAGE: alpine
CODE:
```
<div x-data="{ open: false }">
    <button x-ref="button" @click="open = ! open">Toggle</button>

    <div x-show="open" x-anchor.bottom-start="$refs.button">
        Dropdown content
    </div>
</div>
```

LANGUAGE: alpine
CODE:
```
<div x-data="{ open: false }" class="demo overflow-hidden">
    <div class="flex justify-center">
        <button x-ref="button" @click="open = ! open">Toggle</button>
    </div>

    <div x-show="open" x-anchor.bottom-start="$refs.button" class="bg-white rounded p-4 border shadow z-10">
        Dropdown content
    </div>
</div>
```

----------------------------------------

TITLE: Install Alpine.js Sort Plugin via NPM
DESCRIPTION: Install the Sort plugin using NPM for use within your JavaScript bundle. This is the recommended approach for modern JavaScript projects.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/sort.md#_snippet_1

LANGUAGE: shell
CODE:
```
npm install @alpinejs/sort
```

LANGUAGE: javascript
CODE:
```
import Alpine from 'alpinejs'
import sort from '@alpinejs/sort'

Alpine.plugin(sort)

...
```

----------------------------------------

TITLE: DOM Mutation Observer Setup
DESCRIPTION: JavaScript code that initializes a MutationObserver to monitor changes in the DOM. It's set to observe attribute changes, child list modifications, and character data changes within the entire document body after a 1-second delay on page load.

SOURCE: https://github.com/alpinejs/alpine/blob/main/benchmarks/giant.html#_snippet_1

LANGUAGE: javascript
CODE:
```
document.addEventListener('DOMContentLoaded', () => {
  setTimeout(() => {
    console.time();
    let observer = new MutationObserver(mutations => {
      console.log(mutations);
    })
    observer.observe(document.body, {
      characterData: true,
      childList: true,
      subtree: true,
      attributes: true
    })
    // walk(document.body, el => {
    // for (let index = 0; index < el.attributes; index++) {
    // let attr = el.attributes[index]
    // }
    // })
    console.timeEnd();
  }, 1000)
})
```

----------------------------------------

TITLE: Programmatic Access to x-model Properties in Alpine.js
DESCRIPTION: This example illustrates programmatic access to `x-model` bound properties using the `_x_model` utility. It shows how to get the current value of the `username` property using `_x_model.get()` and how to set a new value using `_x_model.set()`, allowing for dynamic manipulation of `x-model` data outside of direct input interaction.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/directives/model.md#_snippet_20

LANGUAGE: Alpine.js
CODE:
```
<div x-data="{ username: 'calebporzio' }">
    <div x-ref="div" x-model="username"></div>

    <button @click="$refs.div._x_model.set('phantomatrix')">
        Change username to: 'phantomatrix'
    </button>

    <span x-text="$refs.div._x_model.get()"></span>
</div>
```

----------------------------------------

TITLE: Install Alpine CSP Build via CDN
DESCRIPTION: Includes the Alpine.js CSP-friendly build directly from a CDN using a script tag. This is a quick way to integrate the build into an HTML document.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/advanced/csp.md#_snippet_0

LANGUAGE: html
CODE:
```
<script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/csp@3.x.x/dist/cdn.min.js"></script>
```

----------------------------------------

TITLE: Install Mask Plugin via NPM (Shell)
DESCRIPTION: Install the Mask plugin from NPM for use within your JavaScript bundle. This is the preferred method for project integration.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/mask.md#_snippet_1

LANGUAGE: shell
CODE:
```
npm install @alpinejs/mask
```

----------------------------------------

TITLE: Alpine.js Morph NPM Installation
DESCRIPTION: Command to install the Alpine.js Morph plugin via NPM for use in JavaScript projects. This allows for module bundling and integration into modern build workflows.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/morph.md#_snippet_2

LANGUAGE: shell
CODE:
```
npm install @alpinejs/morph
```

----------------------------------------

TITLE: Alpine Reactivity Counter Example (HTML/JS)
DESCRIPTION: Demonstrates a simple counter component using Alpine.js's core reactivity functions. It pairs `Alpine.reactive()` for state management with `Alpine.effect()` to update the UI, and an event listener for incrementing the count.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/advanced/reactivity.md#_snippet_2

LANGUAGE: html
CODE:
```
<button>Increment</button>

Count: <span></span>
```

LANGUAGE: js
CODE:
```
let button = document.querySelector('button')
let span = document.querySelector('span')

let data = Alpine.reactive({ count: 1 })

Alpine.effect(() => {
    span.textContent = data.count
})

button.addEventListener('click', () => {
    data.count = data.count + 1
})
```

----------------------------------------

TITLE: Initialize Alpine Anchor with NPM
DESCRIPTION: Demonstrates how to import and register the Anchor plugin with Alpine.js when installed via NPM. This makes the plugin's directives available in your application.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/anchor.md#_snippet_2

LANGUAGE: javascript
CODE:
```
import Alpine from 'alpinejs'
import anchor from '@alpinejs/anchor'

Alpine.plugin(anchor)

...
```

----------------------------------------

TITLE: Live Example of Custom SortableJS Configuration in Alpine.js HTML
DESCRIPTION: This Alpine.js HTML snippet provides a runnable example of `x-sort` with custom SortableJS configuration. The `x-sort:config="{ animation: 0 }"` directive disables sorting animation, while `x-data` initializes Alpine.js and `x-sort:item` defines sortable elements, styled with `cursor-pointer`.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/sort.md#_snippet_20

LANGUAGE: HTML
CODE:
```
<div x-data>
    <ul x-sort x-sort:config="{ animation: 0 }">
        <li x-sort:item class="cursor-pointer">foo</li>
        <li x-sort:item class="cursor-pointer">bar</li>
        <li x-sort:item class="cursor-pointer">baz</li>
    </ul>
</div>
```

----------------------------------------

TITLE: Install Alpine.js Focus Plugin via CDN
DESCRIPTION: Include the Focus plugin from a CDN before Alpine's core JS file. This method is suitable for quick integration or projects not using a module bundler.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/focus.md#_snippet_0

LANGUAGE: html
CODE:
```
<script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>

<!-- Alpine Core -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
```

----------------------------------------

TITLE: Alpine.morph() API Usage Example
DESCRIPTION: Demonstrates the imperative use of `Alpine.morph()` to update a DOM element with new HTML. This example highlights how Alpine component state is preserved across morph operations.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/morph.md#_snippet_4

LANGUAGE: javascript
CODE:
```
document.querySelector('button').addEventListener('click', () => {
    let el = document.querySelector('div')

    Alpine.morph(el, `
        <div x-data="{ message: 'Change me, then press the button!' }">
            <h2>See how new elements have been added</h2>

            <input type="text" x-model="message">
            <span x-text="message"></span>

            <h2>but the state of this component hasn't changed? Magical.</h2>
        </div>
    `)
})
```

----------------------------------------

TITLE: Alpine alpine:init Event Listener
DESCRIPTION: Listen for the `alpine:init` event to register custom data, directives, or magics before Alpine initializes on the page. This ensures setup code runs early.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/essentials/lifecycle.md#_snippet_4

LANGUAGE: js
CODE:
```
document.addEventListener('alpine:init', () => {
    Alpine.data(...)
})

```

----------------------------------------

TITLE: Staggered Enter/Leave Delay Transition with Alpine.js x-transition:delay
DESCRIPTION: This snippet illustrates a staggered delay where the enter transition starts after 250ms and the leave transition starts immediately, using `x-transition:enter.delay.250ms` and `x-transition:leave.delay.0ms`.

SOURCE: https://github.com/alpinejs/alpine/blob/main/tests/cypress/manual-transition-test.html#_snippet_12

LANGUAGE: HTML
CODE:
```
x-transition:enter.delay.250ms x-transition:leave.delay.0ms
```

----------------------------------------

TITLE: Make Test Stub File Publishable
DESCRIPTION: This commit makes the test stub file publishable, allowing developers to easily integrate and customize testing infrastructure within their Livewire projects. This enhances the flexibility and maintainability of test setups.

SOURCE: https://github.com/alpinejs/alpine/blob/main/benchmarks/giant.html#_snippet_3

LANGUAGE: php
CODE:
```
// Command to publish test stub file (conceptual)
// php artisan vendor:publish --tag=livewire-tests
```

----------------------------------------

TITLE: Alpine.js Interactive Morph Example
DESCRIPTION: Demonstrates the Alpine.js Morph plugin's functionality with an interactive carousel controlled by Alpine directives. This example showcases how Alpine state is maintained during DOM updates.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/morph.md#_snippet_0

LANGUAGE: alpine
CODE:
```
<div x-data="{ slide: 1 }" class="border rounded">
    <div>
        <img :src="../../.clinerules'/img/morphs/morph'+slide+'.png'">
    </div>

    <div class="flex w-full justify-between" style="padding-bottom: 1rem">
        <div class="w-1/2 px-4">
            <button @click="slide = (slide === 1) ? 13 : slide - 1" class="w-full bg-cyan-400 rounded-full text-center py-3 font-bold text-white">Previous</button>
        </div>
        <div class="w-1/2 px-4">
            <button @click="slide = (slide % 13) + 1" class="w-full bg-cyan-400 rounded-full text-center py-3 font-bold text-white">Next</button>
        </div>
    </div>
</div>
```

----------------------------------------

TITLE: Initialize Alpine.js Focus Plugin from Bundle
DESCRIPTION: Import and register the Focus plugin with Alpine.js after installing it via NPM. This makes the plugin's directives available in your application.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/focus.md#_snippet_2

LANGUAGE: js
CODE:
```
import Alpine from 'alpinejs'
import focus from '@alpinejs/focus'

Alpine.plugin(focus)

// ... rest of your Alpine.js initialization
```

----------------------------------------

TITLE: Monorepo Build Command
DESCRIPTION: The primary command used to build all packages within the Alpine.js monorepo. This command orchestrates the build process for each individual package.

SOURCE: https://github.com/alpinejs/alpine/blob/main/README.md#_snippet_1

LANGUAGE: bash
CODE:
```
npm run build
```

----------------------------------------

TITLE: Install Alpine.js Intersect via CDN
DESCRIPTION: Demonstrates how to include the Alpine.js Intersect plugin using a CDN script tag. It's crucial to load the plugin script before the core Alpine.js file for proper initialization.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/intersect.md#_snippet_0

LANGUAGE: html
CODE:
```
<!-- Alpine Plugins -->
<script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/intersect@3.x.x/dist/cdn.min.js"></script>

<!-- Alpine Core -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
```

----------------------------------------

TITLE: Dispatching Between Alpine.js Components
DESCRIPTION: Provides an example of how to use `$dispatch` with the `.window` modifier to enable communication between independent Alpine.js components, updating shared state.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/magics/dispatch.md#_snippet_3

LANGUAGE: alpine
CODE:
```
<div
    x-data="{ title: 'Hello' }"
    @set-title.window="title = $event.detail"
>
    <h1 x-text="title"></h1>
</div>

<div x-data>
    <button @click="$dispatch('set-title', 'Hello World!')">Click me</button>
</div>
```

----------------------------------------

TITLE: Alpine.js x-show Directive
DESCRIPTION: Explains the usage of the x-show directive in Alpine.js. It controls the visibility of an HTML element based on a JavaScript expression, typically a boolean value managed by x-data.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/start-here.md#_snippet_7

LANGUAGE: alpine
CODE:
```
<div x-show="open" ...>Contents...</div>
```

----------------------------------------

TITLE: Live Example of x-sort Hover Bug in Alpine.js HTML
DESCRIPTION: This Alpine.js HTML snippet provides a runnable example demonstrating the CSS hover bug. It uses `x-data` for Alpine.js initialization, `x-sort` for the sortable list, and `x-sort:item` for individual sortable list items, styled with Tailwind CSS classes like `hover:border` and `cursor-pointer`.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/sort.md#_snippet_16

LANGUAGE: HTML
CODE:
```
<div x-data>
    <ul x-sort class="flex flex-col items-start">
        <li x-sort:item class="hover:border border-black cursor-pointer">foo</li>
        <li x-sort:item class="hover:border border-black cursor-pointer">bar</li>
        <li x-sort:item class="hover:border border-black cursor-pointer">baz</li>
    </ul>
</div>
```

----------------------------------------

TITLE: Alpine.js x-text Directive
DESCRIPTION: Explains the `x-text` directive, used to update the text content of an HTML element based on a JavaScript expression. It dynamically reflects changes in component state.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/start-here.md#_snippet_4

LANGUAGE: html
CODE:
```
<span x-text="count"></span>
```

----------------------------------------

TITLE: Alpine.js: Prefer Alpine.data() for Data Providers
DESCRIPTION: It is now preferred to use `Alpine.data()` for defining global data providers instead of global JavaScript functions. This approach enhances organization and avoids potential naming conflicts. The example demonstrates registering a component with `Alpine.data()` before `Alpine.start()`.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/upgrade-guide.md#_snippet_12

LANGUAGE: alpine
CODE:
```
<!-- 🚫 Before -->
<div x-data="dropdown()">
    ...
</div>

<script>
    function dropdown() {
        return {
            ...
        }
    }
</script>

<!-- ✅ After -->
<div x-data="dropdown">
    ...
</div>

<script>
    document.addEventListener('alpine:init', () => {
        Alpine.data('dropdown', () => ({
            ...
        }))
    })
</script>
```

----------------------------------------

TITLE: Basic Focus Navigation with $focus
DESCRIPTION: Demonstrates basic left and right arrow key navigation between focusable elements using the $focus.next() and $focus.previous() methods. This example shows how to control focus flow within a group of buttons.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/focus.md#_snippet_11

LANGUAGE: alpine
CODE:
```
<div
    x-data
    @keydown.right="$focus.next()"
    @keydown.left="$focus.previous()"
>
    <button>First</button>
    <button>Second</button>
    <button>Third</button>
</div>
```

----------------------------------------

TITLE: Implement Custom Cookie Storage for Alpine.js $persist
DESCRIPTION: Provides an example of creating a custom storage object with `getItem` and `setItem` functions to use with Alpine.js's `$persist().using()` modifier. This example demonstrates persisting data using browser cookies.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/persist.md#_snippet_7

LANGUAGE: javascript
CODE:
```
window.cookieStorage = {
    getItem(key) {
        let cookies = document.cookie.split(";");
        for (let i = 0; i < cookies.length; i++) {
            let cookie = cookies[i].split("=");
            if (key == cookie[0].trim()) {
                return decodeURIComponent(cookie[1]);
            }
        }
        return null;
    },
    setItem(key, value) {
        document.cookie = key+' = '+encodeURIComponent(value)
    }
}

// Usage in Alpine.js:
// <div x-data="{ count: $persist(0).using(cookieStorage) }">...</div>
```

----------------------------------------

TITLE: Measure Alpine Initialization Time
DESCRIPTION: This snippet measures the time elapsed from the start of the window to the Alpine.js initialization event. It logs the duration to the console, providing insight into the framework's startup performance.

SOURCE: https://github.com/alpinejs/alpine/blob/main/benchmarks/init.html#_snippet_0

LANGUAGE: javascript
CODE:
```
window.start = performance.now();
document.addEventListener('alpine:initialized', () => {
  setTimeout(() => {
    console.log(performance.now() - window.start);
  });
});
```

----------------------------------------

TITLE: Use '$clipboard' Magic Function in Template
DESCRIPTION: Provides an example of calling the custom '$clipboard' magic function from an Alpine.js template, passing a string argument to be copied.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/advanced/extending.md#_snippet_13

LANGUAGE: alpine
CODE:
```
<button @click="$clipboard('hello world')">Copy "Hello World"</button>
```

----------------------------------------

TITLE: Alpine.js Morph NPM Initialization
DESCRIPTION: JavaScript code to import and initialize the Alpine.js Morph plugin after installing it via NPM. This makes the `Alpine.morph()` function available globally.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/morph.md#_snippet_3

LANGUAGE: javascript
CODE:
```
import Alpine from 'alpinejs'
import morph from '@alpinejs/morph'

window.Alpine = Alpine
Alpine.plugin(morph)

...
```

----------------------------------------

TITLE: Write Welcome Message (PHP)
DESCRIPTION: This function handles displaying a welcome message to the user. It includes conditional logic to open a URL on Linux systems and provides different messages based on user interaction or environment.

SOURCE: https://github.com/alpinejs/alpine/blob/main/benchmarks/giant.html#_snippet_26

LANGUAGE: php
CODE:
```
public function writeWelcomeMessage()
{
    if(PHP_OS_FAMILY == 'Linux') exec('xdg-open https://github.com/livewire/livewire');
    $this->line("Thanks! Means the world to me!");
} else {
    $this->line("I understand, but am not going to pretend I'm not sad about it...");
}
```

----------------------------------------

TITLE: Alpine.js x-effect Usage
DESCRIPTION: This example demonstrates the `x-effect` directive in Alpine.js. It logs a reactive property to the console and shows how changes to that property trigger the effect to re-run.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/directives/effect.md#_snippet_0

LANGUAGE: alpine
CODE:
```
<div x-data="{ label: 'Hello' }" x-effect="console.log(label)">
    <button @click="label += ' World!'">Change Message</button>
</div>
```

----------------------------------------

TITLE: Install Alpine.js Sort Plugin via CDN
DESCRIPTION: Include the Sort plugin from a CDN before Alpine's core JS file. This method is suitable for quick integration or projects not using a build system.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/sort.md#_snippet_0

LANGUAGE: html
CODE:
```
<script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/sort@3.x.x/dist/cdn.min.js"></script>

<!-- Alpine Core -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
```

----------------------------------------

TITLE: Chained Keyboard Event Modifiers
DESCRIPTION: Illustrates chaining multiple key modifiers to create more specific event listeners. This example triggers an action only when both 'Shift' and 'Enter' keys are pressed.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/directives/on.md#_snippet_5

LANGUAGE: alpine
CODE:
```
<input type="text" @keyup.shift.enter="alert('Submitted!')">
```

----------------------------------------

TITLE: Looping Elements with x-for Directive in Alpine.js (Alpine.js)
DESCRIPTION: This Alpine.js template snippet demonstrates the `x-for` directive used for iterating over a collection of data. The `x-for` directive must be placed on a `<template>` element and follows the `[item] in [items]` syntax. It dynamically renders `<li>` elements for each `item` in `filteredItems`, with `x-text` binding the item's value to the list item's content.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/start-here.md#_snippet_12

LANGUAGE: Alpine.js
CODE:
```
<ul>
    <template x-for="item in filteredItems">
        <li x-text="item"></li>
    </template>
</ul>
```

----------------------------------------

TITLE: Alpine.js x-model Directive
DESCRIPTION: Demonstrates the x-model directive for two-way data binding in Alpine.js. It synchronizes the value of an input element (like text fields, checkboxes, or selects) with a data property defined in x-data.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/start-here.md#_snippet_9

LANGUAGE: alpine
CODE:
```
<input x-model="search" placeholder="Search...">
```

----------------------------------------

TITLE: Alpine.js Application Root Definition in JavaScript
DESCRIPTION: This function defines the main Alpine.js application object, which encapsulates the reactive `data` array, the `selected` item, and all the methods for manipulating the data. It serves as the central state management for the UI, demonstrating various data operations with performance measurement.

SOURCE: https://github.com/alpinejs/alpine/blob/main/benchmarks/loop.html#_snippet_1

LANGUAGE: JavaScript
CODE:
```
function app() { return { data: [], selected: undefined, add() { let start = performance.now() this.data = this.data.concat(buildData(1000)) setTimeout(() => { console.log(performance.now() - start); }, 0) }, clear() { let start = performance.now() this.data = []; this.selected = undefined; setTimeout(() => { console.log(performance.now() - start); }, 0) }, update() { let start = performance.now() for (let i = 0; i < this.data.length; i += 10) { this.data[i].label += ' !!!'; } setTimeout(() => { console.log(performance.now() - start); }, 0) }, remove(id) { let start = performance.now() const idx = this.data.findIndex(d => d.id === id); this.data.splice(idx, 1); setTimeout(() => { console.log(performance.now() - start); }, 0) }, run() { let start = performance.now() this.data = buildData(100); this.selected = undefined; setTimeout(() => { console.log(performance.now() - start); }, 0) }, runLots() { let start = performance.now() this.data = buildData(10000); this.selected = undefined; setTimeout(() => { console.log(performance.now() - start); }, 0) }, select(id) { let start = performance.now() this.selected = id setTimeout(() => { console.log(performance.now() - start); }, 0) }, swapRows() { let start = performance.now() const d = this.data; if (d.length > 998) { const tmp = d[998]; d[998] = d[1]; d[1] = tmp; } setTimeout(() => { console.log(performance.now() - start); }, 0) } } }
```

----------------------------------------

TITLE: Component Init Function
DESCRIPTION: Explains the use of an `init()` method within an Alpine.js component defined via `Alpine.data`. This method is automatically executed by Alpine before the component is fully rendered, allowing for setup logic.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/globals/alpine-data.md#_snippet_3

LANGUAGE: javascript
CODE:
```
Alpine.data('dropdown', () => ({
    init() {
        // This code will be executed before Alpine
        // initializes the rest of the component.
    }
}))
```

----------------------------------------

TITLE: Register Component from Bundle
DESCRIPTION: Shows how to register an Alpine.js component defined in a separate JavaScript file when using a build process. It involves importing Alpine and the component, then registering it before starting Alpine.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/globals/alpine-data.md#_snippet_1

LANGUAGE: javascript
CODE:
```
import Alpine from 'alpinejs'
import dropdown from './dropdown.js'

Alpine.data('dropdown', dropdown)

Alpine.start()
```

LANGUAGE: javascript
CODE:
```
export default () => ({
    open: false,

    toggle() {
        this.open = ! this.open
    }
})
```

----------------------------------------

TITLE: Alpine: Manual Alpine.start() after import
DESCRIPTION: When importing Alpine.js as a module (e.g., via NPM), V3 requires an explicit call to `Alpine.start()` to initialize the framework. This differs from V2's automatic initialization upon import and does not affect users of the CDN or build files.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/upgrade-guide.md#_snippet_2

LANGUAGE: javascript
CODE:
```
// 🚫 Before
import 'alpinejs'

// ✅ After
import Alpine from 'alpinejs'

window.Alpine = Alpine

Alpine.start()
```

----------------------------------------

TITLE: Handle Command Logic with Test Path (PHP)
DESCRIPTION: This snippet demonstrates the `handle` method of a command, likely for generating files or components. It conditionally displays the relative path of a generated test file if the `$test` variable is true.

SOURCE: https://github.com/alpinejs/alpine/blob/main/benchmarks/giant.html#_snippet_27

LANGUAGE: php
CODE:
```
public function handle()
{
    // ... other logic ...
    if ($test) {
        $test && $this->line("<options=bold;fg=green>TEST:</> {$this->parser->relativeTestPath()}");
    }
    if ($showWelcomeMessage && ! app()->environment('testing')) {
        // ... other logic ...
    }
}
```

----------------------------------------

TITLE: Alpine: Auto-evaluate init() functions on data object
DESCRIPTION: Alpine.js V3 automatically calls an `init()` method defined within an `x-data` object. This eliminates the need for manual invocation, simplifying component setup and initialization patterns previously common in V2.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/upgrade-guide.md#_snippet_1

LANGUAGE: alpine
CODE:
```
<!-- 🚫 Before -->
<div x-data="foo()" x-init="init()"></div>

<!-- ✅ After -->
<div x-data="foo()"></div>

<script>
    function foo() {
        return {
            init() {
                //
            }
        }
    }
</script>
```

----------------------------------------

TITLE: Install Alpine Persist Plugin via CDN
DESCRIPTION: Include the Alpine Persist plugin from a CDN by adding a script tag before Alpine's core JavaScript file. This makes the plugin's functionality available globally.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/persist.md#_snippet_0

LANGUAGE: alpine
CODE:
```
<!-- Alpine Plugins -->
<script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/persist@3.x.x/dist/cdn.min.js"></script>

<!-- Alpine Core -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
```

----------------------------------------

TITLE: Interactive Demo Example
DESCRIPTION: A practical demonstration of `x-intersect` within a scrollable container. It shows how to toggle content visibility based on whether an element is scrolled into view, with smooth scrolling functionality.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/intersect.md#_snippet_9

LANGUAGE: html
CODE:
```
<div class="demo" style="height: 60px; overflow-y: scroll;" x-data x-ref="root">
    <a href="#" @click.prevent="$refs.root.scrollTo({ top: $refs.root.scrollHeight, behavior: 'smooth' })">Scroll Down 👇</a>
    <div style="height: 50vh"></div>
    <div x-data="{ shown: false }" x-intersect="shown = true" id="yoyo">
        <div x-show="shown" x-transition.duration.1000ms>
            I'm in the viewport!
        </div>
        <div x-show="! shown">&nbsp;</div>
    </div>
</div>
```

----------------------------------------

TITLE: Install Mask Plugin via CDN (AlpineJS)
DESCRIPTION: Include the Mask plugin from a CDN using a script tag. Ensure this script is placed before Alpine's core JS file for correct initialization.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/mask.md#_snippet_0

LANGUAGE: alpine
CODE:
```
<!-- Alpine Plugins -->
<script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/mask@3.x.x/dist/cdn.min.js"></script>

<!-- Alpine Core -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
```

----------------------------------------

TITLE: PHP Method to Call Component Method and Sync Input
DESCRIPTION: This PHP code demonstrates a method within a component concern that handles calling other methods and synchronizing input states. It includes logic for toggling boolean properties and updating component states.

SOURCE: https://github.com/alpinejs/alpine/blob/main/benchmarks/giant.html#_snippet_31

LANGUAGE: php
CODE:
```
public function callMethod($method, $params = [])
{
    $this->{$method}(...$params);
}

// ... inside another method or context ...

$currentValue = $this->{$prop};

$this->syncInput($prop, ! $currentValue, $rehash = false);
```

----------------------------------------

TITLE: Alpine.js Morph CDN Installation
DESCRIPTION: Instructions for including the Alpine.js Morph plugin using CDN links in HTML. It's crucial to include the plugin script BEFORE Alpine's core JS file for correct initialization.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/plugins/morph.md#_snippet_1

LANGUAGE: alpine
CODE:
```
<!-- Alpine Plugins -->
<script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/morph@3.x.x/dist/cdn.min.js"></script>

<!-- Alpine Core -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
```

----------------------------------------

TITLE: Declarative Counter Component with Alpine.js Syntax - HTML
DESCRIPTION: This example shows the same counter component implemented using Alpine.js's declarative syntax. It utilizes `x-data` to define the reactive state, `@click` for event handling, and `x-text` to bind the reactive data to the DOM, demonstrating Alpine's simplified approach to reactivity compared to the manual JavaScript implementation.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/advanced/reactivity.md#_snippet_5

LANGUAGE: HTML
CODE:
```
<div x-data="{ count: 1 }" class="demo">
    <button @click="count++">Increment</button>

    <div>Count: <span x-text="count"></span></div>
</div>
```

----------------------------------------

TITLE: Basic x-transition Usage
DESCRIPTION: Demonstrates the fundamental use of the `x-transition` directive on an element controlled by `x-show` for smooth fading and scaling effects.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/directives/transition.md#_snippet_0

LANGUAGE: html
CODE:
```
<div x-data="{ open: false }">
    <button @click="open = ! open">Toggle</button>

    <div x-show="open" x-transition>
        Hello 👋
    </div>
</div>
```

----------------------------------------

TITLE: Fix Publish Command for Test Files
DESCRIPTION: Addresses an issue with the publish command, ensuring it correctly handles test files. This fix improves the developer experience by making asset publishing more reliable.

SOURCE: https://github.com/alpinejs/alpine/blob/main/benchmarks/giant.html#_snippet_7

LANGUAGE: APIDOC
CODE:
```
Publish Command Fix:
  Functionality: Corrects the behavior of the publish command, specifically for test files.
  Purpose: Ensures that publishing test-related assets works as expected, enhancing build and testing workflows.
```

----------------------------------------

TITLE: Alpine.js: Use global events for deferLoadingAlpine
DESCRIPTION: Alpine.js V3 replaces the `window.deferLoadingAlpine()` function with global DOM events for controlling initialization. Use `alpine:init` to run code before Alpine initializes and `alpine:initialized` to run code after initialization.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/upgrade-guide.md#_snippet_9

LANGUAGE: javascript
CODE:
```
<!-- 🚫 Before -->
<script>
    window.deferLoadingAlpine = startAlpine => {
        // Will be executed before initializing Alpine.

        startAlpine()

        // Will be executed after initializing Alpine.
    }
</script>

<!-- ✅ After -->
<script>
    document.addEventListener('alpine:init', () => {
        // Will be executed before initializing Alpine.
    })

    document.addEventListener('alpine:initialized', () => {
        // Will be executed after initializing Alpine.
    })
</script>
```

----------------------------------------

TITLE: Alpine.js Data with Computed Property
DESCRIPTION: Defines data properties and a computed property using a JavaScript getter within an Alpine.js x-data object. The `filteredItems` getter dynamically filters the `items` array based on the `search` property, demonstrating reactivity.

SOURCE: https://github.com/alpinejs/alpine/blob/main/packages/docs/src/en/start-here.md#_snippet_10

LANGUAGE: js
CODE:
```
{
    items: ['foo', 'bar', 'baz'],

    get filteredItems() {
        return this.items.filter(
            i => i.startsWith(this.search)
        )
    }
}
```