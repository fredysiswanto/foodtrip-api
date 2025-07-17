module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true
  },
  extends: ['standard', 'prettier'],
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module'
  },
  rules: {
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
    // 'space-before-function-paren': ['error', 'always'],
    'keyword-spacing': 'error',
    'space-infix-ops': 'error',
    'eol-last': 'error',

    // Specific rules for this project
    'no-tabs': 'error',
    camelcase: 'warn',
    eqeqeq: 'error',
    'no-mixed-spaces-and-tabs': 'error',
    'n/no-path-concat': 'error',
    'no-unused-expressions': 'error',
    'n/handle-callback-err': 'error',
    'valid-typeof': 'error'
  },
  ignorePatterns: [
    'node_modules/',
    'dist/',
    'build/',
    'public/',
    'db/',
    '*.min.js',
    'src/database/migrations/',
    'src/database/seeders/'
  ]
}
