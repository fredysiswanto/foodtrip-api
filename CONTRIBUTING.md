# Contributing to FoodTrip API

We love your input! We want to make contributing to FoodTrip API as easy and transparent as possible, whether it's:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Proposing new features
- Becoming a maintainer

## Development Process

We use GitHub to host code, to track issues and feature requests, as well as accept pull requests.

### Pull Requests Process

1. Fork the repo and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints.
6. Issue that pull request!

## Development Setup

### 1. Fork and Clone
```bash
# Fork the repository on GitHub, then:
git clone https://github.com/YOUR_USERNAME/foodtrip-api.git
cd foodtrip-api
```

### 2. Install Dependencies
```bash
pnpm install
```

### 3. Setup Environment
```bash
cp .env.example .env
# Edit .env with your settings
```

### 4. Setup Database
```bash
pnpm run db:setup
```

### 5. Start Development
```bash
pnpm run dev
```

## Code Style

We use ESLint and Prettier to maintain code quality and consistency.

### Before Committing
```bash
# Lint your code
pnpm run lint:fix

# Format your code
pnpm run format

# Check for issues
pnpm run lint:check
pnpm run format:check
```

### Code Style Guidelines

1. **Use ES6+ features** where appropriate
2. **Follow camelCase** for variables and functions
3. **Use PascalCase** for classes and constructors
4. **Add JSDoc comments** for functions and classes
5. **Keep functions small** and focused
6. **Use meaningful variable names**

### Example Code Style

```javascript
/**
 * Creates a new dish in the restaurant
 * @param {Object} dishData - The dish information
 * @param {string} dishData.name - Name of the dish
 * @param {number} dishData.price - Price of the dish
 * @param {string} dishData.restaurantId - Restaurant ID
 * @returns {Promise<Object>} Created dish object
 */
async function createDish(dishData) {
  try {
    const dish = await Dish.create({
      name: dishData.name,
      price: dishData.price,
      restaurantId: dishData.restaurantId
    })
    
    return dish
  } catch (error) {
    throw new Error(`Failed to create dish: ${error.message}`)
  }
}
```

## Database Guidelines

### Migrations
- Always create migrations for schema changes
- Include both `up` and `down` methods
- Use descriptive migration names
- Test migrations in both directions

```javascript
// Example migration
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('Dishes', 'description', {
      type: Sequelize.TEXT,
      allowNull: true
    })
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('Dishes', 'description')
  }
}
```

### Seeders
- Create realistic test data
- Use faker for generating data
- Make seeders idempotent
- Include various scenarios

## API Guidelines

### REST Conventions
- Use appropriate HTTP methods (GET, POST, PUT, DELETE)
- Use plural nouns for resources (`/restaurants`, not `/restaurant`)
- Use consistent response formats
- Include proper status codes

### Error Handling
```javascript
// Good error handling
try {
  const restaurant = await Restaurant.findByPk(id)
  if (!restaurant) {
    return res.status(404).json({
      success: false,
      message: 'Restaurant not found'
    })
  }
  // ... success logic
} catch (error) {
  return res.status(500).json({
    success: false,
    message: 'Internal server error',
    error: process.env.NODE_ENV === 'development' ? error.message : undefined
  })
}
```

## Testing

### Writing Tests
- Write tests for new features
- Include positive and negative test cases
- Test edge cases
- Use descriptive test names

### Manual Testing
- Test all endpoints with Postman
- Verify authentication works
- Test with different user roles
- Check error scenarios

## Documentation

### When to Update Documentation
- New API endpoints
- Changed request/response formats
- New environment variables
- Changed setup procedures

### Documentation Standards
- Use clear, concise language
- Include code examples
- Keep examples up to date
- Add troubleshooting tips

## Commit Message Guidelines

We follow conventional commits for clear commit history:

### Format
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Examples
```bash
feat(auth): add password reset functionality
fix(db): resolve connection timeout issue
docs(api): update authentication examples
chore(deps): update sequelize to v6.37.7
```

## Branching Strategy

### Branch Types
- `main`: Production-ready code
- `develop`: Integration branch for features
- `feature/`: New features (`feature/user-profiles`)
- `fix/`: Bug fixes (`fix/auth-token-refresh`)
- `docs/`: Documentation updates (`docs/api-reference`)

### Workflow
1. Create feature branch from `develop`
2. Make changes and commit
3. Push branch and create PR to `develop`
4. After review and approval, merge to `develop`
5. Periodically merge `develop` to `main`

## Issue Guidelines

### Bug Reports
Please include:
- Clear description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Environment details (OS, Node version, database)
- Error messages or logs

### Feature Requests
Please include:
- Clear description of the feature
- Use case or problem it solves
- Proposed implementation (if any)
- Alternatives considered

### Issue Templates

**Bug Report:**
```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear description of what you expected to happen.

**Environment:**
- OS: [e.g. Windows, macOS, Linux]
- Node.js version: [e.g. 18.0.0]
- Database: [e.g. MySQL 8.0]
- API version: [e.g. v1]
```

## Release Process

### Version Numbering
We use Semantic Versioning (SemVer):
- `MAJOR.MINOR.PATCH` (e.g., 1.2.3)
- MAJOR: Breaking changes
- MINOR: New features (backward compatible)
- PATCH: Bug fixes (backward compatible)

### Release Checklist
- [ ] Update version in package.json
- [ ] Update CHANGELOG.md
- [ ] Update documentation if needed
- [ ] Create release notes
- [ ] Tag the release
- [ ] Deploy to production

## Security

### Reporting Security Issues
Please do NOT report security vulnerabilities publicly. Instead:
1. Email the maintainers directly
2. Include detailed information about the vulnerability
3. Allow time for the issue to be addressed before disclosure

### Security Best Practices
- Never commit secrets or API keys
- Use environment variables for sensitive data
- Validate and sanitize all inputs
- Use HTTPS in production
- Keep dependencies updated

## Community

### Code of Conduct
We are committed to providing a friendly, safe, and welcoming environment for all contributors.

### Getting Help
- Check the documentation first
- Search existing issues
- Join our discussions
- Ask questions in issues (tag with `question`)

### Recognition
Contributors will be recognized in:
- README.md contributors section
- Release notes
- Special thanks in major releases

## License

By contributing to FoodTrip API, you agree that your contributions will be licensed under the MIT License.

## Questions?

Feel free to reach out by:
- Opening an issue
- Starting a discussion
- Contacting the maintainers

Thank you for contributing! 🎉
