# 🔐 Configuration des Secrets GitHub Actions - ParkShare

Ce guide vous aide à configurer tous les secrets nécessaires pour les GitHub Actions.

## 📋 Secrets Requis par Repository

### 🎯 parkshare-mobile
Repository : https://github.com/YousOuazizi/parkshare-mobile

| Secret Name | Description | Requis |
|------------|-------------|--------|
| `CODECOV_TOKEN` | Token pour upload de coverage vers Codecov | ✅ Oui |
| `DOCKER_USERNAME` | Nom d'utilisateur Docker Hub | ✅ Oui |
| `DOCKER_PASSWORD` | Token d'accès Docker Hub | ✅ Oui |

### 🎯 parkshare-frontend
Repository : https://github.com/YousOuazizi/parkshare-frontend

| Secret Name | Description | Requis |
|------------|-------------|--------|
| `CODECOV_TOKEN` | Token pour upload de coverage vers Codecov | ✅ Oui |
| `DOCKER_USERNAME` | Nom d'utilisateur Docker Hub | ✅ Oui |
| `DOCKER_PASSWORD` | Token d'accès Docker Hub | ✅ Oui |

### 🎯 parkshare-backend
Repository : https://github.com/YousOuazizi/parkshare-backend

| Secret Name | Description | Requis |
|------------|-------------|--------|
| `CODECOV_TOKEN` | Token pour upload de coverage vers Codecov | ✅ Oui |
| `DOCKER_USERNAME` | Nom d'utilisateur Docker Hub | ✅ Oui |
| `DOCKER_PASSWORD` | Token d'accès Docker Hub | ✅ Oui |

### 🎯 parkshare-ops
Repository : https://github.com/YousOuazizi/parkshare-ops

| Secret Name | Description | Requis |
|------------|-------------|--------|
| `DOCKER_USERNAME` | Nom d'utilisateur Docker Hub | ✅ Oui |
| `DOCKER_PASSWORD` | Token d'accès Docker Hub | ✅ Oui |

---

## 🚀 Méthode 1 : Configuration Manuelle (Interface Web)

### Étapes pour chaque repository :

1. **Allez sur le repository GitHub**
   ```
   https://github.com/YousOuazizi/[REPO_NAME]
   ```

2. **Ouvrez les Settings**
   - Cliquez sur `Settings` (onglet en haut à droite)

3. **Accédez aux Secrets**
   - Dans le menu de gauche, développez `Secrets and variables`
   - Cliquez sur `Actions`

4. **Ajoutez un nouveau secret**
   - Cliquez sur le bouton vert `New repository secret`
   - **Name** : Entrez le nom exact du secret (ex: `CODECOV_TOKEN`)
   - **Secret** : Collez la valeur correspondante
   - Cliquez sur `Add secret`

5. **Répétez pour tous les secrets**
   - Consultez les valeurs dans le fichier local `SECRETS_VALUES.txt`

### 📝 Où trouver les valeurs des secrets ?

Les valeurs des secrets ont été fournies séparément pour des raisons de sécurité.
Consultez le fichier `SECRETS_VALUES.txt` (non versionné).

---

## 🤖 Méthode 2 : Configuration Automatique (gh CLI)

Si vous avez GitHub CLI installé :

### Installation de gh CLI

```bash
# Ubuntu/Debian
sudo apt install gh

# macOS
brew install gh

# Windows
winget install --id GitHub.cli

# Authentification
gh auth login
```

### Configuration automatique

Créez un fichier `secrets.env` avec vos valeurs :

```bash
# secrets.env (NE PAS COMMIT CE FICHIER)
export CODECOV_MOBILE="votre-token-codecov-mobile"
export CODECOV_FRONTEND="votre-token-codecov-frontend"
export CODECOV_BACKEND="votre-token-codecov-backend"
export DOCKER_USERNAME="votre-username-docker"
export DOCKER_PASSWORD="votre-token-docker"
```

Puis lancez :

```bash
# Charger les variables
source secrets.env

# Configuration parkshare-mobile
gh secret set CODECOV_TOKEN -b "$CODECOV_MOBILE" -R YousOuazizi/parkshare-mobile
gh secret set DOCKER_USERNAME -b "$DOCKER_USERNAME" -R YousOuazizi/parkshare-mobile
gh secret set DOCKER_PASSWORD -b "$DOCKER_PASSWORD" -R YousOuazizi/parkshare-mobile

# Configuration parkshare-frontend
gh secret set CODECOV_TOKEN -b "$CODECOV_FRONTEND" -R YousOuazizi/parkshare-frontend
gh secret set DOCKER_USERNAME -b "$DOCKER_USERNAME" -R YousOuazizi/parkshare-frontend
gh secret set DOCKER_PASSWORD -b "$DOCKER_PASSWORD" -R YousOuazizi/parkshare-frontend

# Configuration parkshare-backend
gh secret set CODECOV_TOKEN -b "$CODECOV_BACKEND" -R YousOuazizi/parkshare-backend
gh secret set DOCKER_USERNAME -b "$DOCKER_USERNAME" -R YousOuazizi/parkshare-backend
gh secret set DOCKER_PASSWORD -b "$DOCKER_PASSWORD" -R YousOuazizi/parkshare-backend

# Configuration parkshare-ops
gh secret set DOCKER_USERNAME -b "$DOCKER_USERNAME" -R YousOuazizi/parkshare-ops
gh secret set DOCKER_PASSWORD -b "$DOCKER_PASSWORD" -R YousOuazizi/parkshare-ops

echo "✅ Tous les secrets ont été configurés !"
```

---

## 🔍 Génération des Tokens

