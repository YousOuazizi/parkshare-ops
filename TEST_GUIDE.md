# 🧪 Guide de Test Complet - ParkShare

Ce guide vous permet de vérifier que tout le monorepo fonctionne correctement.

## ✅ Checklist de Test Rapide

### 1. Vérification GitHub (30 secondes)
- [ ] Les 4 repos sont accessibles sur GitHub
- [ ] Chaque repo contient les bons fichiers
- [ ] La documentation est présente

### 2. Test Backend (5 minutes)
- [ ] Le backend démarre sans erreur
- [ ] L'API répond sur http://localhost:3000
- [ ] Swagger docs accessible sur http://localhost:3000/api

### 3. Test Frontend (5 minutes)
- [ ] Le frontend démarre sans erreur
- [ ] L'application s'ouvre sur http://localhost:4200
- [ ] L'interface s'affiche correctement

### 4. Test de Connexion Frontend ↔ Backend (2 minutes)
- [ ] Le frontend peut communiquer avec le backend
- [ ] Les requêtes API fonctionnent

### 5. Test Mobile (optionnel - 10 minutes)
- [ ] L'application mobile compile
- [ ] L'app se lance sur émulateur

---

## 📋 Tests Détaillés

## Test 1 : Vérification GitHub

### A. Vérifier que les repositories existent

Visitez chaque URL et vérifiez que le repository contient les fichiers :

**Frontend** : https://github.com/YousOuazizi/parkshare-frontend
```
Fichiers attendus :
✓ src/
✓ package.json
✓ angular.json
✓ README.md
✓ MONOREPO.md
✓ DEVELOPMENT_GUIDE.md
```

**Backend** : https://github.com/YousOuazizi/parkshare-backend
```
Fichiers attendus :
✓ src/
✓ package.json
✓ nest-cli.json
✓ README.md
✓ MONOREPO.md
✓ SECURITY.md
```

**Mobile** : https://github.com/YousOuazizi/parkshare-mobile
```
Fichiers attendus :
✓ lib/
✓ pubspec.yaml
✓ README.md
✓ MONOREPO.md
```

**Ops** : https://github.com/YousOuazizi/parkshare-ops
```
Fichiers attendus :
✓ docker/
✓ docker-compose.dev.yml
✓ README.md
✓ GITHUB_SETUP.md
✓ SETUP_COMPLETE.md
```

### B. Test de clonage (optionnel)

Si vous voulez tester le clonage frais :

```bash
# Créer un dossier de test
mkdir /tmp/parkshare-test
cd /tmp/parkshare-test

# Cloner le frontend
git clone https://github.com/YousOuazizi/parkshare-frontend.git
cd parkshare-frontend
ls -la  # Vérifier que les fichiers sont présents

# Si OK, supprimer le test
cd /tmp
rm -rf parkshare-test
```

**✅ Résultat attendu** : Le repository se clone sans erreur et contient tous les fichiers

---

## Test 2 : Backend Fonctionnel

### A. Démarrer le backend

```bash
cd /home/user/parkshare-monorepo/parkshare-backend

# Vérifier que node_modules existe
ls -ld node_modules

# Si pas installé :
# npm install --legacy-peer-deps

# Démarrer le backend
npm run start:dev
```

**✅ Résultat attendu** :
```
[Nest] 12345  - LOG [NestFactory] Starting Nest application...
[Nest] 12345  - LOG [InstanceLoader] AppModule dependencies initialized
[Nest] 12345  - LOG [NestApplication] Nest application successfully started
```

### B. Tester l'API

Dans un autre terminal :

```bash
# Test 1 : Health check
curl http://localhost:3000/health

# Résultat attendu : {"status":"ok"}

# Test 2 : API principale
curl http://localhost:3000/api

# Résultat attendu : HTML Swagger UI

# Test 3 : Endpoint spécifique (optionnel)
curl http://localhost:3000/api/auth/health
```

### C. Vérifier Swagger UI

Ouvrez dans votre navigateur : **http://localhost:3000/api**

**✅ Résultat attendu** : Interface Swagger avec tous les endpoints API

### D. Arrêter le backend

Retournez au terminal du backend et faites `Ctrl+C`

---

## Test 3 : Frontend Fonctionnel

### A. Démarrer le frontend

```bash
cd /home/user/parkshare-monorepo/parkshare-frontend

# Vérifier que node_modules existe
ls -ld node_modules

# Si pas installé :
# npm install --legacy-peer-deps

# Démarrer le frontend
npm start
```

**✅ Résultat attendu** :
```
** Angular Live Development Server is listening on localhost:4200 **
✔ Browser application bundle generation complete.
```

### B. Tester dans le navigateur

Ouvrez : **http://localhost:4200**

**✅ Résultat attendu** :
- La page d'accueil ParkShare s'affiche
- Le thème teal/orange est visible
- Pas d'erreurs dans la console du navigateur (F12)

### C. Vérifier les pages principales

Naviguez vers :
- http://localhost:4200 - Page d'accueil
- http://localhost:4200/parkings - Liste des parkings
- http://localhost:4200/auth/login - Page de connexion

