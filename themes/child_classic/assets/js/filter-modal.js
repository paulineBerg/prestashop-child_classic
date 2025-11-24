(() => {
  const ACTIVE_CLASS = 'filters-modal--active';
  const BODY_LOCK_CLASS = 'filters-modal-open';
  const SELECTORS = {
    modal: '#filters-modal',
    open: '.js-open-filter-modal',
    close: '.js-close-filter-modal',
  };
  const TRIGGER_CAPTURE = true;
  const FOCUSABLE_SELECTOR = [
    'a[href]',
    'button:not([disabled])',
    'input:not([disabled]):not([type="hidden"])',
    'select:not([disabled])',
    'textarea:not([disabled])',
    '[tabindex]:not([tabindex="-1"])',
  ].join(',');

  const state = {
    modal: null,
    lastFocused: null,
    listenersAttached: false,
  };

  const ready = (callback) => {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', callback, { once: true });
    } else {
      callback();
    }
  };

  const forEachNode = (nodes, iteratee) => {
    if (!nodes || typeof iteratee !== 'function') {
      return;
    }
    Array.prototype.forEach.call(nodes, iteratee);
  };

  const isElement = (node) => {
    if (typeof Element === 'undefined') {
      return !!node && node.nodeType === 1;
    }
    return node instanceof Element;
  };

  const getModal = () => {
    const modal = document.querySelector(SELECTORS.modal);
    state.modal = modal || null;
    return state.modal;
  };

  const ensureModal = () => {
    if (state.modal && document.body.contains(state.modal)) {
      return state.modal;
    }
    return getModal();
  };

  const lockBody = (lock) => {
    document.body.classList.toggle(BODY_LOCK_CLASS, !!lock);
  };

  const setAriaHidden = (modal, hidden) => {
    modal.setAttribute('aria-hidden', hidden ? 'true' : 'false');
  };

  const focusFirstElement = (modal) => {
    if (!modal) {
      return;
    }
    const focusable = modal.querySelectorAll(FOCUSABLE_SELECTOR);
    if (focusable.length) {
      try {
        focusable[0].focus({ preventScroll: true });
      } catch (error) {
        focusable[0].focus();
      }
    }
  };

  const restoreFocus = () => {
    if (!state.lastFocused || typeof state.lastFocused.focus !== 'function') {
      return;
    }
    try {
      state.lastFocused.focus({ preventScroll: true });
    } catch (error) {
      state.lastFocused.focus();
    }
    state.lastFocused = null;
  };

  const openModal = (event) => {
    const modal = ensureModal();
    if (!modal) {
      return;
    }
    if (event) {
      event.preventDefault();
    }
    if (document.activeElement && isElement(document.activeElement)) {
      state.lastFocused = document.activeElement;
    }
    modal.classList.add(ACTIVE_CLASS);
    setAriaHidden(modal, false);
    lockBody(true);
    focusFirstElement(modal);
  };

  const closeModal = (event) => {
    const modal = ensureModal();
    if (!modal) {
      return;
    }
    if (event) {
      event.preventDefault();
    }
    modal.classList.remove(ACTIVE_CLASS);
    setAriaHidden(modal, true);
    lockBody(false);
    restoreFocus();
  };

  const isOpen = () => {
    const modal = ensureModal();
    return !!modal && modal.classList.contains(ACTIVE_CLASS);
  };

  const trapFocus = (event) => {
    const modal = ensureModal();
    if (!modal || event.key !== 'Tab' || !isOpen()) {
      return;
    }
    const focusable = modal.querySelectorAll(FOCUSABLE_SELECTOR);
    if (!focusable.length) {
      return;
    }
    const first = focusable[0];
    const last = focusable[focusable.length - 1];
    const active = document.activeElement;
    if (event.shiftKey && active === first) {
      event.preventDefault();
      last.focus();
    } else if (!event.shiftKey && active === last) {
      event.preventDefault();
      first.focus();
    }
  };

  const handleDocumentClick = (event) => {
    const target = event.target;
    if (!isElement(target)) {
      return;
    }
    if (target.closest(SELECTORS.open)) {
      openModal(event);
      return;
    }
    if (target.closest(SELECTORS.close)) {
      closeModal(event);
    }
  };

  const handleDocumentKeydown = (event) => {
    if (event.key === 'Escape' && isOpen()) {
      closeModal(event);
      return;
    }
    if ((event.key === 'Enter' || event.key === ' ') && isElement(event.target)) {
      const closeTrigger = event.target.closest(SELECTORS.close);
      if (closeTrigger) {
        event.preventDefault();
        closeModal(event);
        return;
      }
    }
    if (event.key === 'Tab') {
      trapFocus(event);
    }
  };

  const handleTriggerClick = (event) => {
    openModal(event);
  };

  const bindTriggerElements = () => {
    const triggers = document.querySelectorAll(SELECTORS.open);
    if (!triggers || !triggers.length) {
      return;
    }
    forEachNode(triggers, (trigger) => {
      trigger.removeEventListener('click', handleTriggerClick, TRIGGER_CAPTURE);
      trigger.addEventListener('click', handleTriggerClick, TRIGGER_CAPTURE);
    });
  };

  const refreshModal = () => {
    const modal = ensureModal();
    if (!modal) {
      bindTriggerElements();
      return null;
    }
    setAriaHidden(modal, !modal.classList.contains(ACTIVE_CLASS));
    bindTriggerElements();
    return modal;
  };

  const attachListeners = () => {
    if (state.listenersAttached) {
      return;
    }
    document.addEventListener('click', handleDocumentClick);
    document.addEventListener('keydown', handleDocumentKeydown);
    state.listenersAttached = true;
  };

  const init = () => {
    if (!refreshModal()) {
      return;
    }
    attachListeners();
  };

  const subscribeToPrestashop = () => {
    if (!window.prestashop || typeof window.prestashop.on !== 'function') {
      return;
    }
    ['updatedProductList', 'updateProductList', 'updatedFacets', 'updateFacets', 'facet:updated'].forEach(
      (eventName) => {
        try {
          window.prestashop.on(eventName, () => {
            refreshModal();
          });
        } catch (error) {
          console.error('[filters-modal] Failed to bind Prestashop event', error);
        }
      },
    );
  };

  ready(() => {
    init();
    subscribeToPrestashop();
  });

  window.BCFilterModal = window.BCFilterModal || {};
  window.BCFilterModal.open = openModal;
  window.BCFilterModal.close = closeModal;
  window.BCFilterModal.refresh = () => {
    refreshModal();
  };
  window.BCFilterModal.init = init;
})();
