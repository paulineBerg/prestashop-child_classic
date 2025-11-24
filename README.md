# Thème enfant “child_classic”

Thème enfant du `classic`, mais utilisé comme fork complet (assets et gabarits propres).

## Identité & configuration
- Parent : `classic`
- Nom d’affichage : `Child theme of classic's theme v2.1.3`
- Version : `1.0.0`
- `config/theme.yml` : `use_parent_assets: false`, enregistre deux JS globaux (`keep-filters-position.js`, `filter-modal.js`).
- Préviews : `config/preview.png`, `config/preview-tablet.png`, `config/preview-mobile.png`.

## Assets front
- CSS : `assets/css/custom.css` introduit une charte complète (tokens couleurs or/bleu, typographie Poppins + Cormorant, ombres, arrondis, header sticky mobile).
- JS :
  - `assets/js/keep-filters-position.js` : mémorise le scroll/top de liste après interaction filtres/recherche (sessionStorage, écoute des événements prestashop `updatedProductList`, etc.).
  - `assets/js/filter-modal.js` : modale filtres avec verrouillage body, focus trap, gestion clavier (Escape/Tab) et restauration du focus déclencheur.
  - `assets/js/Classictheme.js` : bundle compilé incluant responsive swap desktop/mobile, comportements checkout, quickview, TouchSpin, Velocity animations, etc. (hérité/ajusté depuis classic).

### `assets/css/custom.css`
Fichier unique (~5 000 lignes) qui remplace l’intégralité du design parent : il pose des tokens (palette or/bleu, typographies Poppins/Cormorant, rayons, ombres) puis redéfinit les styles de base, boutons/flags (dégradés, ombres, états désactivés), header fixé avec double rangée et bannière animée, sections Hero/listing, cartes produit (`.product-miniature`, badges, quick-view) et éléments de formulaire. Il contient aussi tout le système filtres : modale responsive `filters-modal`, inline filters desktop, scrollbar custom, boutons “effacer”, badges actifs, ainsi que les modales métiers (`avant-lock-modal`). Les dernières sections gèrent les breakpoints, grilles (3/4 colonnes, carrousels), blocs CMS, checkout et animations utilitaires, d’où la nécessité de traiter ce fichier comme la source de vérité visuelle du thème.

## Templates overrides (31 fichiers)
- Layout/global : `_partials/head.tpl`, `_partials/header.tpl` (logo + nav empilées, bannière fallback), `_partials/footer.tpl`, `_partials/stylesheets.tpl`, `_partials/pagination.tpl`, `layouts/layout-both-columns.tpl`, `page.tpl`, `errors/not-found.tpl`.
- Catalog : `catalog/product.tpl`, `catalog/listing/*` (category, search, manufacturer, supplier, best-sales, prices-drop, new-products), `catalog/listing/product-list.tpl`, partials `sort-orders.tpl`, `products-top.tpl`, `filters-modal.tpl`, `category-header.tpl`, `category-footer.tpl`, `products.tpl`.
- Microdata : `_partials/microdata/*` (breadcrumb, product, product-list, head JSON‑LD).
- Formulaires : `customer/_partials/customer-form.tpl`.

## Overrides de modules (thème)
- `ps_customersignin/ps_customersignin.tpl`
- `ps_searchbar/ps_searchbar.tpl`
- `ps_customtext/ps_customtext.tpl`
- `ps_contactinfo/nav.tpl`
- `ps_shoppingcart/ps_shoppingcart.tpl`

## Points notables
- Menu mobile custom avec breadcrumbs, recherche et contact ré-injectés dynamiquement, ARIA gérés dans le toggle.
- Bannière header fallback (livraison offerte) si le hook `displayBanner` est vide.
- Assets parents non chargés : toute régression CSS/JS doit être corrigée ici, pas en upstream classic.
- Mode “avant-première” : lorsque `$avantLock` est actif, les listings et vignettes marquées `data-avant-lock` ouvrent une modale membre (`avant-lock-modal`) qui bloque l’accès aux produits avant connexion/inscription (JS inline dans `catalog/listing/category.tpl` et `catalog/_partials/miniatures/product.tpl`, styles dans `assets/css/custom.css`). La détection se fait soit via le flag produit `avant_premiere`, soit via l’appartenance à la catégorie AvantPremiere (ID 26), y compris sur l’accueil/nouveautés.
- Fidélisation : sur la page de confirmation de commande, un client connecté est automatiquement ajouté au groupe “Client avec achat” (ID 5) dès sa première commande (`templates/checkout/order-confirmation.tpl`).

## Entretien
- Nettoyer `themes/child_classic/assets/cache` et `var/cache` après modifications d’assets ou de templates.
- Les JS front sont en ES5 compilé : modifier les sources originales si disponibles avant de re-bundler.
