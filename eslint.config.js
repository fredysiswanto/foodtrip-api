const js = require('@eslint/js')
const eslintConfigPrettier = require('eslint-config-prettier')

module.exports = [
  // Apply to all JavaScript files
  {
    files: ['**/*.js'],
    languageOptions: {
      ecmaVersion: 2021,
      sourceType: 'module',
      globals: {
        // Node.js globals
        global: 'readonly',
        process: 'readonly',
        Buffer: 'readonly',
        __dirname: 'readonly',
        __filename: 'readonly',
        console: 'readonly',
        module: 'readonly',
        require: 'readonly',
        exports: 'readonly',
        setTimeout: 'readonly',
        clearTimeout: 'readonly',
        setInterval: 'readonly',
        clearInterval: 'readonly',
        setImmediate: 'readonly',
        clearImmediate: 'readonly',
        // Modern globals available in Node.js 18+
        fetch: 'readonly',
        URLSearchParams: 'readonly',
        URL: 'readonly',
        AbortController: 'readonly',
        FormData: 'readonly'
      }
    },
    plugins: {
      import: require('eslint-plugin-import'),
      n: require('eslint-plugin-n'),
      promise: require('eslint-plugin-promise')
    },
    rules: {
      // Base recommended rules
      ...js.configs.recommended.rules,

      // Import plugin rules
      'import/no-unresolved': 'error',
      'import/named': 'error',
      'import/namespace': 'error',
      'import/default': 'error',
      'import/export': 'error',

      // Node plugin rules
      'n/no-missing-import': 'error',
      'n/no-missing-require': 'error',
      'n/no-deprecated-api': 'error',
      'n/no-path-concat': 'error',
      'n/handle-callback-err': 'error',

      // Promise plugin rules
      'promise/catch-or-return': 'error',
      'promise/no-return-wrap': 'error',
      'promise/param-names': 'error',
      'promise/always-return': 'error',
      'promise/no-nesting': 'warn',

      // Relaxed rules for development
      'no-console': 'warn',
      'no-unused-vars': 'warn',
      'no-undef': 'error',
      'prefer-const': 'error',
      'no-var': 'error',
      'object-shorthand': 'error',
      'prefer-arrow-callback': 'error',
      'prefer-template': 'error',
      'template-curly-spacing': 'error',
      'arrow-spacing': 'error',
      'comma-dangle': ['error', 'never'],
      quotes: ['error', 'single'],
      semi: ['error', 'never'],
      indent: ['error', 2],
      'no-trailing-spaces': 'error',
      'no-multiple-empty-lines': ['error', { max: 2 }],
      'keyword-spacing': 'error',
      'space-infix-ops': 'error',
      'eol-last': 'error',

      // Specific rules for this project
      'no-tabs': 'error',
      camelcase: ['off', { allow: ['snake_case_pattern'] }],
      eqeqeq: 'error',
      'no-mixed-spaces-and-tabs': 'error',
      'no-unused-expressions': 'error',
      'valid-typeof': 'error'
    }
  },

  // Prettier configuration to disable conflicting rules
  eslintConfigPrettier,

  // Ignore patterns
  {
    ignores: [
      'node_modules/**',
      'dist/**',
      'build/**',
      'public/**',
      'db/**',
      '**/*.min.js',
      'src/database/migrations/**',
      'src/database/seeders/**',
      'src/helpers/ollamaHelper.js'
    ]
  }
]
