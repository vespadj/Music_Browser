// Music_Browser - app.js (modernized with Alpine.js)
const dblQuote = '"'
var ext = '.lsp'

// For xCMenu - alpinejs contexmenu
function xCMenu_getItemsByField(field) {
  let items = []

  if (['music_track'].includes(field.toLowerCase())) {
    // TODO: fix - for Windows.
    if (false && Alpine.store('dndf') && Alpine.store('dndf').on) {
      items.push({
        name: 'dndf',
      })
    }

    items.push({
      name: 'Open Folder',
      icon: '<iconify-icon icon="mdi:folder-open-outline" width="1rem" height="1rem"></iconify-icon>',
      exec: (row) => {
        fetch('action.lsp?action=OpenFolder&url=' + encodeURIComponent(row.url))
      },
    })

    items.push({
      name: 'Play here',
      icon: '<iconify-icon icon="mdi:play-outline" width="1rem" height="1rem"></iconify-icon>',
      exec: (row, app) => {
        app.player.current = row
        app.player.current.url_media =
          '/media' + row.url.slice(app.rootNew.length)
      },
    })

    // TODO: Clementine or Other outside player, must depends by settings (and OS?).
    items.push({
      name: 'Add to Clementine',
      icon: '<iconify-icon icon="mdi:fruit-watermelon" width="1rem" height="1rem"></iconify-icon>',
      exec: (row, app) => {
        fetch(
          'action.lsp?action=AddClementine&url=' + encodeURIComponent(row.url)
        )
      },
    })

    items.push({
      name: 'Add to Mixxx AutoDJ',
      icon: '<iconify-icon icon="mdi:robot-happy-outline" width="1rem" height="1rem"></iconify-icon>',
      exec: (row) => {
        fetch(
          'action.lsp?action=AddToMixxxAutoDJ&track_id=' +
            encodeURIComponent(row.id)
        )
      },
    })

    // TODO: Optimize OS Players
    if (false) {
      items.push({
        name: 'Add to Winamp',
        icon: '<iconify-icon icon="mdi:lightning-bolt-outline" width="1rem" height="1rem"></iconify-icon>',
        exec: (row) => {
          fetch(
            'action.lsp?action=AddWinamp&url=' + encodeURIComponent(row.url)
          )
        },
      })

      items.push({
        name: 'Add to Winamp And Play',
        icon: '<iconify-icon icon="mdi:lightning-bolt-circle" width="1rem" height="1rem"></iconify-icon>',
        exec: (row) => {
          fetch(
            'action.lsp?action=AddWinampAndPlay&url=' +
              encodeURIComponent(row.url)
          )
        },
      })
    }

    items.push({
      name: 'Copy Artist - Title',
      icon: '<iconify-icon icon="mdi:content-copy" width="1rem" height="1rem"></iconify-icon>',
      exec: (row) => {
        let a = row.artist || ''
        let t = row.title || ''
        let j = a ? ' - ' : ''
        j = t ? j : ''
        Copy(a + j + t)
      },
    })

    items.push({
      name: 'Copy File Path (server)',
      icon: '<iconify-icon icon="mdi:content-copy" width="1rem" height="1rem"></iconify-icon>',
      exec: (row) => {
        Copy(row.url)
      },
    })
  }
  return items
}

function seconds2time(sec) {
  sec = Number(sec) || 0
  let minutes = Math.floor(sec / 60)
  let seconds = Math.floor(sec % 60)
  return minutes + ':' + String(seconds).padStart(2, '0')
}