### Codecov Token

1. Allez sur https://codecov.io/
2. Connectez-vous avec GitHub
3. Ajoutez chaque repository (frontend, backend, mobile)
4. Copiez le token pour chaque repo

### Docker Hub Token

1. Allez sur https://hub.docker.com/settings/security
2. Cliquez sur `New Access Token`
3. Nom : `parkshare-github-actions`
4. Permissions : `Read, Write, Delete`
5. Copiez le token généré

---

## ✅ Vérification des Secrets

### Via l'interface web :
1. Allez sur `Settings` → `Secrets and variables` → `Actions`
2. Vous devriez voir la liste des secrets (les valeurs sont masquées)

### Via gh CLI :
```bash
gh secret list -R YousOuazizi/parkshare-mobile
gh secret list -R YousOuazizi/parkshare-frontend
gh secret list -R YousOuazizi/parkshare-backend
gh secret list -R YousOuazizi/parkshare-ops
```

### Résultat attendu pour chaque repo :
```
NAME              UPDATED
CODECOV_TOKEN     about X hours ago
DOCKER_PASSWORD   about X hours ago
DOCKER_USERNAME   about X hours ago
```

---

## 🧪 Test des Secrets

### 1. Déclencher un workflow manuellement

1. Allez dans l'onglet `Actions` du repository
2. Sélectionnez un workflow (ex: `CI/CD Pipeline`)
3. Cliquez sur `Run workflow`
4. Sélectionnez la branche `main`
5. Cliquez sur `Run workflow`

### 2. Vérifier les logs

- Les secrets ne s'affichent jamais dans les logs (remplacés par `***`)
- Vérifiez que ces étapes passent :
  - ✅ `Upload coverage reports` (Codecov)
  - ✅ `Docker build and push` (Docker Hub)

### 3. Push de test

```bash
cd /home/user/parkshare-monorepo/parkshare-backend

# Commit vide pour tester
git commit --allow-empty -m "test: Trigger CI with configured secrets"
git push origin main

# Vérifier : https://github.com/YousOuazizi/parkshare-backend/actions
```

---

## ⚠️ Sécurité des Secrets

### ✅ Bonnes Pratiques

- ✅ Les secrets sont chiffrés par GitHub
- ✅ Ils ne s'affichent jamais dans les logs
- ✅ Seuls les workflows du repository peuvent y accéder
- ✅ Les collaborateurs ne peuvent pas lire les valeurs

### 🚨 Important

- **NE JAMAIS** commit les secrets dans le code
- **NE JAMAIS** afficher les secrets dans les logs
- **TOUJOURS** utiliser `${{ secrets.SECRET_NAME }}` dans les workflows
- **AJOUTER** `secrets.env` et `SECRETS_VALUES.txt` au `.gitignore`

### 📄 .gitignore recommandé

```gitignore
# Secrets
secrets.env
SECRETS_VALUES.txt
*.secret
*.token

# Environment
.env
.env.local
.env.*.local
```

---

## 📊 Impact des Secrets sur les Workflows

### Sans les secrets :
```
⚠️  Upload coverage - SKIPPED (no CODECOV_TOKEN)
⚠️  Docker push - SKIPPED (no DOCKER credentials)
✅  Tests - OK
✅  Build - OK
```

### Avec les secrets :
```
✅  Upload coverage - OK (envoyé vers Codecov)
✅  Docker push - OK (image publiée sur Docker Hub)
✅  Tests - OK
✅  Build - OK
```

---

## 🎯 Checklist de Configuration

### parkshare-mobile
- [ ] CODECOV_TOKEN configuré
- [ ] DOCKER_USERNAME configuré
- [ ] DOCKER_PASSWORD configuré
- [ ] Test workflow réussi

### parkshare-frontend
- [ ] CODECOV_TOKEN configuré
- [ ] DOCKER_USERNAME configuré
- [ ] DOCKER_PASSWORD configuré
- [ ] Test workflow réussi

### parkshare-backend
- [ ] CODECOV_TOKEN configuré
- [ ] DOCKER_USERNAME configuré
- [ ] DOCKER_PASSWORD configuré
- [ ] Test workflow réussi

### parkshare-ops
- [ ] DOCKER_USERNAME configuré
- [ ] DOCKER_PASSWORD configuré
- [ ] Test workflow réussi

---

## 📞 Support

### Problèmes courants

**Erreur : "Secret not found"**
- Vérifiez l'orthographe exacte du nom
- Vérifiez que le secret existe dans le bon repository

**Erreur : "Bad credentials" (Docker)**
- Vérifiez que le token Docker est valide
- Régénérez un nouveau token si nécessaire

**Erreur : "HTTP 401" (Codecov)**
- Vérifiez que le repository est ajouté sur Codecov
- Régénérez le token Codecov

### Test des credentials

```bash
# Test Docker login
echo "VOTRE_DOCKER_TOKEN" | docker login -u VOTRE_USERNAME --password-stdin

# Test Codecov (curl)
curl -X POST --data-binary @coverage/lcov.info \
  -H "Authorization: bearer VOTRE_CODECOV_TOKEN" \
  https://codecov.io/upload/v4
```

---

## ✅ Résumé

**Total de secrets à configurer : 10**

- parkshare-mobile : 3 secrets
- parkshare-frontend : 3 secrets
- parkshare-backend : 3 secrets
- parkshare-ops : 2 secrets

**Temps estimé :**
- Méthode manuelle : 10-15 minutes
- Avec gh CLI : 2-3 minutes

**Une fois configurés, les workflows GitHub Actions seront 100% fonctionnels !** 🎉
