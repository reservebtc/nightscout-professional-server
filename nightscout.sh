#!/bin/bash

# ═══════════════════════════════════════════════════════════════
# NIGHTSCOUT MANAGEMENT SCRIPT
# Professional Nightscout server management script
# ═══════════════════════════════════════════════════════════════

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Pretty output functions
log() {
    echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# ═══════════════════════════════════════════════════════════════
# DEPENDENCY CHECK
# ═══════════════════════════════════════════════════════════════
check_dependencies() {
    log "Checking dependencies..."
    
    if ! command -v docker &> /dev/null; then
        error "Docker is not installed! Install Docker: https://docs.docker.com/get-docker/"
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        error "Docker Compose is not installed!"
        exit 1
    fi
    
    info "✓ All dependencies installed"
}

# ═══════════════════════════════════════════════════════════════
# INITIAL SETUP
# ═══════════════════════════════════════════════════════════════
setup() {
    log "🚀 STARTING NIGHTSCOUT INITIAL SETUP"
    
    # Create necessary directories
    log "Creating directories..."
    mkdir -p mongo-data mongo-backup nightscout-data ssl logs
    
    # Create self-signed SSL certificate (temporary)
    if [ ! -f "ssl/selfsigned.crt" ]; then
        log "Creating SSL certificate..."
        openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
            -keyout ssl/selfsigned.key \
            -out ssl/selfsigned.crt \
            -subj "/C=US/ST=State/L=City/O=Organization/CN=nightscout.local"
        info "✓ SSL certificate created"
    fi
    
    # Check configuration
    if [ ! -f "docker-compose.yml" ]; then
        error "docker-compose.yml file not found!"
        exit 1
    fi
    
    # Check if user changed passwords
    if grep -q "YOUR_STRONG_PASSWORD_HERE\|YOUR_API_SECRET" docker-compose.yml; then
        error "❌ IMPORTANT! You have NOT changed passwords in docker-compose.yml!"
        error "Open the file and replace all 'YOUR_STRONG_PASSWORD_HERE' and 'YOUR_API_SECRET'"
        exit 1
    fi
    
    log "✅ Initial setup completed!"
    info "Now run: ./nightscout.sh start"
}

# ═══════════════════════════════════════════════════════════════
# START SERVER
# ═══════════════════════════════════════════════════════════════
start() {
    log "🚀 STARTING NIGHTSCOUT SERVER..."
    
    # Stop old containers if any
    docker-compose down 2>/dev/null || true
    
    # Start in background
    docker-compose up -d
    
    log "⏳ Waiting for services to start..."
    sleep 10
    
    # Check status
    check_status
    
    log "✅ NIGHTSCOUT IS RUNNING!"
    info "🌐 Available at: https://$(hostname -I | awk '{print $1}')"
    info "📊 Mongo Express: http://localhost:8081 (server only)"
}

# ═══════════════════════════════════════════════════════════════
# STOP SERVER
# ═══════════════════════════════════════════════════════════════
stop() {
    log "⏹️  STOPPING NIGHTSCOUT..."
    docker-compose down
    log "✅ Server stopped"
}

# ═══════════════════════════════════════════════════════════════
# RESTART SERVER
# ═══════════════════════════════════════════════════════════════
restart() {
    log "🔄 RESTARTING NIGHTSCOUT..."
    stop
    sleep 2
    start
}

# ═══════════════════════════════════════════════════════════════
# CHECK STATUS
# ═══════════════════════════════════════════════════════════════
check_status() {
    log "📊 SERVICE STATUS:"
    docker-compose ps
    
    echo ""
    log "🏥 HEALTH CHECK:"
    
    # Check Nightscout
    if curl -s -f -k https://localhost > /dev/null 2>&1; then
        info "✓ Nightscout: OK"
    else
        warning "✗ Nightscout: NOT AVAILABLE"
    fi
    
    # Check MongoDB
    if docker-compose exec -T mongo mongosh --eval "db.adminCommand('ping')" > /dev/null 2>&1; then
        info "✓ MongoDB: OK"
    else
        warning "✗ MongoDB: NOT AVAILABLE"
    fi
}

# ═══════════════════════════════════════════════════════════════
# VIEW LOGS
# ═══════════════════════════════════════════════════════════════
logs() {
    local service=${1:-nightscout}
    log "📜 SERVICE LOGS: $service"
    log "Press Ctrl+C to exit"
    docker-compose logs -f "$service"
}

# ═══════════════════════════════════════════════════════════════
# BACKUP DATABASE
# ═══════════════════════════════════════════════════════════════
backup() {
    local backup_name="nightscout_backup_$(date +%Y%m%d_%H%M%S)"
    
    log "💾 CREATING BACKUP: $backup_name"
    
    docker-compose exec -T mongo mongodump \
        --authenticationDatabase admin \
        --out "/backup/$backup_name"
    
    # Archive
    cd mongo-backup
    tar -czf "${backup_name}.tar.gz" "$backup_name"
    rm -rf "$backup_name"
    cd ..
    
    log "✅ Backup created: mongo-backup/${backup_name}.tar.gz"
    
    # Remove old backups (older than 30 days)
    find mongo-backup/ -name "nightscout_backup_*.tar.gz" -mtime +30 -delete
    log "🗑️  Old backups (>30 days) removed"
}

# ═══════════════════════════════════════════════════════════════
# RESTORE FROM BACKUP
# ═══════════════════════════════════════════════════════════════
restore() {
    local backup_file=$1
    
    if [ -z "$backup_file" ]; then
        error "Specify backup file!"
        info "Example: ./nightscout.sh restore mongo-backup/nightscout_backup_20251022_120000.tar.gz"
        exit 1
    fi
    
    if [ ! -f "$backup_file" ]; then
        error "File $backup_file not found!"
        exit 1
    fi
    
    warning "⚠️  WARNING! This will delete current data!"
    read -p "Are you sure? (yes/no): " -n 3 -r
    echo
    if [[ ! $REPLY =~ ^yes$ ]]; then
        log "Cancelled"
        exit 1
    fi
    
    log "📥 RESTORING FROM BACKUP..."
    
    # Extract
    local backup_dir=$(basename "$backup_file" .tar.gz)
    cd mongo-backup
    tar -xzf "$(basename $backup_file)"
    cd ..
    
    # Restore
    docker-compose exec -T mongo mongorestore \
        --authenticationDatabase admin \
        --drop \
        "/backup/$backup_dir"
    
    rm -rf "mongo-backup/$backup_dir"
    
    log "✅ Restore completed!"
}

# ═══════════════════════════════════════════════════════════════
# UPDATE NIGHTSCOUT
# ═══════════════════════════════════════════════════════════════
update() {
    log "🔄 UPDATING NIGHTSCOUT..."
    
    # Create backup before update
    backup
    
    # Pull new image
    docker-compose pull nightscout
    
    # Restart
    restart
    
    log "✅ Update completed!"
}

# ═══════════════════════════════════════════════════════════════
# PERFORMANCE MONITORING
# ═══════════════════════════════════════════════════════════════
monitor() {
    log "📈 PERFORMANCE MONITORING"
    log "Press Ctrl+C to exit"
    
    docker stats nightscout_app nightscout_mongo nightscout_nginx
}

# ═══════════════════════════════════════════════════════════════
# CLEANUP OLD DATA
# ═══════════════════════════════════════════════════════════════
cleanup() {
    log "🧹 CLEANING OLD DATA..."
    
    # Remove old Docker images
    docker image prune -af
    
    # Clean logs older than 7 days
    find logs/ -name "*.log" -mtime +7 -delete 2>/dev/null || true
    
    log "✅ Cleanup completed"
}

# ═══════════════════════════════════════════════════════════════
# GET IP ADDRESS
# ═══════════════════════════════════════════════════════════════
get_ip() {
    log "🌐 SERVER IP ADDRESSES:"
    
    # Local IP
    local_ip=$(hostname -I | awk '{print $1}')
    info "Local IP: $local_ip"
    
    # External IP
    external_ip=$(curl -s ifconfig.me 2>/dev/null || echo "Not detected")
    info "External IP: $external_ip"
    
    echo ""
    info "🔗 URL for xDrip/Loop:"
    echo "  https://$external_ip/api/v1/"
    echo "  or"
    echo "  https://YOUR_API_SECRET@$external_ip/api/v1/"
}

# ═══════════════════════════════════════════════════════════════
# HELP
# ═══════════════════════════════════════════════════════════════
show_help() {
    cat << EOF
╔═══════════════════════════════════════════════════════════════╗
║           NIGHTSCOUT MANAGEMENT SCRIPT                        ║
║           Professional server management                      ║
╚═══════════════════════════════════════════════════════════════╝

USAGE:
    ./nightscout.sh [COMMAND]

COMMANDS:
    setup       - Initial setup (run ONCE)
    start       - Start server
    stop        - Stop server
    restart     - Restart server
    status      - Check service status
    logs [service] - Show logs (nightscout, mongo, nginx)
    backup      - Create database backup
    restore <file> - Restore from backup
    update      - Update Nightscout to latest version
    monitor     - Performance monitoring
    cleanup     - Clean old data
    ip          - Show server IP addresses
    help        - Show this help

EXAMPLES:
    ./nightscout.sh setup
    ./nightscout.sh start
    ./nightscout.sh logs nightscout
    ./nightscout.sh backup
    ./nightscout.sh restore mongo-backup/nightscout_backup_20251022.tar.gz

╔═══════════════════════════════════════════════════════════════╗
║ IMPORTANT: Before first run:                                 ║
║ 1. Edit docker-compose.yml                                   ║
║ 2. Replace all YOUR_STRONG_PASSWORD_HERE                     ║
║ 3. Run: ./nightscout.sh setup                                ║
╚═══════════════════════════════════════════════════════════════╝
EOF
}

# ═══════════════════════════════════════════════════════════════
# MAIN
# ═══════════════════════════════════════════════════════════════
main() {
    check_dependencies
    
    case "${1:-help}" in
        setup)
            setup
            ;;
        start)
            start
            ;;
        stop)
            stop
            ;;
        restart)
            restart
            ;;
        status)
            check_status
            ;;
        logs)
            logs "$2"
            ;;
        backup)
            backup
            ;;
        restore)
            restore "$2"
            ;;
        update)
            update
            ;;
        monitor)
            monitor
            ;;
        cleanup)
            cleanup
            ;;
        ip)
            get_ip
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            error "Unknown command: $1"
            show_help
            exit 1
            ;;
    esac
}

main "$@"
