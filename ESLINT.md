# ESLint Configuration for FoodTrip API

## Overview

Proyek ini menggunakan ESLint versi 8.57.0 dengan konfigurasi Standard JavaScript untuk menjaga kualitas kode dan konsistensi style.

## Instalasi

ESLint sudah terinstall sebagai dev dependency:

```bash
pnpm add -D eslint@8.57.0 eslint-config-standard eslint-plugin-import eslint-plugin-n eslint-plugin-promise
```

## Scripts yang tersedia

- `pnpm run lint` - Menjalankan ESLint pada seluruh project
- `pnpm run lint:fix` - Menjalankan ESLint dan memperbaiki error yang bisa diperbaiki otomatis
- `pnpm run lint:check` - Menjalankan ESLint tanpa menampilkan warning (hanya error)
- `pnpm run lint:watch` - Menjalankan ESLint dalam mode watch
- `pnpm run predev` - Menjalankan lint:fix sebelum development server dimulai

## Konfigurasi Rules

### Standard Rules

- **Semi-colon**: Tidak diperbolehkan (`;`)
- **Quotes**: Single quotes (`'`) wajib
- **Indentation**: 2 spaces
- **No trailing spaces**: Tidak diperbolehkan spasi di akhir baris
- **No var**: Gunakan `const` atau `let`
- **Arrow functions**: Preferred untuk callbacks

### Custom Rules untuk Project ini

- **no-tabs**: Error - Gunakan spaces, bukan tabs
- **camelcase**: Warning - Gunakan camelCase untuk variable names
- **eqeqeq**: Error - Gunakan `===` dan `!==` bukan `==` dan `!=`
- **no-console**: Warning - Console.log diperbolehkan tapi diberi warning
- **no-unused-vars**: Warning - Variable yang tidak digunakan
- **n/no-path-concat**: Error - Gunakan `path.join()` untuk path concatenation
- **n/handle-callback-err**: Error - Handle callback errors dengan benar

## Files yang di-ignore

- `node_modules/`
- `dist/` dan `build/`
- `public/`
- `db/`
- `src/database/migrations/`
- `src/database/seeders/`
- `*.min.js`

## Cara Menggunakan

### 1. Sebelum Commit

```bash
pnpm run lint:fix
```

### 2. Check Quality

```bash
pnpm run lint:check
```

### 3. Development dengan Auto-fix

```bash
pnpm run dev
```

(Script `predev` akan otomatis menjalankan `lint:fix` sebelum development server dimulai)

## Common Issues dan Solusi

### 1. Tab Characters

**Error**: `Unexpected tab character no-tabs`
**Solusi**: Ganti tab dengan 2 spaces

### 2. Semicolon

**Error**: `Extra semicolon semi`
**Solusi**: Hapus semicolon di akhir statement

### 3. Quotes

**Error**: `Strings must use singlequote`
**Solusi**: Gunakan single quotes (`'`) bukan double quotes (`"`)

### 4. Equality

**Error**: `Expected '===' and instead saw '==' eqeqeq`
**Solusi**: Gunakan `===` atau `!==` untuk comparison

### 5. Path Concatenation

**Error**: `Use path.join() or path.resolve() instead of string concatenation`
**Solusi**:

```javascript
// ❌ Salah
const filePath = __dirname + '/uploads/' + filename

// ✅ Benar
const path = require('path')
const filePath = path.join(__dirname, 'uploads', filename)
```

### 6. Undefined Variables

**Error**: `'variable' is not defined no-undef`
**Solusi**: Pastikan variable sudah di-declare atau di-import

## Integration dengan VS Code

Untuk mendapatkan experience terbaik, install extension:

- ESLint extension untuk VS Code
- Prettier extension (optional)

Set VS Code untuk format on save:

```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  }
}
```

## Status Current

Dari 17,808 error awal, sekarang tinggal ~128 problems (82 errors, 46 warnings) yang kebanyakan adalah:

- Tab characters yang perlu diganti dengan spaces
- Beberapa comparison operators yang perlu diganti
- Unused variables (warnings)
- Console statements (warnings)

## Next Steps

1. Fix remaining tab characters in model files
2. Fix comparison operators (`==` → `===`)
3. Handle undefined variables in cart controller
4. Fix path concatenation issues
5. Set up pre-commit hooks (optional)

## Maintenance

- Regularly run `pnpm run lint:fix` untuk menjaga kualitas kode
- Review warnings secara berkala
- Update ESLint configuration sesuai kebutuhan team
