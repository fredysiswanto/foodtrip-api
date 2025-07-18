# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive documentation overhaul
- User guide with step-by-step instructions
- Quick start guide for new developers
- Contributing guidelines
- Multi-database support (SQLite, MySQL, PostgreSQL, MariaDB, MSSQL)
- Database CLI tools for easier management
- Auto-setup database functionality
- Improved error handling and logging
- Code formatting with Prettier
- ESLint configuration for code quality

### Enhanced
- README.md with detailed setup instructions
- API documentation with better examples
- Environment variable configuration
- Project structure documentation
- Seeder system with realistic test data

### Security
- Updated JWT token handling
- Improved password hashing with bcrypt
- Environment variable validation

## [1.0.0] - 2024-01-XX

### Added
- Initial release of FoodTrip API
- User authentication and authorization
- Restaurant management system
- Dish management with categories
- Order processing and tracking
- Cart functionality
- File upload for images
- Admin dashboard controls
- Customer ordering system
- Restaurant admin panel

### Features
- JWT-based authentication
- Role-based access control (Customer, Restaurant Admin, Admin)
- RESTful API design
- Sequelize ORM integration
- Image upload and storage
- Order status tracking
- Database migrations and seeders

### Supported Databases
- MySQL
- SQLite
- PostgreSQL
- MariaDB

### API Endpoints
- Authentication (`/api/v1/auth`)
- Home/Public routes (`/api/v1/home`)
- Customer routes (`/api/v1/customer`)
- Restaurant admin routes (`/api/v1/resto-admin`)
- Admin routes (`/api/v1/admin`)

---

## Version History

### [1.0.0] - Initial Release
- Complete food ordering API
- Multi-role user system
- Restaurant and dish management
- Order processing system
- File upload functionality
- Database migrations and seeders

---

## Types of Changes

- **Added** for new features
- **Changed** for changes in existing functionality
- **Deprecated** for soon-to-be removed features
- **Removed** for now removed features
- **Fixed** for any bug fixes
- **Security** for vulnerability fixes
- **Enhanced** for improvements to existing features

## Migration Notes

### From Previous Versions

When upgrading, please:
1. Backup your database
2. Update environment variables according to `.env.example`
3. Run database migrations: `pnpm run db:migrate`
4. Update dependencies: `pnpm install`
5. Restart the application

### Breaking Changes

None in current version.

## Support

For questions about releases or upgrade issues:
- Check the [User Guide](./docs/USER_GUIDE.md)
- Review [API Documentation](./docs/API_DOCUMENTATION.md)
- Open an issue on GitHub
- Check existing discussions

## Release Schedule

- **Major releases**: Quarterly (breaking changes)
- **Minor releases**: Monthly (new features)
- **Patch releases**: As needed (bug fixes)

## Contributors

Special thanks to all contributors who have helped improve this project:

- [James Paul L. Tulod](https://github.com/polekstulod) - Original creator
- [Fredy Siswanto](https://github.com/fredysiswanto) - Current maintainer
- All other contributors listed in the README

---

*For the complete list of changes, see the [commit history](https://github.com/fredysiswanto/foodtrip-api/commits).*
