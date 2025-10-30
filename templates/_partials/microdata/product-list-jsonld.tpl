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
{assign var='products' value=$listing.products} <!-- Supposons que $listing.products contient la liste des produits -->

{assign var='hasAggregateRating' value=false}
{assign var='ratingValue' value=""}
{assign var='ratingReviewCount' value=""}
{if !empty($product.productComments.averageRating) && !empty($product.productComments.nbComments)}
  {assign var='hasAggregateRating' value=true}
  {assign var='ratingValue' value=$product.productComments.averageRating}
  {assign var='ratingReviewCount' value=$product.productComments.nbComments}
{elseif !empty($ratings.avg) && !empty($nbComments)}
  {assign var='hasAggregateRating' value=true}
  {assign var='ratingValue' value=$ratings.avg}
  {assign var='ratingReviewCount' value=$nbComments}
{/if}

<!-- Script JSON-LD pour la LISTE DES PRODUITS -->
<script type="application/ld+json">
{
  "@context": "https://schema.org/",
  "@type": "ItemList",
  "itemListElement": [
    {foreach from=$products item=product name=productLoop}
      {
        "@type": "Product",
        "name": "{$product.name}",
        "description": "{$product.description|regex_replace:'/[\r\n]/' : ' '}",
        "category": "{$product.category_name}",
        "quantity": "{$product.quantity}",

        {if $product.images|count > 0}
          "image": [
            {foreach from=$product.images item=p_img name="p_img_list"}
              "{$p_img.large.url}"{if not $smarty.foreach.p_img_list.last},{/if}
            {/foreach}
          ],
        {/if}  

        {if $product_manufacturer->name || $shop.name} "brand": {
            "@type": "Brand",
            "name": "{if $product_manufacturer->name}{$product_manufacturer->name|escape:'html':'UTF-8'}{else}{$shop.name}{/if}"
          },
        {/if}        

        {if $hasAggregateRating} "aggregateRating": {
            "@type": "AggregateRating",
            "ratingValue": "{$ratingValue|round:1|escape:'html':'UTF-8'}",
            "reviewCount": "{$ratingReviewCount|escape:'html':'UTF-8'}"
          },
        {/if}

        "offers": {
          "@type": "Offer",
          "priceCurrency": "{$currency.iso_code}",
          "name": "{$product.name|strip_tags:false}",
          "price": "{$product.price_amount}",
          "priceType": "FixedPrice",
          "url": "{$product.url}",
          "mobileUrl": "{$product.url}",
          "availability": "{$product.seo_availability}",          
          "shippingDetails": {
            "shippingRate": {
              "@type": "MonetaryAmount",
              "value": "0",
              "currency": "EUR"
            },
            "shippingDestination": {
              "@type": "DefinedRegion",
              "addressCountry": "FR"
            },
            "@type": "OfferShippingDetails",
            "deliveryTime": {
              "@type": "ShippingDeliveryTime",
              "businessDays": {
                "@type": "OpeningHoursSpecification",
                "dayOfWeek": [
                  "https://schema.org/Monday",
                  "https://schema.org/Tuesday",
                  "https://schema.org/Wednesday",
                  "https://schema.org/Thursday",
                  "https://schema.org/Friday"
                ]
              },  
              "cutoffTime": "12:00:00",
                  "handlingTime": {
                    "@type": "QuantitativeValue",
                    "minValue": 1,
                    "maxValue": 2,
                    "unitCode": "d"
              },
              "transitTime": {
                    "@type": "QuantitativeValue",
                    "minValue": 1,
                    "maxValue": 10,
                    "unitCode": "d"
              },             
              "seller": {
                  "@type": "Organization",
                  "name": "{$shop.name}"
              }
            }
          },
          "hasMerchantReturnPolicy": {
            "@type": "MerchantReturnPolicy",
            "returnFees": "https://schema.org/ReturnFeesCustomerResponsibility",
            "applicableCountry": "FR",
            "returnPolicyCountry": "FR",
            "returnPolicyCategory": "MerchantReturnFiniteReturnWindow",
            "merchantReturnDays": 14,
            "returnMethod": "ReturnInStore",
            "merchantReturnLink": "https://boulyetcailloux.com/content/1-livraison"
          },                                        
          {if $product.discount_amount}
            "discount": {
              "@type": "Discount",
              "discountType": "{if $product.discount_type == 'percentage'}Percentage{elseif $product.discount_type == 'amount'}FixedAmount{else}Unknown{/if}",
              "discountValue": "{$product.discount_amount|escape:'html'}"
            },
            "priceBeforeDiscount": "{$product.price + $product.discount_amount|escape:'html'}"
          {else}
            "priceValidUntil": "{($smarty.now + (int)(60*60*24*15))|date_format:'%Y-%m-%d'}"
          {/if}
        }
      }{if not $smarty.foreach.productLoop.last},{/if}
    {/foreach}
  ]
}
</script>