document.addEventListener('alpine:init', () => {
  // https://alpinejs.dev/plugins/persist#using-persist-with-alpine-data
  // If you want to use $persist with Alpine.data, you need to use a standard function instead of an arrow function
  Alpine.store('dndf', {
    on: Alpine.$persist(false).as('dndf_on'),
  })
  Alpine.store('theme', {
    current: Alpine.$persist('light').as('theme_current'),
    options: daisyuiThemes,
  })

  Alpine.data('musicBrowser', function () {
    return {
      options: {
        dbs: [
          { name: 'mixxx', path: '~/.mixxx/mixxxdb.sqlite' },
          { name: 'internal', path: '' },
        ],
        db_selected: 0,
        debug_sql_on: this.$persist(true),
        print_btn_on: this.$persist(true),
      },
      inputtimeout_ms: 750,
      inputTimeOut: null,
      presetQuery: '',
      presetQueries: [],
      rootOld: '', // see init()
      rootNew: this.$persist(this.rootOld || '').as('rootNew'),
      showOptionsBox: false,
      dbg: '',
      printBox_html: '',
      results: [],
      results_fields: [],
      defaultFields: [
        'artist',
        'title',
        'year',

        'isExists',
        'url',

        'duration',
        'kbps',
        'KB',

        'album',
        'id',
        'genre',
        'n',

        'comment',
        'filedate',
      ],
      searchForm: {
        q: '',
        qNot: '',
        qExact: false,
        qPreset: {
          options: [],
          selected: '',
        },
        qList: '',
      },
      dbTracksCount: 0,
      showDebugSql: false,
      showList: true,
      warn_dbJuceUpdatable: false,
      statusMessage: '',

      player: {
        current: {},
      },

      init() {
        this.loadDefaultData()
        this.$nextTick(() => {
          this.$refs.searchForm_q.focus()
        })
      },
      loadDefaultData() {
        // Simulate loading default data from AJAX response
        // Replace this with your actual AJAX call
        fetch('Music_Browser' + ext + '?rs=init')
          .then((x) => x.json())
          .then((response) => {
            this.searchForm.qPreset = response.init.qPreset
            this.dbTracksCount = response.count.tab[0].count
            if (this.dbTracksCount === 0) {
              this.showOptionsBox = true
              alert('Your database is empty.\nTODO!!!')
              this.openSettings()
            }
            this.rootOld = response.media_directory.tab[0].directory
            this.rootNew = this.rootNew || this.rootOld || ''
          })
      },
      openSettings() {
        // TODO:
        // Simulate opening Music_Browser settings
        // Replace this with your actual implementation
        // fetch('/lua/lib/action.lp?action=OpenMusicBrowserSettings');
      },
      performSearch() {
        const f = this.searchForm
        const options = this.options
        // alert(`{"q":"${f.q}","qNot":"${f.qNot}","qExact":"${f.qExact}","qPreset":"${f.qPreset.selected}"}`);
        let uri_qList = encodeURI(f.qList)
        fetch(
          'Music_Browser' +
            ext +
            '?rs=searchJSON' +
            `&db=${options.dbs[options.db_selected].name}&q=${f.q}&qNot=${
              f.qNot
            }&qExact=${f.qExact}&qPreset=${
              f.qPreset.selected
            }&qList=${uri_qList}`,
          {
            method: 'GET',
            //body: `{"q":"${f.q}","qNot":"${f.qNot}","qExact":"${f.qExact}","qPreset":"${f.qPreset.selected}"}`,
          }
        )
          .then((response) => {
            if (!response.ok) {
              throw new Error('AJAX request error')
              // TODO: Add error details in the thrown error message for better debugging
            }
            return response.json()
          })
          .then((data) => {
            this.dbg = data.dbg

            if (!data.results && !data.results.thead) {
              console.log('Malformed data.results.thead:', data.results.thead)
              return
            }

            // Update results table and related elements
            this.results_fields = data.results.thead
            if (data.results.tab.length) {
              data.results.tab.forEach((row) => {
                if (row.url) {
                  row.url = this.formatUrl(row.url)
                }
                row.filedate = this.formatDate(row.filedate)
              })
            }
            this.results = data.results.tab
          })
          .catch((error) => {
            // Handle potential errors
            // TODO: Add proper error handling and user feedback mechanism
            console.error(error)
          })
      },
      formatDate(date) {
        // Humanization function remains the same
        // TODO: Add date validation - current implementation may throw on invalid date strings
        const parsedDate = new Date(date)
        const dd = String(parsedDate.getDate()).padStart(2, '0')
        const mm = String(parsedDate.getMonth() + 1).padStart(2, '0') // 0-based
        const yyyy = String(parsedDate.getFullYear()).padStart(2, '0')
        const hh = String(parsedDate.getHours()).padStart(2, '0')
        const min = String(parsedDate.getMinutes()).padStart(2, '0')
        const ss = String(parsedDate.getSeconds()).padStart(2, '0')

        return `${yyyy}/${mm}/${dd} ${hh}:${min}` // :${ss}
      },
      formatUrl(urltxt) {
        // TODO: Add validation for this.rootOld and this.rootNew before string replacement
        let url = urltxt.replace(this.rootOld, this.rootNew)
        let txt = urltxt.replace(this.rootOld, this.rootNew)
        if (this.rootNew[0] === '/') {
          // Linux path
          txt = txt.replaceAll('\\', '/')
        }
        return txt
      },
      toggleDebugSql() {
        this.showDebugSql = !this.showDebugSql
      },
      printURLs() {
        let text = ''
        this.results.forEach((result) => {
          text += result.url + '<br>'
        })
        this.printBox_html = text
        this.$nextTick(() => {
          this.$refs.printBox.scrollIntoView()
        })
      },
      printArtistTitle() {
        let text = ''
        this.results.forEach((result) => {
          text += `${result.artist} - ${result.title}<br>`
        })
        this.printBox_html = text
        this.$refs.printBox.scrollIntoView()
      },
      filterResults() {
        // Filter the search results
        // Replace this with your actual implementation for filtering
        // For example, using JavaScript array filter method.
      },
    }
  })
})

// Perform the initial setup when the document is ready
// document.addEventListener("DOMContentLoaded", () => {
//   Alpine.init();
// });
