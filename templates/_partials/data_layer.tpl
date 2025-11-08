{* === DataLayer e-commerce (GA4) === *}
<script>
  window.dataLayer = window.dataLayer || [];

  // Empêche les multiples bindings si le partial est inclus plusieurs fois
  if (!window.__bc_dl_bound) {
    window.__bc_dl_bound = true;

    // Utils
    function toNumber(x) {
      if (typeof x === 'number') return x;
      if (x == null) return 0;
      var s = String(x).replace(/\s/g, '').replace(',', '.');
      var n = Number(s);
      return isNaN(n) ? 0 : n;
    }
    function q(sel, root) { return (root || document).querySelector(sel); }

    /* -------------------------------
       VIEW_ITEM (uniquement page produit)
       ------------------------------- */
    {if isset($product)}
    (function sendViewItem(){
      // Reset recommandé par GA4 avant chaque push e-commerce
      dataLayer.push({ ecommerce: null });

      var currency  = '{$currency.iso_code|escape:'html'|default:'EUR'}';
      var value     = {$product.price_amount|default:0};
      var itemId    = '{$product.id_product|default:""}';
      var itemName  = '{$product.name|escape:'javascript'|default:""}';
      var itemCat   = '{$product.category|escape:'javascript'|default:""}';
      var variantId = (q('[name="id_product_attribute"]') && q('[name="id_product_attribute"]').value) || undefined;

      dataLayer.push({
        event: 'view_item',
        ecommerce: {
          currency: currency,
          value: toNumber(value),
          items: [{
            item_id: itemId,
            item_name: itemName,
            item_category: itemCat || undefined,
            item_variant: variantId,
            price: toNumber(value),
            quantity: 1
          }]
        }
      });
    })();
    {/if}

    /* -------------------------------------------------
       ADD_TO_CART (fiches ET listes produits)
       - Fiche produit : intercept "submit" du form panier
       - Listes : clic sur boutons standards PrestaShop
       ------------------------------------------------- */

    function pushAddToCart(payload) {
      dataLayer.push({ ecommerce: null }); // reset GA4
      dataLayer.push({ event: 'add_to_cart', ecommerce: payload });
    }

    // 1) FICHE PRODUIT : submit du formulaire d'ajout
    document.addEventListener('submit', function (e) {
      var form = e.target.closest('form[action*="cart"]');
      if (!form) return;

      var isAdd = form.querySelector('input[name="add"], button.add-to-cart, button[name="add"]');
      if (!isAdd) return;

      var qtyEl = form.querySelector('#quantity_wanted, [name="qty"], [name="quantity"]');
      var qty   = toNumber(qtyEl ? qtyEl.value : 1) || 1;

      var variantId = (form.querySelector('[name="id_product_attribute"]') && form.querySelector('[name="id_product_attribute"]').value) || undefined;

      var currency  = '{$currency.iso_code|escape:'html'|default:'EUR'}';
      var priceRaw  = {$product.price_amount|default:0};
      var price     = toNumber(priceRaw);

      var itemId    = '{$product.id_product|default:""}';
      var itemName  = '{$product.name|escape:'javascript'|default:""}';
      var itemCat   = '{$product.category|escape:'javascript'|default:""}';

      pushAddToCart({
        currency: currency,
        value: price * qty,
        items: [{
          item_id: itemId || undefined,
          item_name: itemName || undefined,
          item_category: itemCat || undefined,
          item_variant: variantId,
          price: price,
          quantity: qty
        }]
      });
    });

    // 2) LISTES PRODUITS : clic sur boutons ajout
    document.addEventListener('click', function (e) {
      var btn = e.target.closest('.js-add-to-cart, .ajax_add_to_cart_button, button.add-to-cart, [data-button-action="add-to-cart"]');
      if (!btn) return;

      var card = btn.closest('[data-id-product], .product-miniature, li.ajax_block_product, article.product-miniature');

      var id   = (btn.dataset.idProduct || btn.dataset.id || (card && card.getAttribute('data-id-product')) || '').toString();
      var name = (btn.dataset.name || (card && (q('.product-title a, .h3 a', card) || {}).textContent) || '').trim();

      var price =
        toNumber(btn.dataset.price) ||
        toNumber(card && q('[itemprop="price"]', card) && q('[itemprop="price"]', card).getAttribute('content')) ||
        toNumber(card && q('.price', card) && q('.price', card).textContent) ||
        0;

      var qty = toNumber(btn.dataset.quantity || 1) || 1;

      var currency = '{if isset($currency.iso_code)}{$currency.iso_code|escape:'html'}{else}EUR{/if}';

      pushAddToCart({
        currency: currency,
        value: price * qty,
        items: [{
          item_id: id || undefined,
          item_name: name || undefined,
          price: price,
          quantity: qty
        }]
      });
    });
  }
</script>
