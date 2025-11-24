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
{extends file='catalog/listing/product-list.tpl'}

{block name='left_column'}{/block}
{block name='right_column'}{/block}

{capture assign='categoryHeaderContent'}
  {hook h="displayHeaderCategory"}
{/capture}

{capture assign='categoryTopColumnContent'}
  {hook h="displayTopColumn"}
{/capture}

{block name='content'}
  {assign var=isAvantCategory value=($category.id == 26)}
  {assign var=avantLock value=($isAvantCategory && !$customer.is_logged)}
  {assign var=productSectionClasses value=''}
  {if $isAvantCategory}{assign var=productSectionClasses value=$productSectionClasses|cat:' avant-category'}{/if}
  {if $avantLock}{assign var=productSectionClasses value=$productSectionClasses|cat:' avant-lock'}{/if}
  <section id="main">

    {block name='product_list_header'}
      {include file='catalog/_partials/category-header.tpl' listing=$listing category=$category}
    {/block}

      {block name='subcategory_list'}
        {if isset($subcategories) && $subcategories|@count > 0}
          {include file='catalog/_partials/subcategories.tpl' subcategories=$subcategories}
        {/if}
      {/block}

      <section id="products"{if $productSectionClasses|trim} class="{$productSectionClasses|trim}"{/if}>
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
          {include file='catalog/_partials/products.tpl' listing=$listing productClass="col-xs-12 col-sm-6 col-xl-4"}
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

    {block name='product_list_footer'}
      {include file='catalog/_partials/category-footer.tpl' listing=$listing category=$category}
    {/block}

    {hook h="displayFooterCategory"}

    {if $avantLock}
      <div id="avant-lock-modal" class="avant-lock-modal" role="dialog" aria-modal="true" aria-hidden="true" aria-labelledby="avant-lock-title">
        <div class="avant-lock-modal__dialog">
          <button type="button" class="avant-lock-modal__close" aria-label="{l s='Close' d='Shop.Theme.Actions'}" data-avant-lock-close>&times;</button>
          <p id="avant-lock-title" class="avant-lock-modal__title">🔒 Réservé aux membres</p>
          <p class="avant-lock-modal__text">Ces nouveautés sont en avant-première pour nos membres — connectez-vous ou créez un compte.</p>
          <div class="avant-lock-modal__actions">
            <a class="btn btn-primary" href="{$urls.pages.authentication}?back={$urls.current_url|urlencode}">{l s='Sign in' d='Shop.Theme.Customeraccount'}</a>
            <a class="btn btn-outline-primary" href="{$urls.pages.register}">{l s='Create an account' d='Shop.Theme.Customeraccount'}</a>
          </div>
        </div>
      </div>
      {literal}
      <script>
        document.addEventListener('DOMContentLoaded', function () {
          var productsArea = document.querySelector('#products.avant-lock');
          var modal = document.getElementById('avant-lock-modal');
          if (!productsArea || !modal) {
            return;
          }

          var closeButtons = modal.querySelectorAll('[data-avant-lock-close]');
          var isVisible = false;

          var showModal = function () {
            if (isVisible) {
              return;
            }
            isVisible = true;
            modal.classList.add('is-visible');
            modal.setAttribute('aria-hidden', 'false');
            document.documentElement.classList.add('avant-lock-modal-open');
            document.body.classList.add('avant-lock-modal-open');
          };

          var hideModal = function () {
            if (!isVisible) {
              return;
            }
            isVisible = false;
            modal.classList.remove('is-visible');
            modal.setAttribute('aria-hidden', 'true');
            document.documentElement.classList.remove('avant-lock-modal-open');
            document.body.classList.remove('avant-lock-modal-open');
          };

          productsArea.addEventListener('click', function (event) {
            var interactive = event.target.closest('a, button');
            if (!interactive) {
              return;
            }
            if (!interactive.closest('.js-product-miniature')) {
              return;
            }
            event.preventDefault();
            event.stopPropagation();
            showModal();
          });

          modal.addEventListener('click', function (event) {
            if (event.target === modal || event.target.hasAttribute('data-avant-lock-close')) {
              hideModal();
            }
          });

          document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
              hideModal();
            }
          });
        });
      </script>
      {/literal}
    {/if}

  </section>
{/block}
