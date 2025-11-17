# 📦 Configuration GitHub pour ParkShare

Ce guide vous explique comment pousser chaque repository vers GitHub.

## 🎯 Structure GitHub Recommandée

Vous aurez besoin de créer **4 repositories sur GitHub** :

1. `parkshare-frontend` - Application Angular
2. `parkshare-backend` - API NestJS
3. `parkshare-mobile` - Application Mobile Flutter
4. `parkshare-ops` - DevOps & Infrastructure

## 🚀 Étapes de Configuration

### 1. Créer les Repositories sur GitHub

Allez sur https://github.com et créez 4 nouveaux repositories :

```
- Repository 1: parkshare-frontend
  Description: ParkShare - Angular 18 Frontend Application
  Visibilité: Private (recommandé)

- Repository 2: parkshare-backend
  Description: ParkShare - NestJS Backend API
  Visibilité: Private (recommandé)

- Repository 3: parkshare-mobile
  Description: ParkShare - Flutter Mobile Application (iOS & Android)
  Visibilité: Private (recommandé)

- Repository 4: parkshare-ops
  Description: ParkShare - DevOps & Infrastructure Configuration
  Visibilité: Private (recommandé)
```

**Important :** Ne cochez PAS "Initialize this repository with a README" car vos repos locaux ont déjà un commit initial.

### 2. Push vers GitHub

#### Frontend

```bash
cd /home/user/parkshare-monorepo/parkshare-frontend

# Ajouter le remote GitHub
git remote add origin https://github.com/VOTRE_USERNAME/parkshare-frontend.git

# Renommer la branche en main
git branch -M main

# Pusher vers GitHub
git push -u origin main
```

#### Backend

```bash
cd /home/user/parkshare-monorepo/parkshare-backend

# Ajouter le remote GitHub
git remote add origin https://github.com/VOTRE_USERNAME/parkshare-backend.git

# Renommer la branche en main
git branch -M main

# Pusher vers GitHub
git push -u origin main
```

#### Mobile

```bash
cd /home/user/parkshare-monorepo/parkshare-mobile

# Ajouter le remote GitHub
git remote add origin https://github.com/VOTRE_USERNAME/parkshare-mobile.git

# Renommer la branche en main
git branch -M main

# Pusher vers GitHub
git push -u origin main
```

#### Ops

```bash
cd /home/user/parkshare-monorepo/parkshare-ops

# Ajouter le remote GitHub
git remote add origin https://github.com/VOTRE_USERNAME/parkshare-ops.git

# Renommer la branche en main
git branch -M main

# Pusher vers GitHub
git push -u origin main
```

### 3. Vérification

Allez sur GitHub et vérifiez que les 4 repositories contiennent bien vos fichiers :

- ✅ `parkshare-frontend` : doit contenir `src/`, `package.json`, etc.
- ✅ `parkshare-backend` : doit contenir `src/`, `nest-cli.json`, etc.
- ✅ `parkshare-mobile` : doit contenir `lib/`, `pubspec.yaml`, etc.
- ✅ `parkshare-ops` : doit contenir `docker/`, `ci-cd/`, `docker-compose*.yml`

## 🔐 Configuration SSH (Recommandé)

Si vous préférez utiliser SSH au lieu de HTTPS :

### 1. Générer une clé SSH

```bash
ssh-keygen -t ed25519 -C "votre.email@example.com"
# Appuyez sur Entrée pour accepter l'emplacement par défaut
# Entrez une passphrase (optionnel mais recommandé)
```

### 2. Ajouter la clé à l'agent SSH

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### 3. Copier la clé publique

```bash
cat ~/.ssh/id_ed25519.pub
# Copiez le résultat complet
```

### 4. Ajouter la clé sur GitHub

1. Allez sur GitHub → Settings → SSH and GPG keys
2. Cliquez sur "New SSH key"
3. Collez votre clé publique
4. Donnez-lui un nom (ex: "Mon ordinateur")

### 5. Changer les remotes en SSH

```bash
# Frontend
cd /home/user/parkshare-monorepo/parkshare-frontend
git remote set-url origin git@github.com:VOTRE_USERNAME/parkshare-frontend.git

# Backend
cd /home/user/parkshare-monorepo/parkshare-backend
git remote set-url origin git@github.com:VOTRE_USERNAME/parkshare-backend.git

# Mobile
cd /home/user/parkshare-monorepo/parkshare-mobile
git remote set-url origin git@github.com:VOTRE_USERNAME/parkshare-mobile.git

# Ops
cd /home/user/parkshare-monorepo/parkshare-ops
git remote set-url origin git@github.com:VOTRE_USERNAME/parkshare-ops.git
```

## 📋 Configuration des GitHub Actions

### 1. Secrets à Configurer

Pour chaque repository, allez dans **Settings → Secrets and variables → Actions** et ajoutez :

#### parkshare-backend
```
DOCKER_USERNAME         # Votre username Docker Hub
DOCKER_PASSWORD         # Votre password Docker Hub
DATABASE_URL            # URL de production PostgreSQL
JWT_SECRET             # Clé secrète JWT
JWT_REFRESH_SECRET     # Clé secrète JWT refresh
STRIPE_SECRET_KEY      # Clé Stripe
TWILIO_ACCOUNT_SID     # Sid Twilio (SMS)
TWILIO_AUTH_TOKEN      # Token Twilio
AWS_ACCESS_KEY_ID      # AWS pour S3
AWS_SECRET_ACCESS_KEY  # AWS Secret
```

