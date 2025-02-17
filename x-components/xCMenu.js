// Global
document.addEventListener("alpine:init", () => {
  Alpine.data("xCMenu", () => ({
    // Properties
    xCMenu: {
      html: "", // on init fetch "/x-components/xCMenu.html"
      row: 0, // row target, from which the item was clicked
      isOpen: false,
      top: 1,
      left: 1,
      // ! functions here are valid, but not visible
      alert(msg) {
        alert(msg); // test
      },
      items: [], // Populated by xCMenu_getItemsByField(field)
    },

    // Functions

    init() {
      fetch("x-components/xCMenu.html")
        .then((x) => x.text())
        .then((html) => {
          this.xCMenu.html = html;
        });
    },

    xCMenu_open(the_event, row, field) {
      if (document.getSelection().toString().length > 1) {
        // se stai selezionando un testo, interrompi
        return;
      }

      this.xCMenu.row = row;

      // Populate items based on field
      if (field) {
        this.xCMenu.items = xCMenu_getItemsByField(field);
        // The fuction xCMenu_getItemsByField() must be defined in the application (index.js or app.js, ...)
      }

      // Calculate menu position based on window dimensions and event coordinates
      const pTop = the_event.clientY + 4;
      const pLeft = the_event.clientX + 4;
      const wH = window.innerHeight;
      const wW = window.innerWidth;
      const scrollX = window.scrollX;
      const scrollY = window.scrollY;

      this.xCMenu.isOpen = true;

      // Calculate menu dimensions

      // OLD: mH heigth and mW width, are calculated after showing
      // open and get height a Width, than change position.
      // it doesn't work, as $next tick.
      // const the_div = document.getElementById('xCMenu') ;
      // const mH = the_div.clientHeight + 4;
      // const mW = the_div.clientWidth + 4;

      // NEW: simplified
      const mH = 32 * this.xCMenu.items.length + 4; // h-8
      const mW = 180 + 4; // manual
      // TODO: need a fix

      // Adjust menu position if it exceeds window boundaries
      if (wH < pTop + mH + 12) {
        // 12= 16-4; 16 è l'altezza della barra di scorrimento, lo scorrimento non influisce sulla pos rispetto al box , quindi non serve window.pageXOffset
        this.xCMenu.top = pTop - mH + scrollY; // l'offset (se ho scorso la page) l'ho aggiunto successivamente per rendere la position: absolute;
      } else {
        this.xCMenu.top = pTop + scrollY;
      }
      if (wW < pLeft + mW + 8) {
        this.xCMenu.left = pLeft - mW + scrollX;
      } else {
        this.xCMenu.left = pLeft + scrollX;
      }
    },

    xCMenu_exec(funcName, row, modifiers) {
      // Execute the selected function and close the menu.
      // Pass 'this' for accessing app, the root data (alpine).
      const selectedItem = this.xCMenu.items.find((x) => x.name === funcName);
      if (selectedItem) {
        selectedItem.exec(row, this, modifiers);
      }
      this.xCMenu.isOpen = false;
      this.xCMenu.row = undefined;
    },
  }));
});