**✅ Résultat attendu** : Toutes les pages se chargent sans erreur 404

### D. Arrêter le frontend

Retournez au terminal du frontend et faites `Ctrl+C`

---

## Test 4 : Connexion Frontend ↔ Backend

### A. Démarrer les deux services

**Terminal 1 - Backend** :
```bash
cd /home/user/parkshare-monorepo/parkshare-backend
npm run start:dev
```

Attendez que le backend démarre complètement.

**Terminal 2 - Frontend** :
```bash
cd /home/user/parkshare-monorepo/parkshare-frontend
npm start
```

### B. Tester la communication

1. Ouvrez http://localhost:4200 dans votre navigateur
2. Ouvrez la console développeur (F12)
3. Allez sur l'onglet Network
4. Naviguez vers http://localhost:4200/parkings

**✅ Résultat attendu** :
- Dans Network, vous voyez des requêtes vers `http://localhost:3000/api/...`
- Les requêtes retournent 200 OK (ou 401 si pas authentifié - c'est normal)
- Pas d'erreurs CORS

### C. Test de login (optionnel)

Si vous avez une base de données configurée :

1. Allez sur http://localhost:4200/auth/login
2. Essayez de vous connecter
3. Vérifiez dans la console Network que la requête part vers le backend

### D. Arrêter les services

Faites `Ctrl+C` dans les deux terminaux

---

## Test 5 : Mobile (Optionnel)

### A. Vérifier Flutter

```bash
flutter doctor
```

**✅ Résultat attendu** : Au moins un ✓ pour un device (Android/iOS)

### B. Installer les dépendances

```bash
cd /home/user/parkshare-monorepo/parkshare-mobile
flutter pub get
```

**✅ Résultat attendu** :
```
Running "flutter pub get" in parkshare-mobile...
Resolving dependencies...
Got dependencies!
```

### C. Lancer l'app (avec émulateur)

```bash
# Lister les devices disponibles
flutter devices

# Lancer l'app
flutter run
```

**✅ Résultat attendu** : L'app se compile et se lance sur l'émulateur

---

## Test 6 : Docker Compose (Optionnel)

### A. Démarrer avec Docker

```bash
cd /home/user/parkshare-monorepo/parkshare-ops
docker-compose -f docker-compose.dev.yml up
```

**✅ Résultat attendu** :
- PostgreSQL démarre
- Redis démarre
- Backend démarre et se connecte à PostgreSQL
- Frontend démarre

### B. Vérifier les services

```bash
# Dans un autre terminal
docker-compose -f docker-compose.dev.yml ps
```

**✅ Résultat attendu** : Tous les services sont "Up"

### C. Arrêter Docker

```bash
docker-compose -f docker-compose.dev.yml down
```

---

## 🚨 Troubleshooting

### Problème : Backend ne démarre pas

**Erreur** : `Cannot find module ...`
```bash
cd parkshare-backend
rm -rf node_modules package-lock.json
npm install --legacy-peer-deps
```

**Erreur** : `Port 3000 already in use`
```bash
# Trouver le processus
lsof -ti:3000
# Tuer le processus
kill -9 $(lsof -ti:3000)
```

### Problème : Frontend ne démarre pas

**Erreur** : Dépendances manquantes
```bash
cd parkshare-frontend
rm -rf node_modules package-lock.json
npm install --legacy-peer-deps
```

**Erreur** : `Port 4200 already in use`
```bash
kill -9 $(lsof -ti:4200)
```

### Problème : Erreur CORS

Le frontend ne peut pas communiquer avec le backend.

**Solution** : Vérifiez dans `parkshare-backend/src/main.ts` :
```typescript
app.enableCors({
  origin: 'http://localhost:4200',
  credentials: true,
});
```

### Problème : Base de données

**Erreur** : `ECONNREFUSED` PostgreSQL
```bash
# Vérifier que PostgreSQL tourne
sudo systemctl status postgresql
# Ou avec Docker
docker-compose -f docker-compose.dev.yml up -d postgres
```

---

## ✅ Résumé du Test Complet

Si tous ces tests passent, votre monorepo est **100% fonctionnel** :

- ✅ GitHub : 4 repositories configurés et accessibles
- ✅ Backend : API NestJS démarre et répond
- ✅ Frontend : Angular démarre et affiche l'interface
- ✅ Communication : Frontend ↔ Backend fonctionne
- ✅ Mobile : Compile et se lance (optionnel)
- ✅ Docker : Stack complète démarre (optionnel)

---

## 🎯 Test Rapide (2 minutes)

Si vous voulez juste vérifier rapidement :

```bash
# Terminal 1
cd /home/user/parkshare-monorepo/parkshare-backend && npm run start:dev

# Terminal 2 (après que le backend démarre)
cd /home/user/parkshare-monorepo/parkshare-frontend && npm start

# Puis ouvrez http://localhost:4200 dans votre navigateur
```

**✅ Si la page s'affiche = tout fonctionne !**

---

## 📊 Script de Test Automatique

Pour un test automatisé, voir `test-monorepo.sh`
