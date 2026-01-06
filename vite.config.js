import { defineConfig } from 'vite'
import { join, resolve } from 'path'
import prism from 'vite-plugin-prismjs';
import tailwindcss from '@tailwindcss/vite'
import fs from 'fs'

export default defineConfig({
  // root: 'src' // does mandess
  
  build: {
    // filenameHashing: false,
    manifest: true,
    emptyOutDir: true,
    outDir: resolve(__dirname, 'dist'),
    rollupOptions: {
      input: {
        main: join(__dirname, 'src/main.js'),
        styles: join(__dirname, 'src/styles.css'),
      },
    },
  },

  server: {
    port: 3003,
    cors: true,
  },

  plugins: [
    prism({
      languages: ['sql'],
      plugins: ['line-numbers'],
      theme: 'twilight',
      css: true,
    }),
    tailwindcss(),
    {
      name: 'copy-manifest',
      closeBundle() {
        const srcManifestPath = resolve(__dirname, 'dist/.vite/manifest.json')
        const destManifestPath = resolve(__dirname, 'manifest.json')

        fs.copyFileSync(srcManifestPath, destManifestPath)
        console.log('Manifest copied to root directory!')
      },
    },
  ],
})
