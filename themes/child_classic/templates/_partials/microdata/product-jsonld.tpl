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

{assign var='hasWeight' value=false}
{if isset($product.weight) && $product.weight != 0}
  {assign var='hasWeight' value=true}
{/if}

{assign var='hasAttribMetal' value=false}
{assign var='AttribMetal' value=""}
{if isset($product.attributes)}
  {foreach from=$product.attributes item=attributeMetal}
    {if isset($attributeMetal.id_attribute_group) && $attributeMetal.id_attribute_group == 13}
      {assign var='hasAttribMetal' value=true}
      {assign var='AttribMetal' value=$attributeMetal.name}
      {break} {* Sort de la boucle dès que la couleur est trouvée *}
    {/if}
  {/foreach}
{/if}
{assign var='hasMetalPrincipal' value=false}
{assign var='featureMetalPrincipal' value=""}
{if isset($product.grouped_features)}
  {foreach from=$product.grouped_features item=groupMetalPrincipal}
    {if $groupMetalPrincipal.id_feature == 21}
      {assign var='hasMetalPrincipal' value=true}
      {assign var='featureMetalPrincipal' value=$groupMetalPrincipal.value}
      {break} {* Sort de la boucle si la condition est remplie *}
    {/if}
  {/foreach}
{/if}

{assign var='hasMaterial' value=false}
{assign var='featureMaterial' value=""}
{if isset($product.grouped_features)}
  {foreach from=$product.grouped_features item=groupMaterial}
    {if $groupMaterial.id_feature == 27}
      {assign var='hasMaterial' value=true}
      {assign var='featureMaterial' value=$groupMaterial.value}
      {break}
    {/if}
  {/foreach}
{/if}

{assign var='hasGender' value=false}
{assign var='featureGender' value=""}
{if isset($product.grouped_features)}
  {foreach from=$product.grouped_features item=groupGender}
    {if $groupGender.id_feature == 18}
      {assign var='hasGender' value=true}
      {assign var='featureGender' value=$groupGender.value}
      {break}
    {/if}
  {/foreach}
{/if}

{assign var='hasAge' value=false}
{assign var='featureAge' value=""}
{if isset($product.grouped_features)}
  {foreach from=$product.grouped_features item=groupAge}
    {if $groupAge.id_feature == 19}
      {assign var='hasAge' value=true}
      {assign var='featureAge' value=$groupAge.value}
      {break}
    {/if}
  {/foreach}
{/if}

{assign var='hasAttribColor' value=false}
{assign var='AttribColor' value=""}
{if isset($product.attributes)}
  {foreach from=$product.attributes item=attributeColor}
    {if isset($attributeColor.id_attribute_group) && $attributeColor.id_attribute_group == 9}
      {assign var='hasAttribColor' value=true}
      {assign var='AttribColor' value=$attributeColor.name}
      {break} {* Sort de la boucle dès que la couleur est trouvée *}
    {/if}
  {/foreach}
{/if}
{assign var='hasColorPrincipal' value=false}
{assign var='featureColorPrincipal' value=""}
{if isset($product.grouped_features)}
  {foreach from=$product.grouped_features item=groupColorPrincipal}
    {if $groupColorPrincipal.id_feature == 26}
      {assign var='hasColorPrincipal' value=true}
      {assign var='featureColorPrincipal' value=$groupColorPrincipal.value}
      {break} {* Sort de la boucle si la condition est remplie *}
    {/if}
  {/foreach}
{/if}
{assign var='hasColor' value=false}
{assign var='featureColor' value=""}
{if isset($product.grouped_features)}
  {foreach from=$product.grouped_features item=groupColor}
    {if $groupColor.id_feature == 6}
      {assign var='hasColor' value=true}
      {assign var='featureColor' value=$groupColor.value}
      {break} {* Sort de la boucle si la condition est remplie *}
    {/if}
  {/foreach}
{/if}

{assign var='hasAttribStone' value=false}
{assign var='AttribStone' value=""}
{if isset($product.attributes)}
  {foreach from=$product.attributes item=attributeStone}
    {if isset($attributeStone.id_attribute_group) && $attributeStone.id_attribute_group == 11}
      {assign var='hasAttribStone' value=true}
      {assign var='AttribStone' value=$attributeStone.name}
      {break} {* Sort de la boucle dès que la couleur est trouvée *}
    {/if}
  {/foreach}
{/if}
{assign var='hasStonePrincipal' value=false}
{assign var='featureStonePrincipal' value=""}
{if isset($product.grouped_features)}
  {foreach from=$product.grouped_features item=groupStonePrincipal}
    {if $groupStonePrincipal.id_feature == 25}
      {assign var='hasStonePrincipal' value=true}
      {assign var='featureStonePrincipal' value=$groupStonePrincipal.value}
      {break} {* Sort de la boucle si la condition est remplie *}
    {/if}
  {/foreach}
{/if}
{assign var='hasStone' value=false}
{assign var='featureStone' value=""}
{if isset($product.grouped_features)}
  {foreach from=$product.grouped_features item=groupStone}
    {if $groupStone.id_feature == 11}
      {assign var='hasStone' value=true}
      {assign var='featureStone' value=$groupStone.value}
      {break} {* Sort de la boucle si la condition est remplie *}
    {/if}
  {/foreach}
{/if}

