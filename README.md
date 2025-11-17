# ParkShare Ops - Configurations DevOps Centralisées

Ce repository contient toutes les configurations DevOps, d'infrastructure et de monitoring pour la plateforme ParkShare.

## 📁 Structure

```
parkshare-ops/
├── ci-cd/                      # Pipelines CI/CD
│   └── .github/workflows/      # GitHub Actions
├── docker/                     # Configurations Docker
│   ├── kubernetes/             # Manifests K8s
│   ├── monitoring/             # Prometheus, Grafana, Loki
│   ├── scripts/                # Scripts utilitaires
│   └── terraform/              # Infrastructure as Code
├── docker-compose.dev.yml      # Stack développement
├── docker-compose.prod.yml     # Stack production
├── docker-compose.monitoring.yml # Stack monitoring
└── README.md                   # Ce fichier
```

## 🚀 Démarrage Rapide

### Développement Local

```bash
# Lancer toute la stack (Backend + Frontend + DB)
docker-compose -f docker-compose.dev.yml up

# Lancer uniquement le monitoring
docker-compose -f docker-compose.monitoring.yml up
```

### Production

```bash
# Déploiement production
docker-compose -f docker-compose.prod.yml up -d
```

## 🐳 Docker Compose

### Stack Développement (`docker-compose.dev.yml`)

Services inclus :
- **Backend API** (NestJS) - Port 3000
- **Frontend** (Angular) - Port 4200
- **PostgreSQL** - Port 5432
- **Redis** - Port 6379
- **Adminer** (DB Admin) - Port 8080

```bash
docker-compose -f docker-compose.dev.yml up
```

### Stack Production (`docker-compose.prod.yml`)

Services inclus :
- **Backend API** (mode production)
- **Frontend** (serveur Nginx)
- **PostgreSQL** (avec volumes persistants)
- **Redis** (cache)
- **Nginx** (reverse proxy)

```bash
docker-compose -f docker-compose.prod.yml up -d
```

### Stack Monitoring (`docker-compose.monitoring.yml`)

Services inclus :
- **Prometheus** - Métriques - Port 9090
- **Grafana** - Visualisation - Port 3001
- **AlertManager** - Alertes - Port 9093
- **Loki** - Logs aggregation
- **Promtail** - Log collector

```bash
docker-compose -f docker-compose.monitoring.yml up
```

Accès :
- Grafana : http://localhost:3001 (admin/admin)
- Prometheus : http://localhost:9090
- AlertManager : http://localhost:9093

## ☸️ Kubernetes

### Déploiement avec Kustomize

```bash
cd docker/kubernetes

# Development
kubectl apply -k overlays/dev/

# Production
kubectl apply -k overlays/prod/
```

### Déploiement avec Helm

```bash
cd docker/kubernetes/helm

# Installer
helm install parkshare ./parkshare -f values.yaml

# Upgrade
helm upgrade parkshare ./parkshare -f values.yaml

# Désinstaller
helm uninstall parkshare
```

## 🏗️ Terraform

Infrastructure as Code pour déploiement cloud :

```bash
cd docker/terraform

# Initialiser
terraform init

# Planifier
terraform plan -var-file=environments/prod/terraform.tfvars

# Appliquer
terraform apply -var-file=environments/prod/terraform.tfvars
```

## 🔄 CI/CD

### GitHub Actions

Workflows disponibles dans `ci-cd/.github/workflows/` :

- **ci.yml** : Tests et linting sur chaque PR
- **docker-build.yml** : Build des images Docker
- **deploy.yml** : Déploiement automatique
- **security-scan.yml** : Scan de sécurité

### Setup GitHub Actions

```bash
cd docker/scripts
./setup-github-actions.sh
```

Secrets requis dans GitHub :
- `DOCKER_USERNAME`
- `DOCKER_PASSWORD`
- `DATABASE_URL`
- `JWT_SECRET`
- `STRIPE_SECRET_KEY`

## 📊 Monitoring

### Prometheus

Configuration dans `docker/monitoring/prometheus/prometheus.yml`

Métriques collectées :
- API response times
- Database queries
- CPU/Memory usage
- Request rates
- Error rates

### Grafana