#### parkshare-frontend
```
DOCKER_USERNAME        # Votre username Docker Hub
DOCKER_PASSWORD        # Votre password Docker Hub
API_URL               # URL de l'API en production
```

#### parkshare-mobile
```
FLUTTER_VERSION        # Version Flutter (ex: 3.16.0)
ANDROID_KEYSTORE      # Keystore Android (base64)
ANDROID_KEY_ALIAS     # Alias de la clé
ANDROID_KEY_PASSWORD  # Mot de passe clé
IOS_CERTIFICATE       # Certificat iOS (base64)
IOS_PROVISIONING      # Profil de provisioning iOS
APP_STORE_CONNECT_KEY # Clé App Store Connect
```

#### parkshare-ops
```
DOCKER_USERNAME        # Votre username Docker Hub
DOCKER_PASSWORD        # Votre password Docker Hub
KUBECONFIG            # Configuration Kubernetes (base64)
```

### 2. Activer les GitHub Actions

Les workflows sont déjà configurés dans `parkshare-ops/ci-cd/.github/workflows/`

1. Copiez le dossier `.github` dans chaque repo :
   ```bash
   # Backend
   cp -r parkshare-ops/ci-cd/.github parkshare-backend/

   # Frontend
   cp -r parkshare-ops/ci-cd/.github parkshare-frontend/
   ```

2. Committez et poussez :
   ```bash
   cd parkshare-backend
   git add .github
   git commit -m "ci: Add GitHub Actions workflows"
   git push

   cd ../parkshare-frontend
   git add .github
   git commit -m "ci: Add GitHub Actions workflows"
   git push
   ```

## 🔄 Workflow de Développement

### Branches Recommandées

```
main         → Production
develop      → Développement
feature/*    → Nouvelles fonctionnalités
hotfix/*     → Corrections urgentes
release/*    → Préparation release
```

### Exemple de Workflow

```bash
# Créer une nouvelle feature
git checkout -b feature/nouvelle-fonctionnalite

# Faire vos modifications
git add .
git commit -m "feat: Ajout de la nouvelle fonctionnalité"

# Pousser vers GitHub
git push -u origin feature/nouvelle-fonctionnalite

# Créer une Pull Request sur GitHub
# Merger dans develop après review
# Merger develop dans main pour release
```

## 📝 Conventions de Commit

Utilisez les préfixes suivants :

```
feat:     Nouvelle fonctionnalité
fix:      Correction de bug
docs:     Documentation
style:    Formatting, point-virgules manquants, etc.
refactor: Refactoring du code
test:     Ajout de tests
chore:    Maintenance, configuration
perf:     Amélioration des performances
ci:       CI/CD
```

Exemples :
```bash
git commit -m "feat: Add user authentication"
git commit -m "fix: Resolve booking creation bug"
git commit -m "docs: Update API documentation"
```

## 🛡️ Protection des Branches

Recommandé pour `main` et `develop` :

1. Allez dans **Settings → Branches → Add rule**
2. Pattern de branche : `main`
3. Cochez :
   - ✅ Require a pull request before merging
   - ✅ Require status checks to pass before merging
   - ✅ Require conversation resolution before merging
   - ✅ Include administrators

## 🌐 GitHub Pages (Optionnel)

Pour héberger la documentation :

1. Allez dans **Settings → Pages**
2. Source : Deploy from a branch
3. Branche : `main` ou `gh-pages`
4. Dossier : `/docs` ou `root`

## 📊 Insights & Analytics

GitHub vous donne accès à :

- **Pulse** : Activité récente
- **Contributors** : Contributeurs
- **Traffic** : Visiteurs
- **Commits** : Historique
- **Network** : Graphe des branches

## 🤝 Collaboration

Pour ajouter des collaborateurs :

1. **Settings → Collaborators**
2. Cliquez sur "Add people"
3. Entrez le username GitHub
4. Choisissez le niveau d'accès :
   - **Read** : Lecture seule
   - **Write** : Peut pusher
   - **Admin** : Tous les droits

## ✅ Checklist Finale

Avant de considérer que tout est configuré :

- [ ] Les 4 repos sont créés sur GitHub
- [ ] Le code est poussé dans chaque repo
- [ ] Les secrets GitHub Actions sont configurés
- [ ] Les workflows CI/CD fonctionnent
- [ ] La protection des branches est activée
- [ ] README.md est à jour dans chaque repo
- [ ] Les collaborateurs sont ajoutés

## 🆘 Troubleshooting

### Erreur "Permission denied (publickey)"

→ Configurez SSH correctement (voir section SSH ci-dessus)

### Erreur "remote: Repository not found"

→ Vérifiez que le nom du repository et votre username sont corrects

### Erreur "failed to push some refs"

→ Faites un `git pull origin main` avant de pusher

### Les GitHub Actions échouent

→ Vérifiez que tous les secrets requis sont configurés

---

Pour toute question, consultez la [documentation GitHub](https://docs.github.com).
