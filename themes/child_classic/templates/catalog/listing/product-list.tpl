{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
{extends file=$layout}

{block name='left_column'}{/block}
{block name='right_column'}{/block}

{capture assign='categoryHeaderContent'}
  {hook h="displayHeaderCategory"}
{/capture}

{capture assign='categoryTopColumnContent'}
  {hook h="displayTopColumn"}
{/capture}

{block name='head_microdata_special'}
  {include file='_partials/microdata/product-list-jsonld.tpl' listing=$listing}
{/block}

{block name='content'}
  {include file='_partials/init-grid.tpl'}
  <section id="main">

    {block name='product_list_header'}
      <h1 id="js-product-list-header" class="h2">{$listing.label}</h1>
    {/block}

    {block name='subcategory_list'}
      {if isset($subcategories) && $subcategories|@count > 0}
        {include file='catalog/_partials/subcategories.tpl' subcategories=$subcategories}
      {/if}
    {/block}

    <section id="products" class="plp-products">
      {block name='product_list_top'}
        {if $listing.products|count || !empty($listing.rendered_facets)}
          {include file='catalog/_partials/products-top.tpl' listing=$listing}

          {if $categoryHeaderContent|trim neq ''}
            {$categoryHeaderContent nofilter}
          {/if}

          {if $categoryTopColumnContent|trim neq ''}
            <div class="category-top-filters">
              {$categoryTopColumnContent nofilter}
            </div>
          {/if}

          {include file='catalog/_partials/filters-modal.tpl' listing=$listing}
        {else}
          <div id="js-product-list-top"></div>
        {/if}
      {/block}

      {block name='product_list_active_filters'}
        {if $listing.rendered_active_filters|trim neq ''}
          <div class="product-list-active-filters">
            {$listing.rendered_active_filters nofilter}
          </div>
        {/if}
      {/block}

      {if $listing.products|count}

        {block name='product_list'}
          {if empty($productGridClass)}
            {assign var=productGridClass value='col-xs-12 col-sm-6 col-xl-4'}
          {/if}
          {include file='catalog/_partials/products.tpl' listing=$listing productClass=$productGridClass}
        {/block}

        {block name='product_list_bottom'}
          {include file='catalog/_partials/products-bottom.tpl' listing=$listing}
        {/block}

      {else}
        <div id="js-product-list">
          {capture assign="errorContent"}
            <h4>{l s='No products available yet' d='Shop.Theme.Catalog'}</h4>
            <p>{l s='Stay tuned! More products will be shown here as they are added.' d='Shop.Theme.Catalog'}</p>
          {/capture}

          {include file='errors/not-found.tpl' errorContent=$errorContent}
        </div>

        <div id="js-product-list-bottom"></div>
      {/if}
    </section>

{block name='product_list_footer'}{/block}

{hook h="displayFooterCategory"}

</section>
{/block}

{block name='javascript_bottom' append}
  {if !empty($listing.rendered_facets)}
    {literal}
    <script>
      (function () {
        if (window.__bcFiltersModalInlineInit) {
          return;
        }
        window.__bcFiltersModalInlineInit = true;

        var ACTIVE_CLASS = 'filters-modal--active';
        var BODY_LOCK_CLASS = 'filters-modal-open';
        var SELECTORS = {
          modal: '#filters-modal',
          open: '.js-open-filter-modal',
          close: '.js-close-filter-modal'
        };
        var TRIGGER_CAPTURE = true;
        var FOCUSABLE =
          'a[href], button:not([disabled]), input:not([disabled]):not([type="hidden"]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"])';
        var prestashopEvents = [
          'updatedProductList',
          'updateProductList',
          'updatedFacets',
          'updateFacets',
          'facet:updated'
        ];

        var state = {
          lastFocused: null,
          listenersAttached: false
        };

        function forEachNode(list, iteratee) {
          if (!list || typeof iteratee !== 'function') {
            return;
          }
          Array.prototype.forEach.call(list, iteratee);
        }

        function ready(callback) {
          if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', callback, { once: true });
          } else {
            callback();
          }
        }

        function matchesSelector(element, selector) {
          if (!element || element === document) {
            return false;
          }
          var proto = Element.prototype;
          var fn = proto.matches || proto.msMatchesSelector || proto.webkitMatchesSelector;
          if (!fn) {
            return false;
          }
          return fn.call(element, selector);
        }

        function closest(element, selector) {
          if (!element) {
            return null;
          }
          if (typeof element.closest === 'function') {
            return element.closest(selector);
          }
          var el = element;
          while (el && el.nodeType === 1) {
            if (matchesSelector(el, selector)) {
              return el;
            }
            el = el.parentElement || el.parentNode;
          }
          return null;
        }

        function getModal() {
          return document.querySelector(SELECTORS.modal);
        }

        function lockBody(lock) {
          document.body.classList.toggle(BODY_LOCK_CLASS, !!lock);
        }

        function focusElement(element) {
          if (!element || typeof element.focus !== 'function') {
            return;
          }
          try {
            element.focus({ preventScroll: true });
          } catch (error) {
            element.focus();
          }
        }

        function focusFirst(modal) {
          if (!modal) {
            return;
          }
          var focusable = modal.querySelectorAll(FOCUSABLE);
          if (focusable.length) {
            focusElement(focusable[0]);
          }
        }

        function rememberFocus() {
          var active = document.activeElement;
          if (active && typeof active.focus === 'function') {
            state.lastFocused = active;
          } else {
            state.lastFocused = null;
          }
        }

        function restoreFocus() {
          if (!state.lastFocused || typeof state.lastFocused.focus !== 'function') {
            return;
          }
          focusElement(state.lastFocused);
          state.lastFocused = null;
        }

        function openModal(event) {
          var modal = getModal();
          if (!modal) {
            return;
          }
          if (event) {
            event.preventDefault();
          }
          rememberFocus();
          modal.classList.add(ACTIVE_CLASS);
          modal.setAttribute('aria-hidden', 'false');
          lockBody(true);
          focusFirst(modal);
        }

        function closeModal(event) {
          var modal = getModal();
          if (!modal) {
            return;
          }
          if (event) {
            event.preventDefault();
          }
          modal.classList.remove(ACTIVE_CLASS);
          modal.setAttribute('aria-hidden', 'true');
          lockBody(false);
          restoreFocus();
        }

        function isModalOpen() {
          var modal = getModal();
          return modal && modal.classList.contains(ACTIVE_CLASS);
        }

        function trapFocus(event) {
          if (event.key !== 'Tab' || !isModalOpen()) {
            return;
          }
          var modal = getModal();
          if (!modal) {
            return;
          }
          var focusable = modal.querySelectorAll(FOCUSABLE);
          if (!focusable.length) {
            return;
          }
          var first = focusable[0];
          var last = focusable[focusable.length - 1];
          if (event.shiftKey && document.activeElement === first) {
            event.preventDefault();
            focusElement(last);
          } else if (!event.shiftKey && document.activeElement === last) {
            event.preventDefault();
            focusElement(first);
          }
        }

        function handleDocumentClick(event) {
          var target = event.target;
          if (!target) {
            return;
          }
          if (closest(target, SELECTORS.open)) {
            openModal(event);
            return;
          }
          if (closest(target, SELECTORS.close)) {
            closeModal(event);
          }
        }

        function handleDocumentKeydown(event) {
          if (event.key === 'Escape' && isModalOpen()) {
            closeModal(event);
            return;
          }
          if (event.key === 'Tab') {
            trapFocus(event);
            return;
          }
          if ((event.key === 'Enter' || event.key === ' ' || event.key === 'Spacebar') && closest(event.target, SELECTORS.close)) {
            event.preventDefault();
            closeModal(event);
          }
        }

        function attachListeners() {
          if (state.listenersAttached) {
            return;
          }
          document.addEventListener('click', handleDocumentClick);
          document.addEventListener('keydown', handleDocumentKeydown);
          state.listenersAttached = true;
        }

        function handleTriggerClick(event) {
          openModal(event);
        }

        function bindTriggerElements() {
          var triggers = document.querySelectorAll(SELECTORS.open);
          if (!triggers || !triggers.length) {
            return;
          }
          forEachNode(triggers, function (trigger) {
            trigger.removeEventListener('click', handleTriggerClick, TRIGGER_CAPTURE);
            trigger.addEventListener('click', handleTriggerClick, TRIGGER_CAPTURE);
          });
        }

        function refreshModal() {
          var modal = getModal();
          if (!modal) {
            bindTriggerElements();
            return;
          }
          modal.setAttribute('aria-hidden', modal.classList.contains(ACTIVE_CLASS) ? 'false' : 'true');
          bindTriggerElements();
        }

        function init() {
          if (!getModal()) {
            bindTriggerElements();
            return;
          }
          attachListeners();
          refreshModal();
        }

        ready(init);

        if (window.prestashop && typeof window.prestashop.on === 'function') {
          prestashopEvents.forEach(function (eventName) {
            try {
              window.prestashop.on(eventName, init);
            } catch (error) {
              console.error('[filters-modal] Failed to subscribe to event', error);
            }
          });
        }
      })();
    </script>
    {/literal}
  {/if}
{/block}
