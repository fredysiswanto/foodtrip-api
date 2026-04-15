#!/bin/bash

# FoodTrip API Deployment Script
# This script sets up and deploys the API to production

set -e

echo "🚀 FoodTrip API Deployment Script"
echo "=================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Docker is installed
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}❌ Docker is not installed${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ Docker is installed${NC}"
}

# Check if Docker Compose is installed
check_docker_compose() {
    if ! command -v docker-compose &> /dev/null; then
        echo -e "${RED}❌ Docker Compose is not installed${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ Docker Compose is installed${NC}"
}

# Setup environment
setup_env() {
    if [ ! -f .env ]; then
        echo -e "${YELLOW}⚠️  .env file not found${NC}"
        echo "Creating .env from .env.production..."
        cp .env.production .env
        echo -e "${YELLOW}⚠️  Please update .env with your production credentials${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ Environment file found${NC}"
}

# Create required directories
create_dirs() {
    echo "Creating required directories..."
    mkdir -p public/uploads/{dishes,restaurants}
    echo -e "${GREEN}✅ Directories created${NC}"
}

# Build and start services
deploy() {
    echo "Building Docker images..."
    docker-compose build

    echo "Starting services..."
    docker-compose up -d

    echo "Waiting for database to be ready..."
    sleep 10

    echo -e "${GREEN}✅ Deployment complete!${NC}"
    echo ""
    echo "Service Status:"
    docker-compose ps
    echo ""
    echo "API URL: http://localhost:3000/api/v1"
    echo "Test endpoint: curl http://localhost:3000/api/v1/home/restaurants"
}

# Show logs
show_logs() {
    echo "Showing API logs..."
    docker-compose logs -f api
}

# Stop services
stop_services() {
    echo "Stopping services..."
    docker-compose down
    echo -e "${GREEN}✅ Services stopped${NC}"
}

# Main
main() {
    case "${1:-deploy}" in
        deploy)
            check_docker
            check_docker_compose
            setup_env
            create_dirs
            deploy
            ;;
        logs)
            show_logs
            ;;
        stop)
            stop_services
            ;;
        restart)
            stop_services
            deploy
            ;;
        status)
            docker-compose ps
            ;;
        *)
            echo "Usage: $0 {deploy|logs|stop|restart|status}"
            echo ""
            echo "Commands:"
            echo "  deploy    - Build and deploy the API (default)"
            echo "  logs      - Show API logs"
            echo "  stop      - Stop all services"
            echo "  restart   - Restart all services"
            echo "  status    - Show service status"
            exit 1
            ;;
    esac
}

main "$@"
