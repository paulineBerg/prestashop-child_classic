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
 *}

<!-- Script JSON-LD principal pour l'organisation -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "{$shop.name|escape:'html'}",
  "url": "{$urls.pages.index|escape:'html'}",
  "description": "{if !empty($page.meta.description)}{$page.meta.description|escape:'html'}{else}Découvrez nos créations artisanales uniques en pierres naturelles et acier inoxydable{/if}",
  "email": "{$shop.email|escape:'html'}",
  "logo": {
    "@type": "ImageObject",
    "url": "{$shop.logo_details.src|escape:'html'}"
  },
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "{$shop.address.address1|escape:'html'}",
    "addressLocality": "{$shop.address.city|escape:'html'}",
    "addressRegion": "{if isset($shop.address.state)}{$shop.address.state|escape:'html'}{/if}",
    "postalCode": "{$shop.address.postcode|escape:'html'}",
    "addressCountry": "FR"
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "5",
    "reviewCount": "9"
  },
  "contactPoint": [
    {
      "@type": "ContactPoint",
      "telephone": "{if !empty($shop.phone)}{$shop.phone|escape:'html'}{/if}",
      "contactType": "customer service",
      "areaServed": "FR",
      "availableLanguage": ["French", "English"]
    }
  ],
  "founder": {
    "@type": "Person",
    "name": "Pauline Bergon"
  },
  "foundingDate": "2022-05-22",
  "numberOfEmployees": {
    "@type": "QuantitativeValue",
    "value": "1"
  },
  "taxID": "FR60803935725",
  "vatID": "FR60803935725",
  "sameAs": [
    "https://www.facebook.com/boulyetcailloux",
    "https://www.youtube.com/@boulyetcailloux",
    "https://www.pinterest.fr/boulyetcailloux",
    "https://www.instagram.com/boulyetcailloux",
    "https://www.linkedin.com/in/boulyetcailloux"
  ]
}
</script>

<!-- Script JSON-LD pour les webpages -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebPage",
  "isPartOf": {
    "@type": "WebSite",
    "url": "{$urls.pages.index|escape:'html'}",
    "name": "{$shop.name|escape:'html'}"
  },
  "name": "{if !empty($page.meta.title)}{$page.meta.title|escape:'html'}{else}Page sans titre{/if}",
  "description": "{if !empty($page.meta.description)}{$page.meta.description|escape:'html'}{else}Découvrez nos créations artisanales uniques{/if}",
  "url": "{$urls.current_url|escape:'html'}",
  "image": "{if !empty($product.cover)}{$product.cover.bySize.home_default.url|escape:'html'}{elseif !empty($category.image)}{$category.image.large.url|escape:'html'}{elseif !empty($shop.logo_details.src)}{$shop.logo_details.src|escape:'html'}{/if}",
  "author": {
    "@type": "Person",
    "name": "Pauline Bergon"
  },
  "inLanguage": "fr-FR",
  "publisher": {
    "@type": "Organization",
    "name": "{$shop.name|escape:'html'}"
  }
}
</script>

<!-- Script JSON-LD pour le fil d'Ariane -->
{if isset($breadcrumb.links[1])}
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    {foreach from=$breadcrumb.links item=path name=breadcrumb}
      {assign var='itemUrl' value=$path.url|default:''}
      {if $smarty.foreach.breadcrumb.last && !$itemUrl}
        {* Si la dernière crumb n'a pas d'URL, on utilise l'URL courante *}
        {assign var='itemUrl' value=$urls.current_url|default:''}
      {/if}
      {
        "@type": "ListItem",
        "position": {$smarty.foreach.breadcrumb.iteration},
        "name": "{$path.title|escape:'html':'UTF-8'}"
        {if $itemUrl}
        ,"item": "{$itemUrl|escape:'html':'UTF-8'}"
        {/if}
      }{if !$smarty.foreach.breadcrumb.last},{/if}
    {/foreach}
  ]
}
</script>
{/if}