Dashboards pré-configurés :
- **API Performance** : Temps de réponse, throughput
- **Database** : Connexions, queries
- **Infrastructure** : CPU, RAM, Disk
- **Business Metrics** : Réservations, paiements

### Loki + Promtail

Agrégation de logs :
- Logs API (NestJS)
- Logs Base de données
- Logs Nginx
- Logs containers

## 🛠️ Scripts Utilitaires

### Déploiement

```bash
cd docker/scripts

# Déployer sur environnement
./deploy.sh production

# Rollback
./deploy.sh production rollback
```

### Backup

```bash
# Backup base de données
./backup.sh

# Restaurer depuis backup
./restore.sh backup-2024-11-17.sql
```

### Monitoring Setup

```bash
# Installer monitoring stack
./setup-monitoring.sh
```

### Logs

```bash
# Voir les logs en temps réel
./logs.sh backend
./logs.sh frontend
./logs.sh all
```

## 🔒 Sécurité

### Scan de Vulnérabilités

```bash
# Scan des images Docker
docker scan parkshare-backend:latest
docker scan parkshare-frontend:latest
```

### SSL/TLS

Certificats Let's Encrypt automatiques via Nginx :

```yaml
# docker-compose.prod.yml
nginx:
  environment:
    - LETSENCRYPT_HOST=api.parkshare.com
    - LETSENCRYPT_EMAIL=admin@parkshare.com
```

## 📈 Scaling

### Horizontal Scaling (K8s)

```bash
# Scaler le backend
kubectl scale deployment parkshare-backend --replicas=5

# Auto-scaling
kubectl autoscale deployment parkshare-backend \
  --cpu-percent=70 --min=2 --max=10
```

### Load Balancing

Nginx configuré en mode load balancer :

```nginx
upstream backend {
    least_conn;
    server backend1:3000;
    server backend2:3000;
    server backend3:3000;
}
```

## 🔧 Configuration

### Variables d'Environnement

Fichiers `.env` requis :

**Backend:**
```env
DATABASE_URL=postgresql://user:pass@db:5432/parkshare
REDIS_URL=redis://redis:6379
JWT_SECRET=your-secret
STRIPE_SECRET_KEY=sk_live_...
```

**Frontend:**
```env
API_URL=https://api.parkshare.com
WS_URL=wss://api.parkshare.com
```

## 📝 Conventions

### Tags Docker

- `latest` : Dernière version stable
- `dev` : Version développement
- `v1.0.0` : Version spécifique
- `sha-abc123` : Commit hash

### Branches Git

- `main` : Production
- `develop` : Développement
- `feature/*` : Nouvelles fonctionnalités
- `hotfix/*` : Corrections urgentes

## 🚨 Alertes

AlertManager configuré pour :
- API down (> 1 min)
- Erreurs rate > 5%
- CPU > 80%
- RAM > 85%
- Disk > 90%

Notifications via :
- Slack
- Email
- PagerDuty

## 📚 Documentation Complémentaire

- [Guide Kubernetes](./docker/kubernetes/README.md)
- [Guide Terraform](./docker/terraform/README.md)
- [Monitoring Setup](./docker/scripts/setup-monitoring.sh)
- [GitHub Actions](./ci-cd/.github/SETUP_ACTIONS.txt)

## 🆘 Troubleshooting

### Container ne démarre pas

```bash
# Voir les logs
docker-compose logs -f [service-name]

# Rebuilder l'image
docker-compose build --no-cache [service-name]
```

### Base de données inaccessible

```bash
# Vérifier le statut
docker-compose ps

# Redémarrer
docker-compose restart postgres
```

### Monitoring ne fonctionne pas

```bash
# Réinitialiser
docker-compose -f docker-compose.monitoring.yml down -v
docker-compose -f docker-compose.monitoring.yml up -d
```

## 🤝 Contribution

Pour ajouter de nouvelles configurations :

1. Créer une branche `ops/feature-name`
2. Tester localement avec Docker Compose
3. Mettre à jour la documentation
4. Créer une PR vers `develop`

## 📞 Support

Pour toute question sur l'infrastructure :
- **Ops Team** : ops@parkshare.com
- **On-call** : +33 X XX XX XX XX

---

Maintenu par l'équipe DevOps ParkShare
