let mix = require('laravel-mix')

mix.webpackConfig({
  resolve: {
    alias: {
      'prismjs/components/prism-core': 'prismjs/components/prism-core.js',
      'prismjs/components/prism-sql': 'prismjs/components/prism-sql.js',
      'prismjs/plugins/line-numbers/prism-line-numbers': 'prismjs/plugins/line-numbers/prism-line-numbers.js',
    },
    extensions: ['.js', '.mjs', '.jsx', '.json'],
  },
})

mix
  .postCss('src/styles.css', 'dist/css', [require('@tailwindcss/postcss')])
  .js('src/main.js', 'dist/js')
  .setPublicPath('./')
  .version()
