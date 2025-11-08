# PrestaShop Child Theme: child_classic

This theme is a child theme of the default PrestaShop `classic` theme.
However, it is a heavily customized version and not a simple child theme.

## Key Characteristics

*   **Parent Theme**: `classic`
*   **Display Name**: `Child theme of classic's theme v2.1.3`
*   **Version**: `1.0.0`

## Assets (CSS, JavaScript)

A major characteristic of this theme is that it **does not use the parent theme's assets**.
It provides its own set of CSS and JavaScript files, which means it has a significantly different visual presentation and functionality compared to the `classic` theme.

### Custom JavaScript

This theme includes the following custom JavaScript files:

*   `assets/js/keep-filters-position.js`: This script likely enhances the user experience on category pages by preserving the scroll position or state of filters when a page is reloaded or filters are applied.
*   `assets/js/Classictheme.js`: This might be a customized version of the parent theme's main JavaScript file.

### Custom CSS

Custom styles are likely located in:

*   `assets/css/custom.css`

## Template Overrides

This theme overrides a large number of template files, indicating significant changes to the structure and layout of the store.
The overridden templates include:

*   **Layouts**: `_partials/header.tpl`, `_partials/footer.tpl`, `_partials/head.tpl`, `layouts/layout-both-columns.tpl`
*   **Catalog**: `catalog/listing/product-list.tpl`, `catalog/listing/category.tpl`, `catalog/product.tpl`
*   **Partials**: Many partials are overridden, affecting various parts of the site.

## Summary

This `child_classic` theme is a comprehensive overhaul of the `classic` theme, not a simple customization. It replaces the entire asset pipeline and overrides most of the important templates. It should be treated as a standalone theme for development purposes.

## 📌 Workflow Git (WSL + VS Code)

### Publier une modification (local → GitHub)
```bash
git status                 # voir les changements
git add -A                 # stage (ou: git add chemin/vers/fichier)
git commit -m "Message clair: ce que tu as changé"
git push                   # envoie sur origin/main

git pull --rebase          # récupère et réapplique proprement tes commits

git switch -c fix/nom      # créer et basculer sur une nouvelle branche
git log --oneline -n 10    # voir l'historique compact
git restore --staged f     # retirer "f" du stage si ajouté par erreur
git checkout -- f          # annuler modifications locales de "f"

