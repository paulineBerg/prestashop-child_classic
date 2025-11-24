{**
 * Custom miniature with Avant-Première badge/lock logic
 *}
{block name='product_miniature_item'}
{assign var=avantCategoryId value=26}
{assign var=avantProductFromCategory value=false}
{if isset($product.id_product)}
  {assign var=productCategories value=Product::getProductCategories($product.id_product)}
  {if $productCategories && in_array($avantCategoryId, $productCategories)}
    {assign var=avantProductFromCategory value=true}
  {/if}
{/if}
{assign var=avantProduct value=($product.avant_premiere|default:false) || $avantProductFromCategory}
{assign var=avantLock value=($avantProduct && !$customer.is_logged)}
<div class="js-product product{if !empty($productClasses)} {$productClasses}{/if}{if $avantProduct} avant-product-wrapper{/if}{if $avantLock} avant-lock-wrapper{/if}">
  <article class="product-miniature js-product-miniature{if $avantProduct} is-avant{if $avantLock} avant-lock{/if}{/if}" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}"{if $avantProduct} data-avant="1"{/if}{if $avantLock} data-avant-lock="1"{/if}>
    <div class="thumbnail-container">
      <div class="thumbnail-top">
        {block name='product_thumbnail'}
          {if $product.cover}
            <a href="{$product.url}" class="thumbnail product-thumbnail">
              <picture>
                {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                <img
                  src="{$product.cover.bySize.home_default.url}"
                  alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
                  loading="lazy"
                  data-full-size-image-url="{$product.cover.large.url}"
                  width="{$product.cover.bySize.home_default.width}"
                  height="{$product.cover.bySize.home_default.height}"
                />
              </picture>
            </a>
          {else}
            <a href="{$product.url}" class="thumbnail product-thumbnail">
              <picture>
                {if !empty($urls.no_picture_image.bySize.home_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                {if !empty($urls.no_picture_image.bySize.home_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                <img
                  src="{$urls.no_picture_image.bySize.home_default.url}"
                  loading="lazy"
                  width="{$urls.no_picture_image.bySize.home_default.width}"
                  height="{$urls.no_picture_image.bySize.home_default.height}"
                />
              </picture>
            </a>
          {/if}
        {/block}

        <div class="highlighted-informations{if !$product.main_variants} no-variants{/if}">
          {block name='quick_view'}
            <a class="quick-view js-quick-view" href="#" data-link-action="quickview">
              <i class="material-icons search">&#xE8B6;</i> {l s='Quick view' d='Shop.Theme.Actions'}
            </a>
          {/block}

          {block name='product_variants'}
            {if $product.main_variants}
              {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
            {/if}
          {/block}
        </div>
      </div>

      <div class="product-description">
        {block name='product_name'}
          {if $page.page_name == 'index'}
            <h3 class="h3 product-title"><a href="{$product.url}" content="{$product.url}">{$product.name|truncate:30:'...'}</a></h3>
          {else}
            <h2 class="h3 product-title"><a href="{$product.url}" content="{$product.url}">{$product.name|truncate:30:'...'}</a></h2>
          {/if}
        {/block}

        {block name='product_price_and_shipping'}
          {if $product.show_price}
            {assign var="hasCombination" value=$product.id_product_attribute|default:0|intval}
            {assign var="canQuickAdd" value=(!$configuration.is_catalog && !$product.main_variants && !$hasCombination && $product.add_to_cart_url)}
            <div class="product-price-and-shipping{if $canQuickAdd} product-price-with-inline-cart{/if}">
              <div class="product-price-details">
                {if $product.has_discount}
                  {hook h='displayProductPriceBlock' product=$product type="old_price"}

                  <span class="regular-price" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.regular_price}</span>
                  {if $product.discount_type === 'percentage'}
                    <span class="discount-percentage discount-product">{$product.discount_percentage}</span>
                  {elseif $product.discount_type === 'amount'}
                    <span class="discount-amount discount-product">{$product.discount_amount_to_display}</span>
                  {/if}
                {/if}

                {hook h='displayProductPriceBlock' product=$product type="before_price"}

                <span class="price" aria-label="{l s='Price' d='Shop.Theme.Catalog'}">
                  {capture name='custom_price'}{hook h='displayProductPriceBlock' product=$product type='custom_price' hook_origin='products_list'}{/capture}
                  {if '' !== $smarty.capture.custom_price}
                    {$smarty.capture.custom_price nofilter}
                  {else}
                    {$product.price}
                  {/if}
                </span>

                {hook h='displayProductPriceBlock' product=$product type='unit_price'}

                {hook h='displayProductPriceBlock' product=$product type='weight'}
              </div>

              {if $canQuickAdd}
                <form
                  class="product-price-inline-cart js-product-price-inline-cart"
                  method="post"
                  action="{$urls.pages.cart}"
                >
                  <input type="hidden" name="token" value="{$static_token}">
                  <input type="hidden" name="id_product" value="{$product.id_product|intval}">
                  <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute|default:0|intval}">
                  <input type="hidden" name="id_customization" value="0">
                  <input type="hidden" name="qty" value="{if isset($product.minimal_quantity) && $product.minimal_quantity > 0}{$product.minimal_quantity|intval}{else}1{/if}">

                  {capture name='inline_cart_label'}
                    {l s='Add to cart' d='Shop.Theme.Actions'}
                  {/capture}
                  {assign var="inlineCartLabel" value=$smarty.capture.inline_cart_label|trim}
                  {capture name='inline_cart_sr_label'}
                    {$inlineCartLabel} – {$product.name|strip_tags|trim|truncate:60:'...'}
                  {/capture}
                  {assign var="inlineCartSrLabel" value=$smarty.capture.inline_cart_sr_label|trim}

                  <button
                    type="submit"
                    class="product-price-cart-button js-miniature-add-to-cart"
                    data-button-action="add-to-cart"
                    title="{$inlineCartLabel}"
                    aria-label="{$inlineCartSrLabel}"
                  >
                    <span class="material-icons" aria-hidden="true">&#xE547;</span>
                    <span class="sr-only">{$inlineCartSrLabel}</span>
                  </button>
                </form>
              {/if}
            </div>
          {/if}
        {/block}

        {block name='product_reviews'}
          {hook h='displayProductListReviews' product=$product}
        {/block}
      </div>

      {include file='catalog/_partials/product-flags.tpl'}
    </div>
  </article>
</div>

{if $avantLock}
  {literal}
  <script>
    (function () {
      if (window.bcAvantLockInit) return;
      window.bcAvantLockInit = true;
      var loginUrl = '{/literal}{$urls.pages.authentication|escape:'javascript'}{literal}';
      var registerUrl = '{/literal}{$urls.pages.register|escape:'javascript'}{literal}';
      var modal;

      function buildModal() {
        modal = document.createElement('div');
        modal.id = 'avant-lock-modal';
        modal.className = 'avant-lock-modal';
        modal.setAttribute('role', 'dialog');
        modal.setAttribute('aria-modal', 'true');
        modal.setAttribute('aria-hidden', 'true');
        modal.innerHTML =
          '<div class="avant-lock-modal__dialog">' +
            '<button type="button" class="avant-lock-modal__close" aria-label="Fermer" data-avant-lock-close>&times;</button>' +
            '<p class="avant-lock-modal__title">🔒 Réservé aux membres</p>' +
            '<p class="avant-lock-modal__text">Ces nouveautés sont en avant-première pour nos membres — connectez-vous ou créez un compte.</p>' +
            '<div class="avant-lock-modal__actions">' +
              '<a class="btn btn-primary" href="' + loginUrl + '">' + 'Se connecter' + '</a>' +
              '<a class="btn btn-outline-primary" href="' + registerUrl + '">' + 'Créer un compte' + '</a>' +
            '</div>' +
          '</div>';
        document.body.appendChild(modal);
      }

      function showModal() {
        if (!modal) buildModal();
        modal.classList.add('is-visible');
        modal.setAttribute('aria-hidden', 'false');
        document.documentElement.classList.add('avant-lock-modal-open');
        document.body.classList.add('avant-lock-modal-open');
      }

      function hideModal() {
        if (!modal) return;
        modal.classList.remove('is-visible');
        modal.setAttribute('aria-hidden', 'true');
        document.documentElement.classList.remove('avant-lock-modal-open');
        document.body.classList.remove('avant-lock-modal-open');
      }

      document.addEventListener('click', function (event) {
        var card = event.target.closest('.js-product-miniature[data-avant-lock="1"]');
        if (!card) return;
        event.preventDefault();
        event.stopPropagation();
        showModal();
      }, true);

      document.addEventListener('click', function (event) {
        if (!modal) return;
        if (event.target === modal || event.target.hasAttribute('data-avant-lock-close')) {
          hideModal();
        }
      });

      document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') {
          hideModal();
        }
      });
    })();
  </script>
  {/literal}
{/if}
{/block}
