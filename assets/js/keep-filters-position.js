document.addEventListener('DOMContentLoaded', () => {
  const SCROLL_OFFSET = 90; // adapte à ton header fixe
  const STORAGE_KEY = 'bcScrollToFilters';

  // Renvoie le bloc des filtres
  function getFiltersEl() {
    return (
      document.querySelector('#search_filters') ||
      document.querySelector('#search_filters_wrapper') ||
      document.querySelector('.facets')
    );
  }

  // Scroll vers les filtres (avec compensation header)
  function doScroll() {
    const el = getFiltersEl();
    if (!el) return false;
    const top = Math.max(0, el.getBoundingClientRect().top + window.scrollY - SCROLL_OFFSET);
    window.scrollTo({ top, behavior: 'instant' });
    return true;
  }

  // Essaie de scroller plusieurs fois pendant que le DOM/grille se stabilise
  function ensureScroll(retries = 20, delay = 50) {
    let attempts = 0;
    const tick = () => {
      attempts++;
      const ok = doScroll();
      if (ok && attempts >= 2) return; // on a scrolé au moins une fois de suite
      if (attempts < retries) setTimeout(() => requestAnimationFrame(tick), delay);
    };
    requestAnimationFrame(tick);
  }

  // Marqueur de clic filtre
  function armScrollFlag() {
    try { sessionStorage.setItem(STORAGE_KEY, '1'); } catch(e) {}
  }

  // 1) Intercepter TOUT ce qui déclenche un filtrage/pagination dans le bloc filtres
  const filtersRoot = getFiltersEl();
  if (filtersRoot) {
    filtersRoot.addEventListener('click', (e) => {
      const t = e.target;
      if (!t) return;
      if (t.closest('a, button, label')) armScrollFlag();
    }, true);

    filtersRoot.addEventListener('change', (e) => {
      const t = e.target;
      if (!t) return;
      if (['INPUT','SELECT'].includes(t.tagName)) armScrollFlag();
    }, true);

    // Certains modules soumettent des formulaires
    filtersRoot.addEventListener('submit', () => armScrollFlag(), true);
  }

  // 2) Après mise à jour AJAX (toutes variantes d’événements)
  if (window.prestashop && typeof window.prestashop.on === 'function') {
    [
      'updatedProductList', 'updateProductList',
      'updatedFacets', 'updateFacets',
      'facet:updated'
    ].forEach(evt => {
      try {
        window.prestashop.on(evt, () => {
          const flagged = sessionStorage.getItem(STORAGE_KEY) === '1';
          if (flagged || location.search.includes('q=')) ensureScroll();
          // on conserve le flag tant que l'utilisateur enchaîne des clics
        });
      } catch(e) {}
    });
  }

  // 3) Sur chargement “plein” d’une URL filtrée (?q=...) ou si flag présent
  const flagged = sessionStorage.getItem(STORAGE_KEY) === '1';
  if (flagged || location.search.includes('q=')) {
    // Évite le scroll auto natif du navigateur
    if ('scrollRestoration' in history) history.scrollRestoration = 'manual';
    ensureScroll();
    // On NE supprime PAS immédiatement le flag : si l’utilisateur clique encore un filtre,
    // le repositionnement reste actif. Tu peux décommenter la ligne suivante si tu préfères :
    // sessionStorage.removeItem(STORAGE_KEY);
  }
});
