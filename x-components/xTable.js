document.addEventListener('alpine:init', () => {
  Alpine.data('xTable', (config = {}) => {
    const {
      table = [],
      hiddenFields = [],
      defaultFields = [],
      clickOnRow = '',  // default action for click on row (xCMenu)
    } = config

    return {
      clickOnRow,
      html: '',
      table,
      hiddenFields,
      fields: [],
      defaultFields,
      suffixFields: [], // fields less defaultFields
      visibleSet: new Set(),

      init() {
        fetch('x-components/xTable.html')
          .then((x) => x.text())
          .then((html) => {
            this.html = html
          })

        this.fields = this.results_fields || []
        this.suffixFields = this.fields.filter(
          (el) => !this.defaultFields.includes(el)
        )

        this.$watch('results', (new_val) => {
          if (new_val.length) {
            this.table = new_val
            this.fields = this.results_fields || []
            // visible columns
            this.fields.forEach((f) => {
              if (!this.hiddenFields.includes(f)) this.visibleSet.add(f)
            })
          } else {
            this.table = []
          }
        })
      },

      toggleField(field) {
        if (this.visibleSet.has(field)) this.visibleSet.delete(field)
        else this.visibleSet.add(field)
      },

      get visibleFields() {
        // restituisco la lista ordinata delle colonne da mostrare
        return this.fields.filter((f) => this.visibleSet.has(f))
      },
    }
  })
})
