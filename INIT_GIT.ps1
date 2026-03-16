# ================================================================
# SCRIPT D'INITIALISATION GIT — Maître Denis VOYANT
# Double-cliquez sur ce fichier pour l'exécuter
# ================================================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  INIT GIT — Site Maître Denis VOYANT" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Se placer dans le bon dossier
$folder = "C:\Users\HP\Desktop\Dossier Denis Voyant"
Set-Location $folder

Write-Host "✔ Dossier : $folder" -ForegroundColor Green

# Vérifier que git est installé
try {
    $gitVersion = git --version
    Write-Host "✔ Git détecté : $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "✘ Git n'est pas installé !" -ForegroundColor Red
    Write-Host "  Téléchargez Git ici : https://git-scm.com/download/win" -ForegroundColor Yellow
    pause
    exit
}

# Initialiser le dépôt Git
Write-Host ""
Write-Host "→ Initialisation du dépôt Git..." -ForegroundColor Yellow
git init
git checkout -b main 2>$null
if ($LASTEXITCODE -ne 0) { git branch -m main }

Write-Host "✔ Dépôt Git initialisé (branche main)" -ForegroundColor Green

# Configurer l'auteur si pas déjà fait
$userName = git config user.name
$userEmail = git config user.email
if (-not $userName) {
    git config user.name "Denis Voyant"
    git config user.email "denis.voyant@avocat2conseil.fr"
    Write-Host "✔ Auteur Git configuré" -ForegroundColor Green
}

# Créer .gitignore
$gitignore = @"
# Fichiers système Windows
Thumbs.db
desktop.ini
*.lnk

# macOS
.DS_Store

# Éditeurs
.vscode/
*.swp
*.swo

# Logs
*.log
"@
Set-Content -Path ".gitignore" -Value $gitignore -Encoding UTF8
Write-Host "✔ .gitignore créé" -ForegroundColor Green

# Premier commit
Write-Host ""
Write-Host "→ Ajout des fichiers..." -ForegroundColor Yellow
git add .
Write-Host "✔ Fichiers ajoutés" -ForegroundColor Green

Write-Host "→ Premier commit..." -ForegroundColor Yellow
git commit -m "🚀 Lancement site Maître Denis VOYANT - Avocat Avignon"
Write-Host "✔ Commit effectué !" -ForegroundColor Green

# Demander l'URL du remote GitHub
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CONNEXION À GITHUB (optionnel)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Si vous avez déjà un dépôt GitHub créé pour ce site," -ForegroundColor White
Write-Host "entrez son URL ci-dessous (ex: https://github.com/votre-user/nom-repo.git)" -ForegroundColor White
Write-Host "Ou appuyez sur ENTRÉE pour passer cette étape." -ForegroundColor Gray
Write-Host ""
$remoteUrl = Read-Host "URL GitHub"

if ($remoteUrl -ne "") {
    Write-Host ""
    Write-Host "→ Connexion à GitHub..." -ForegroundColor Yellow
    git remote add origin $remoteUrl
    Write-Host "→ Push vers GitHub..." -ForegroundColor Yellow
    git push -u origin main
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✔ Site pushé sur GitHub avec succès !" -ForegroundColor Green
        Write-Host "  Netlify va détecter le push et déployer automatiquement." -ForegroundColor Cyan
    } else {
        Write-Host "✘ Erreur lors du push." -ForegroundColor Red
        Write-Host "  Vérifiez l'URL et vos identifiants GitHub." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "  Commandes manuelles à relancer :" -ForegroundColor White
        Write-Host "  git remote add origin <URL>" -ForegroundColor Gray
        Write-Host "  git push -u origin main" -ForegroundColor Gray
    }
} else {
    Write-Host ""
    Write-Host "Étape GitHub ignorée." -ForegroundColor Gray
    Write-Host ""
    Write-Host "Quand vous êtes prêt, exécutez manuellement :" -ForegroundColor White
    Write-Host "  cd `"$folder`"" -ForegroundColor Cyan
    Write-Host "  git remote add origin https://github.com/VOTRE-USER/VOTRE-REPO.git" -ForegroundColor Cyan
    Write-Host "  git push -u origin main" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  TERMINÉ !" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
pause
