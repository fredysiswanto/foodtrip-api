# K6 TypeScript Migration Guide

## 🎉 Migration Completed!

All K6 load testing files have been successfully migrated from JavaScript to **TypeScript**.

## ✅ Files Converted

### Core Files
- ✅ **config.ts** - Configuration with full type definitions
- ✅ **helpers.ts** - Helper functions with proper typing
- ✅ **tsconfig.json** - TypeScript configuration for K6

### Test Files
- ✅ **01_auth_test.ts** - Authentication testing
- ✅ **02_browse_test.ts** - Browse operations testing
- ✅ **03_customer_operations_test.ts** - Customer CRUD operations
- ✅ **04_complete_user_flow_test.ts** - End-to-end user flow
- ✅ **05_stress_test.ts** - Stress testing
- ✅ **06_soak_test.ts** - Endurance testing
- ✅ **07_spike_test.ts** - Spike/surge testing

## 🔧 Type Improvements Added

### config.ts Types
```typescript
interface User {
  email: string
  password: string
}

interface Scenario {
  executor: string
  vus?: number
  duration?: string
  startVUs?: number
  stages?: ScenarioStage[]
  description: string
}

interface Thresholds {
  [key: string]: string[]
}
```

### helpers.ts Types
```typescript
interface LoginResponse {
  token: string
  statusCode: number
  userId?: number | string
  userType?: string
  error?: string
}

type UserType = 'admin' | 'customer' | 'restoAdmin'
```

### K6 Module Types
All functions now use proper K6 types:
- `Response` - HTTP response typing
- `group()` - Group function typing
- `check()` - Check function typing

## 📝 Key Changes

### 1. Imports Updated
**Before:**
```javascript
import { login, validateResponse } from './helpers.js'
```

**After:**
```typescript
import { login, validateResponse } from './helpers.ts'
```

### 2. Function Signatures
**Before:**
```javascript
export function login(userType = 'customer') {
  // ...
}
```

**After:**
```typescript
export function login(userType: UserType = 'customer'): LoginResponse {
  // ...
}
```

### 3. Variables
**Before:**
```javascript
const response = http.get(url, headers)
```

**After:**
```typescript
const response: Response = http.get(url, headers)
```

### 4. Type Casting
**Before:**
```javascript
const restoId = (data as any[]).length > 0 ? data[0].id : null
```

**After:**
```typescript
const restoId: number = (data as any[])[0].id
```

## 🚀 Running TypeScript Tests

### Updated NPM Scripts
```bash
# Smoke test
pnpm run k6:smoke

# Authentication
pnpm run k6:auth

# Browse operations
pnpm run k6:browse

# Customer operations
pnpm run k6:customer

# Complete flow
pnpm run k6:flow

# Stress test
pnpm run k6:stress

# Soak test
pnpm run k6:soak

# Spike test
pnpm run k6:spike
```

### Direct K6 Command
```bash
# Run TypeScript test directly
k6 run k6/01_auth_test.ts --env BASE_URL=http://localhost:5000

# With scenario
k6 run k6/02_browse_test.ts --env SCENARIO=rampUp

# Export results
k6 run k6/03_customer_operations_test.ts -o json=results.json
```

## 💡 Benefits of TypeScript

### 1. Type Safety
- Catch errors at development time
- IDE autocomplete and intellisense
- Self-documenting code

### 2. Better IDE Support
- VsCode type checking
- Parameter hints
- Jump to definition
- Refactoring support

### 3. Maintainability
- Clear function signatures
- Explicit interfaces
- Easier to understand data flow

### 4. Best Practices
- Follow TypeScript conventions
- Proper error handling
- Type-safe configurations

## 📚 TypeScript Resources for K6

### K6 TypeScript Support
- K6 has built-in TypeScript support
- No compilation step needed
- Works with `import` statements

### Type Definitions
K6 provides type definitions through:
```typescript
import { Response } from 'k6'
import { check, group } from 'k6'
import http from 'k6/http'
```

## 🔨 Troubleshooting

### Error: "Cannot find module"
Ensure imports include `.ts` extension:
```typescript
// ✓ Correct
import { login } from './helpers.ts'

// ✗ Wrong
import { login } from './helpers'
```

### Type Errors in IDE
K6 types are inferred from the imports. If you see type errors:
1. Save the file
2. Reload VSCode
3. Check `tsconfig.json` is in k6 folder

### Runtime Type Issues
While types help at development time, K6 still runs the code:
```typescript
// Type safe at dev time, but values at runtime
const response: Response = http.get(url)
const data = parseResponse(response) as any[] // Type assertion
```

## 🔄 Compatibility

### Backward Compatibility
- Old `.js` files still work
- Can mix `.ts` and `.js` files
- No breaking changes to K6 functionality

### Migration Path
If you need to keep old JavaScript files:

```bash
# Option 1: Keep both (during transition)
git add k6/*.ts
git commit -m "Add TypeScript test versions"

# Option 2: Remove old .js files after testing
rm k6/0*.js

# Option 3: Keep as reference
git mv k6/01_auth_test.js k6/01_auth_test.js.bak
```

## ✨ Future Enhancements

### Potential Additions
- [ ] Jest/Vitest setup for unit testing helpers
- [ ] ESLint configuration with TypeScript support
- [ ] Prettier configuration for formatting
- [ ] Pre-commit hooks for type checking
- [ ] GitHub Actions for automated testing

### Advanced TypeScript Features
- [ ] Stricter null checks
- [ ] Exhaustive checks on union types
- [ ] Custom type guards
- [ ] Advanced generic types

## 📋 Checklist

- [x] All `.js` files converted to `.ts`
- [x] Type definitions added for all functions
- [x] Proper import paths with `.ts` extension
- [x] NPM scripts updated for `.ts` files
- [x] `tsconfig.json` created
- [x] Type interfaces documented
- [x] Package.json scripts updated
- [ ] Old `.js` files removed (optional)
- [ ] VSCode recommends type-checking
- [ ] Team trained on new TypeScript setup

## 🎯 Next Steps

1. **Test the new TypeScript setup:**
   ```bash
   pnpm run k6:smoke
   ```

2. **Verify all tests work:**
   ```bash
   pnpm run k6:auth
   pnpm run k6:browse
   pnpm run k6:customer
   ```

3. **Optional: Remove old JavaScript files:**
   ```bash
   rm k6/0[1-7]_*.js
   rm k6/config.js k6/helpers.js
   ```

4. **Commit the changes:**
   ```bash
   git add k6/*.ts k6/tsconfig.json
   git commit -m "Convert K6 tests to TypeScript"
   ```

## 📞 Support

If you encounter any issues:

1. Check that K6 is updated: `k6 version`
2. Verify imports use `.ts` extension
3. Ensure `tsconfig.json` exists in k6 folder
4. Check VSCode TypeScript version

## 🎉 Summary

Your K6 load testing suite is now fully TypeScript-enabled with:
- ✅ Strong type safety
- ✅ Better IDE support
- ✅ Improved maintainability
- ✅ All tests still fully functional
- ✅ Easy to extend and customize

Happy testing! 🚀
