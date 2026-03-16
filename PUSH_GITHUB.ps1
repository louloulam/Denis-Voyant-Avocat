# ================================================================
# SCRIPT PUSH GITHUB — Maître Denis VOYANT
# Double-cliquez sur ce fichier pour l'exécuter
# ================================================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  PUSH GITHUB — Site Maître Denis VOYANT" -ForegroundColor Cyan
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

# Initialiser le dépôt si nécessaire
if (-not (Test-Path ".git")) {
    Write-Host ""
    Write-Host "→ Initialisation du dépôt Git..." -ForegroundColor Yellow
    git init
    git checkout -b main 2>$null
    if ($LASTEXITCODE -ne 0) { git branch -m main 2>$null }
    Write-Host "✔ Dépôt Git initialisé" -ForegroundColor Green
} else {
    Write-Host "✔ Dépôt Git déjà initialisé" -ForegroundColor Green
}

# Configurer l'auteur si pas déjà fait
$userName = git config user.name
if (-not $userName) {
    git config user.name "Denis Voyant"
    git config user.email "denis.voyant@avocat2conseil.fr"
    Write-Host "✔ Auteur Git configuré" -ForegroundColor Green
}

# Créer .gitignore si absent
if (-not (Test-Path ".gitignore")) {
    $gitignore = @"
Thumbs.db
desktop.ini
*.lnk
.DS_Store
.vscode/
*.log
INIT_GIT.ps1
"@
    Set-Content -Path ".gitignore" -Value $gitignore -Encoding UTF8
    Write-Host "✔ .gitignore créé" -ForegroundColor Green
}

# Ajouter le remote GitHub (URL fixe)
$remoteUrl = "https://github.com/louloulam/Denis-Voyant-Avocat.git"
$existingRemote = git remote get-url origin 2>$null
if (-not $existingRemote) {
    git remote add origin $remoteUrl
    Write-Host "✔ Remote GitHub configuré : $remoteUrl" -ForegroundColor Green
} else {
    Write-Host "✔ Remote déjà configuré : $existingRemote" -ForegroundColor Green
}

# Ajouter tous les fichiers
Write-Host ""
Write-Host "→ Ajout des fichiers..." -ForegroundColor Yellow
git add .
Write-Host "✔ Fichiers ajoutés" -ForegroundColor Green

# Commit
Write-Host "→ Commit..." -ForegroundColor Yellow
git commit -m "🚀 Site Maître Denis VOYANT - Avocat Avignon"
Write-Host "✔ Commit effectué" -ForegroundColor Green

# Push
Write-Host ""
Write-Host "→ Push vers GitHub (https://github.com/louloulam/Denis-Voyant-Avocat)..." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  ✔ SITE PUSHÉ AVEC SUCCÈS !" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "  GitHub  : https://github.com/louloulam/Denis-Voyant-Avocat" -ForegroundColor Cyan
    Write-Host "  Netlify va déployer automatiquement dans quelques secondes." -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "✘ Erreur lors du push." -ForegroundColor Red
    Write-Host ""
    Write-Host "  Solutions possibles :" -ForegroundColor Yellow
    Write-Host "  1. Vérifiez que le dépôt GitHub existe bien :" -ForegroundColor White
    Write-Host "     https://github.com/louloulam/Denis-Voyant-Avocat" -ForegroundColor Gray
    Write-Host "  2. Si GitHub demande un mot de passe, utilisez un Personal Access Token." -ForegroundColor White
    Write-Host "     Créez-en un ici : https://github.com/settings/tokens" -ForegroundColor Gray
    Write-Host "  3. Si la branche est 'master' au lieu de 'main', tapez :" -ForegroundColor White
    Write-Host "     git push -u origin master" -ForegroundColor Gray
}

Write-Host ""
pause
