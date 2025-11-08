{* === GA4 BEGIN CHECKOUT === *}
{if $page.page_name == 'cart' || $page.page_name == 'checkout'}
<script>
window.dataLayer = window.dataLayer || [];
dataLayer.push({ ecommerce: null });

(function() {
  var currency = '{$currency.iso_code|escape:'html'|default:'EUR'}';
  var value = 0;
  var items = [];

  {if isset($cart.products) && $cart.products|@count}
    {foreach from=$cart.products item=p}
      var price = {if isset($p.price_amount)}{$p.price_amount|floatval}{elseif isset($p.price)}{$p.price|floatval}{else}0{/if};
      var qty = {$p.quantity|intval};
      value += price * qty;
      items.push({
        item_id: '{$p.id_product|intval}',
        item_name: '{$p.name|escape:'javascript'}',
        item_variant: {if isset($p.id_product_attribute)}'{$p.id_product_attribute|intval}'{else}undefined{/if},
        price: price,
        quantity: qty,
        item_category: {if isset($p.category_name)}'{$p.category_name|escape:'javascript'}'{else}undefined{/if}
      });
    {/foreach}
  {/if}

  dataLayer.push({
    event: 'begin_checkout',
    ecommerce: {
      currency: currency,
      value: value,
      items: items
    }
  });
})();
</script>
{/if}
