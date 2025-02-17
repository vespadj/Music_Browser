// prettier.config.js, .prettierrc.js, prettier.config.cjs, or .prettierrc.cjs

/**
 * @see https://prettier.io/docs/configuration
 * @type {import("prettier").Config}
 */
const config = {
  trailingComma: "es5",
  tabWidth: 2,
  semi: false,
  singleQuote: true,
  "plugins": ["prettier-plugin-tailwindcss"]
  // https://github.npmcom/tailwindlabs/prettier-plugin-tailwindcss
};
module.exports = config;
