#!/bin/bash

# FoodTrip API Health Check Script
# Monitors API and database health

API_URL="${API_URL:-http://localhost:3000}"
CHECK_INTERVAL="${CHECK_INTERVAL:-30}"
MAX_RETRIES=3

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

check_api_health() {
    response=$(curl -s -w "\n%{http_code}" "${API_URL}/api/v1/home/restaurants" 2>&1)
    http_code=$(echo "$response" | tail -n1)
    
    if [ "$http_code" -eq 200 ]; then
        echo -e "${GREEN}✅ API is healthy (HTTP $http_code)${NC}"
        return 0
    else
        echo -e "${RED}❌ API returned HTTP $http_code${NC}"
        return 1
    fi
}

check_database_health() {
    if command -v docker-compose &> /dev/null; then
        status=$(docker-compose exec -T mysql mysqladmin ping -h localhost 2>&1)
        if echo "$status" | grep -q "mysqld is alive"; then
            echo -e "${GREEN}✅ Database is healthy${NC}"
            return 0
        fi
    fi
    echo -e "${YELLOW}⚠️  Could not verify database health${NC}"
    return 0
}

check_disk_space() {
    usage=$(df -h . | awk 'NR==2 {print $5}' | sed 's/%//')
    
    if [ "$usage" -gt 90 ]; then
        echo -e "${RED}❌ Disk usage critical: ${usage}%${NC}"
        return 1
    elif [ "$usage" -gt 80 ]; then
        echo -e "${YELLOW}⚠️  Disk usage high: ${usage}%${NC}"
        return 0
    else
        echo -e "${GREEN}✅ Disk usage normal: ${usage}%${NC}"
        return 0
    fi
}

check_docker_services() {
    if ! command -v docker-compose &> /dev/null; then
        return 0
    fi
    
    api_status=$(docker-compose ps api 2>/dev/null | grep -c "Up" || echo 0)
    mysql_status=$(docker-compose ps mysql 2>/dev/null | grep -c "Up" || echo 0)
    
    if [ "$api_status" -eq 1 ]; then
        echo -e "${GREEN}✅ API container is running${NC}"
    else
        echo -e "${RED}❌ API container is not running${NC}"
    fi
    
    if [ "$mysql_status" -eq 1 ]; then
        echo -e "${GREEN}✅ MySQL container is running${NC}"
    else
        echo -e "${RED}❌ MySQL container is not running${NC}"
    fi
}

continuous_monitoring() {
    echo "Starting continuous health monitoring (interval: ${CHECK_INTERVAL}s)"
    echo "Press Ctrl+C to stop"
    
    while true; do
        clear
        echo "FoodTrip API Health Check - $(date)"
        echo "========================================"
        echo ""
        
        echo "🐳 Docker Services:"
        check_docker_services
        echo ""
        
        echo "🖥️  System:"
        check_disk_space
        echo ""
        
        echo "📊 Database:"
        check_database_health
        echo ""
        
        echo "🌐 API:"
        check_api_health
        echo ""
        
        echo "Next check in ${CHECK_INTERVAL} seconds..."
        sleep "$CHECK_INTERVAL"
    done
}

# Main
case "${1:-check}" in
    check)
        echo "FoodTrip API Health Check"
        echo "========================="
        echo ""
        check_docker_services
        echo ""
        check_disk_space
        echo ""
        check_database_health
        echo ""
        check_api_health
        ;;
    monitor)
        continuous_monitoring
        ;;
    *)
        echo "Usage: $0 {check|monitor}"
        echo ""
        echo "Commands:"
        echo "  check    - Run a single health check (default)"
        echo "  monitor  - Continuous health monitoring"
        exit 1
        ;;
esac