{assign var='hasOffers' value=$product.show_price}

<!-- Script JSON-LD pour LE PRODUIT -->
<script type="application/ld+json">
  {
    "@context": "https://schema.org/",
    "@type": "Product",
    "name": "{$product.name}",
    "description": "{$page.meta.description|regex_replace:'/[\r\n]/' : ' '}",
    "category": "{$product.category_name}",
    "quantity": "{$product.quantity}",

    {if $hasAttribColor} "color": "{$AttribColor}",
    {elseif $hasColorPrincipal} "color": "{$featureColorPrincipal}",
    {elseif $hasColor} "color": "{$featureColor}",
    {else} "color": "Multicolore",
    {/if}

    {if $hasAge} "age_group": "{$featureAge}",
    {/if}
    {if $hasGender} "gender": "{$featureGender}",
    {/if}
    {if $hasMaterial} "material": "{$featureMaterial}",
    {/if}

    "additionalProperty": [
      {if $hasAttribStone} {
          "@type": "PropertyValue",
          "name": "Stone",
          "value": "{$AttribStone}"
        }
        {if $hasStonePrincipal || $hasStone}, {/if} {* Ajoute une virgule si d'autres propriétés suivent *}
      {/if}

      {if $hasStonePrincipal} {
          "@type": "PropertyValue",
          "name": "Stone",
          "value": "{$featureStonePrincipal}"
        }
        {if $hasStone}, {/if}
      {/if}

      {if $hasStone} {
          "@type": "PropertyValue",
          "name": "Stone",
          "value": "{$featureStone}"
        }
      {/if}
      {if $hasMaterial}
        {if $hasAttribStone || $hasStonePrincipal || $hasStone}, {/if}
        {
          "@type": "PropertyValue",
          "name": "Material",
          "value": "{$featureMaterial}"
        }
      {/if}
    ],


    {if $hasAttribMetal} "metal": "{$AttribMetal}",
    {else $hasMetalPrincipal} "metal": "{$featureMetalPrincipal}",
    {/if}

    {if !empty($product.cover)} "image": "{$product.cover.bySize.home_default.url}",
    {/if}

    "sku": "{if $product.reference}{$product.reference}{else}{$product.id}{/if}",
    "mpn": "{if $product.mpn}{$product.mpn}{elseif $product.reference}{$product.reference}{else}{$product.id}{/if}",

    {if $product.ean13} "gtin13": "{$product.ean13}",
    {elseif $product.upc} "gtin13": "0{$product.upc}",
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

    {if $hasWeight} "weight": {
        "@context": "https://schema.org",
        "@type": "QuantitativeValue",
        "value": "{$product.weight}",
        "unitCode": "{$product.weight_unit}"
      },
{/if}

          {if $hasOffers}
            "offers": {
              "@type": "Offer",
              "priceCurrency": "{$currency.iso_code}",
              "name": "{$product.name|strip_tags:false}",
              "price": "{$product.price_amount}",
              "priceType": "FixedPrice",
              "url": "{$product.url}",
              "mobileUrl": "{$product.url}",
              {if $product.discount_amount}
                "discount": {
                  "@type": "Discount",
                  "discountType": "{if $product.discount_type == 'percentage'}Percentage{elseif $product.discount_type == 'amount'}FixedAmount{else}Unknown{/if}",
                  "discountValue": "{$product.discount_amount|escape:'html'}"
                },
                "priceBeforeDiscount": "{$product.price + $product.discount_amount|escape:'html'}"
              {else}
                "priceValidUntil": "{($smarty.now + (int)(60*60*24*15))|date_format:'%Y-%m-%d'}"
              {/if},
              {if $product.images|count > 0}
                "image": [
                  {foreach from=$product.images item=p_img name="p_img_list"}
                    "{$p_img.large.url}"{if not $smarty.foreach.p_img_list.last},{/if}
                  {/foreach}
                ],
              {/if}
              "sku": "{if $product.reference}{$product.reference}{else}{$product.id}{/if}",
              "mpn": "{if $product.mpn}{$product.mpn}{elseif $product.reference}{$product.reference}{else}{$product.id}{/if}",
              {if $product.ean13}"gtin13": "{$product.ean13}",{else if $product.upc}"gtin13": "0{$product.upc}",{/if}
              {if $product.condition == 'new'}"itemCondition": "https://schema.org/NewCondition",{/if}
              {if $product.show_condition > 0}
                {if $product.condition == 'used'}"itemCondition": "https://schema.org/UsedCondition",{/if}
                {if $product.condition == 'refurbished'}"itemCondition": "https://schema.org/RefurbishedCondition",{/if}
              {/if}
              "availability": "{$product.seo_availability}",
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
              "shippingDetails": {
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
                  }
                },
                "shippingRate": {
                  "@type": "MonetaryAmount",
                  "value": "0",
                  "currency": "EUR"
                },
                "shippingDestination": {
                  "@type": "DefinedRegion",
                  "addressCountry": "FR"
                },
                "seller": {
                  "@type": "Organization",
                  "name": "{$shop.name}"
                }
              }
            }
          {/if}
        }
</script>