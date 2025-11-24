document.addEventListener('DOMContentLoaded', () => {
  const SCROLL_OFFSET = 90;
  const STORAGE_KEY = 'bcScrollToProductListTop';
  const LEGACY_KEYS = ['bcScrollToFilters'];
  const SCROLL_TARGET_SELECTORS = [
    '#js-product-list-top',
    '#product-list-top',
    '#products-top',
    '#search_filters',
    '#search_filters_wrapper',
    '.facets',
  ];
  const TRIGGER_SELECTORS = [
    '#js-product-list-top',
    '#filters-modal',
    '#search_filters',
    '#search_filters_wrapper',
    '.facets',
  ];
  const PRESTASHOP_EVENTS = [
    'updatedProductList',
    'updateProductList',
    'updatedFacets',
    'updateFacets',
    'facet:updated',
  ];
  const INTERACTIVE_TRIGGER_SELECTOR = 'a, button, label, input, select, textarea';

  const state = {
    triggerRoots: new WeakSet(),
    searchForms: new WeakSet(),
  };

  function cleanupLegacyKeys() {
    LEGACY_KEYS.forEach((key) => {
      try {
        sessionStorage.removeItem(key);
      } catch (error) {}
    });
  }

  function getScrollTarget() {
    for (const selector of SCROLL_TARGET_SELECTORS) {
      const node = document.querySelector(selector);
      if (node) {
        return node;
      }
    }
    return null;
  }

  function scrollToTarget() {
    const target = getScrollTarget();
    if (!target) {
      return false;
    }
    const top = Math.max(0, target.getBoundingClientRect().top + window.scrollY - SCROLL_OFFSET);
    try {
      window.scrollTo({ top, behavior: 'instant' });
    } catch (error) {
      window.scrollTo(0, top);
    }
    return true;
  }

  function ensureScroll(retries = 20, delay = 50, shouldClearFlag = true) {
    let attempts = 0;
    const tick = () => {
      attempts += 1;
      const ok = scrollToTarget();
      if (ok && attempts >= 2) {
        if (shouldClearFlag) {
          clearScrollFlag();
        }
        return;
      }
      if (attempts < retries) {
        setTimeout(() => requestAnimationFrame(tick), delay);
      }
    };
    requestAnimationFrame(tick);
  }

  function armScrollFlag() {
    try {
      sessionStorage.setItem(STORAGE_KEY, '1');
    } catch (error) {}
  }

  function clearScrollFlag() {
    try {
      sessionStorage.removeItem(STORAGE_KEY);
    } catch (error) {}
  }

  function hasScrollFlag() {
    try {
      return sessionStorage.getItem(STORAGE_KEY) === '1';
    } catch (error) {
      return false;
    }
  }

  const handleClick = (event) => {
    if (event && event.target && event.target.closest(INTERACTIVE_TRIGGER_SELECTOR)) {
      armScrollFlag();
    }
  };

  const handleChange = (event) => {
    if (event && event.target && event.target.closest('input, select, textarea')) {
      armScrollFlag();
    }
  };

  const handleSubmit = () => {
    armScrollFlag();
  };

  function bindTriggerRoot(root) {
    if (!root || state.triggerRoots.has(root)) {
      return;
    }
    root.addEventListener('click', handleClick, true);
    root.addEventListener('change', handleChange, true);
    root.addEventListener('submit', handleSubmit, true);
    state.triggerRoots.add(root);
  }

  function bindSearchForms() {
    document.querySelectorAll('form input[name="controller"][value="search"]').forEach((input) => {
      if (!input.form || state.searchForms.has(input.form)) {
        return;
      }
      input.form.addEventListener('submit', handleSubmit, true);
      state.searchForms.add(input.form);
    });
  }

  function refreshTriggerBindings() {
    TRIGGER_SELECTORS.forEach((selector) => {
      document.querySelectorAll(selector).forEach(bindTriggerRoot);
    });
    bindSearchForms();
  }

  function hasQueryFilters() {
    const query = window.location.search || '';
    if (query.includes('q=')) {
      return true;
    }
    if (query.includes('controller=search') || query.includes('&s=') || query.startsWith('?s=')) {
      return true;
    }
    return false;
  }

  function shouldScrollOnLoad() {
    return hasScrollFlag() || hasQueryFilters();
  }

  function subscribeToPrestashop() {
    if (!window.prestashop || typeof window.prestashop.on !== 'function') {
      return;
    }
    PRESTASHOP_EVENTS.forEach((eventName) => {
      try {
        window.prestashop.on(eventName, () => {
          refreshTriggerBindings();
          const flagged = hasScrollFlag();
          const hasQuery = hasQueryFilters();
          if (flagged || hasQuery) {
            ensureScroll(20, 50, flagged);
          }
        });
      } catch (error) {}
    });
  }

  cleanupLegacyKeys();
  refreshTriggerBindings();
  subscribeToPrestashop();

  if (shouldScrollOnLoad()) {
    const flagged = hasScrollFlag();
    if ('scrollRestoration' in history) {
      history.scrollRestoration = 'manual';
    }
    ensureScroll(20, 50, flagged);
  }
});
