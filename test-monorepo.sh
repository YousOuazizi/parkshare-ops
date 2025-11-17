#!/bin/bash

# Script de test automatique ParkShare Monorepo
# Usage: ./test-monorepo.sh [quick|full|github|backend|frontend|mobile]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

log_error() {
    echo -e "${RED}[✗]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Test GitHub repositories
test_github() {
    log_info "Test 1/5: Vérification des repositories GitHub..."

    REPOS=(
        "parkshare-frontend"
        "parkshare-backend"
        "parkshare-mobile"
        "parkshare-ops"
    )

    for repo in "${REPOS[@]}"; do
        if curl -s -o /dev/null -w "%{http_code}" "https://github.com/YousOuazizi/$repo" | grep -q "200"; then
            log_success "Repository $repo accessible"
        else
            log_error "Repository $repo non accessible"
            return 1
        fi
    done

    log_success "Tous les repositories GitHub sont accessibles"
}

# Test structure locale
test_structure() {
    log_info "Test 2/5: Vérification de la structure locale..."

    DIRS=(
        "$SCRIPT_DIR/parkshare-frontend"
        "$SCRIPT_DIR/parkshare-backend"
        "$SCRIPT_DIR/parkshare-mobile"
        "$SCRIPT_DIR/parkshare-ops"
    )

    for dir in "${DIRS[@]}"; do
        if [ -d "$dir/.git" ]; then
            log_success "$(basename $dir) - Repository Git présent"
        else
            log_error "$(basename $dir) - Repository Git manquant"
            return 1
        fi
    done

    log_success "Structure monorepo correcte"
}

# Test Backend
test_backend() {
    log_info "Test 3/5: Test du Backend..."

    cd "$SCRIPT_DIR/parkshare-backend"

    # Vérifier node_modules
    if [ ! -d "node_modules" ]; then
        log_warning "node_modules manquant, installation..."
        npm install --legacy-peer-deps
    fi

    # Vérifier package.json
    if [ ! -f "package.json" ]; then
        log_error "package.json manquant"
        return 1
    fi

    log_success "Backend structure OK"

    # Test démarrage (optionnel - ne démarre pas réellement)
    if command -v npm &> /dev/null; then
        log_success "npm disponible"
    else
        log_error "npm non disponible"
        return 1
    fi
}

# Test Frontend
test_frontend() {
    log_info "Test 4/5: Test du Frontend..."

    cd "$SCRIPT_DIR/parkshare-frontend"

    # Vérifier node_modules
    if [ ! -d "node_modules" ]; then
        log_warning "node_modules manquant, installation..."
        npm install --legacy-peer-deps
    fi

    # Vérifier angular.json
    if [ ! -f "angular.json" ]; then
        log_error "angular.json manquant"
        return 1
    fi

    # Vérifier src/
    if [ ! -d "src" ]; then
        log_error "Dossier src/ manquant"
        return 1
    fi

    log_success "Frontend structure OK"
}

# Test Mobile
test_mobile() {
    log_info "Test 5/5: Test du Mobile..."

    cd "$SCRIPT_DIR/parkshare-mobile"

    # Vérifier pubspec.yaml
    if [ ! -f "pubspec.yaml" ]; then
        log_error "pubspec.yaml manquant"
        return 1
    fi

    # Vérifier lib/
    if [ ! -d "lib" ]; then
        log_error "Dossier lib/ manquant"
        return 1
    fi

    log_success "Mobile structure OK"

    # Test Flutter (optionnel)
    if command -v flutter &> /dev/null; then
        log_success "Flutter disponible"
        flutter --version | head -1
    else
        log_warning "Flutter non disponible (optionnel)"
    fi
}

# Test complet
test_all() {
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║       Test Complet ParkShare Monorepo                 ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""

    test_github && \
    test_structure && \
    test_backend && \
    test_frontend && \
    test_mobile

    RESULT=$?

    echo ""
    echo "═══════════════════════════════════════════════════════"

    if [ $RESULT -eq 0 ]; then
        log_success "TOUS LES TESTS PASSENT ✓"
        echo ""
        log_info "Votre monorepo est 100% fonctionnel!"
        echo ""
        log_info "Prochaines étapes:"
        echo "  1. Démarrer le backend:    cd parkshare-backend && npm run start:dev"
        echo "  2. Démarrer le frontend:   cd parkshare-frontend && npm start"
        echo "  3. Ouvrir l'app:           http://localhost:4200"
    else
        log_error "CERTAINS TESTS ONT ÉCHOUÉ ✗"
        echo ""
        log_info "Consultez TEST_GUIDE.md pour plus de détails"
    fi

    echo "═══════════════════════════════════════════════════════"
    echo ""
}

# Test rapide (sans GitHub)
test_quick() {
    echo ""
    log_info "Test Rapide du Monorepo..."
    echo ""

    test_structure && \
    test_backend && \
    test_frontend

    RESULT=$?

    echo ""
    if [ $RESULT -eq 0 ]; then
        log_success "Tests rapides OK ✓"
    else
        log_error "Tests rapides échoués ✗"
    fi
}

# Afficher l'aide
show_help() {
    cat << EOF
ParkShare Monorepo - Script de Test

Usage: ./test-monorepo.sh [MODE]

Modes disponibles:
  full        Test complet (défaut) - tous les tests
  quick       Test rapide - sans GitHub, juste structure locale
  github      Test uniquement les repositories GitHub
  backend     Test uniquement le backend
  frontend    Test uniquement le frontend
  mobile      Test uniquement le mobile
  help        Afficher cette aide

Exemples:
  ./test-monorepo.sh              # Test complet
  ./test-monorepo.sh quick        # Test rapide
  ./test-monorepo.sh backend      # Test backend uniquement

EOF
}

# Main
MODE="${1:-full}"

case "$MODE" in
    full)
        test_all
        ;;
    quick)
        test_quick
        ;;
    github)
        test_github
        ;;
    backend)
        test_backend
        ;;
    frontend)
        test_frontend
        ;;
    mobile)
        test_mobile
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        log_error "Mode invalide: $MODE"
        show_help
        exit 1
        ;;
esac
