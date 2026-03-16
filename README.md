# Maître Denis VOYANT — Site Avocat

Site professionnel de Maître Denis VOYANT, Avocat au Barreau d'Avignon.

## Informations

- **Serment** : 26 mai 1989
- **Barreau** : Avignon
- **Adresse** : 9C Avenue Pierre Sémard, 84000 Avignon
- **Téléphone** : 04 32 74 02 71
- **Email** : denis.voyant@avocat2conseil.fr

## Structure du site

```
index.html       — Page principale
css/style.css    — Styles (design luxe judiciaire)
js/main.js       — Interactions & animations
netlify.toml     — Configuration Netlify
images/          — Dossier images (ajouter photo de Maître Voyant)
```

## Fonctionnalités

- Curseur personnalisé doré
- Loader animé (balance de la justice)
- Héro immersif avec compteurs animés
- Bandeau urgence juridique
- 6 cartes expertises avec effet flip 3D
- Section cabinet avec valeurs
- Honoraires (3 formules)
- Formulaire Netlify Forms (anti-spam honeypot)
- Footer complet avec coordonnées

## Photo avocat

Pour ajouter la photo de Maître Voyant, placez une image nommée `avocat.jpg` dans le dossier `images/` et modifiez la section `.cabinet-photo-placeholder` dans `index.html`.

## Déploiement Netlify

Le fichier `netlify.toml` est configuré. Après le push GitHub, Netlify déploie automatiquement.

Le formulaire de contact utilise **Netlify Forms** — activez-le dans le dashboard Netlify sous "Forms".
