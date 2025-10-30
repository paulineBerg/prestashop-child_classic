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

{block name='head_charset'}
  <meta charset="utf-8">
{/block}
{block name='head_ie_compatibility'}
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
{/block}

{block name='head_hreflang'}
  <link rel="alternate" hreflang="fr-FR" href="https://www.boulyetcailloux.com/" />
  <link rel="alternate" hreflang="fr" href="https://www.boulyetcailloux.com/" />
  <link rel="alternate" hreflang="x-default" href="https://www.boulyetcailloux.com/" />
{/block}

{** TARTEAUCITRON RGPD**}
{block name='tarteaucitron_head'}
    {include file="modules/pbgestion/script/tarteaucitronhead.tpl"}
{/block}

<meta name="google-site-verification" content="5ETSzz1_QyntjkOjKzZniROi0f5tziNDTlB85Hslp-4" />

<!-- indique aux robots de choisir les images larges -->
<meta name="robots" content="max-image-size: large">

{* APPLE TOUCH ICON *}
<link rel="apple-touch-icon" href="https://boulyetcailloux.com/img/AppleTouchIcone200or.png">

{block name='head_seo'}
  <title>{block name='head_seo_title'}{$page.meta.title}{/block}</title>
  {block name='hook_after_title_tag'}
    {hook h='displayAfterTitleTag'}
  {/block}
  <meta name="description" content="{block name='head_seo_description'}{$page.meta.description}{/block}">
  <meta name="keywords" content="{block name='head_seo_keywords'}{$page.meta.keywords}{/block}">
  {if $page.meta.robots !== 'index'}
    <meta name="robots" content="{$page.meta.robots}">
  {/if}

  {* ✅ BALISE NOINDEX POUR PAGES PRIVÉES *}
  {if isset($page.page_name) && in_array($page.page_name, [
    'authentication',
    'my-account',
    'cart',
    'order',
    'order-confirmation',
    'order-slip',
    'addresses',
    'address',
    'identity',
    'discount',
    'history',
    'guest-tracking',
    'password'
  ])}
    <meta name="robots" content="noindex, follow">
  {/if}

  {if $page.canonical}
    <link rel="canonical" href="{$page.canonical}">
  {/if}
  {block name='head_hreflang'}
    {foreach from=$urls.alternative_langs item=pageUrl key=code}
      <link rel="alternate" href="{$pageUrl}" hreflang="{$code}">
    {/foreach}
  {/block}

  {block name='head_microdata'}
    {include file="_partials/microdata/head-jsonld.tpl"}
  {/block}
  
  {block name='head_microdata_special'}{/block}
  
  {block name='head_pagination_seo'}
    {include file="_partials/pagination-seo.tpl"}
  {/block}

  {block name='head_open_graph'}
    <meta property="og:title" content="{$page.meta.title}" />
    <meta property="og:description" content="{$page.meta.description}" />
    <meta property="og:url" content="{$urls.current_url}" />
    <meta property="og:site_name" content="{$shop.name}" />
    {if !isset($product) && $page.page_name != 'product'}<meta property="og:type" content="website" />{/if}
  {/block}  
{/block}

{block name='head_viewport'}
  <meta name="viewport" content="width=device-width, initial-scale=1">
{/block}

{block name='head_icons'}
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet" media="print" onload="this.media='all'">
  <noscript>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
  </noscript>

  <link rel="icon" type="image/vnd.microsoft.icon" href="{$shop.favicon}?{$shop.favicon_update_time}">
  <link rel="shortcut icon" type="image/x-icon" href="{$shop.favicon}?{$shop.favicon_update_time}">
{/block}

{block name='stylesheets'}
  {include file="_partials/stylesheets.tpl" stylesheets=$stylesheets}
{/block}

{block name='javascript_head'}
  {include file="_partials/javascript.tpl" javascript=$javascript.head vars=$js_custom_vars}
{/block}

{block name='hook_header'}
  {$HOOK_HEADER nofilter}
{/block}

{block name='hook_extra'}{/block}
