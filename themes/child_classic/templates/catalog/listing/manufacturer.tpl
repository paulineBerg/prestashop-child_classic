{**
 * Custom manufacturer page matching homepage/category product grid.
 *}
{extends file='catalog/listing/product-list.tpl'}

{block name='product_list_header'}
  <h1>{l s='List of products by brand %brand_name%' sprintf=['%brand_name%' => $manufacturer.name] d='Shop.Theme.Catalog'}</h1>
  <div id="manufacturer-short_description">{$manufacturer.short_description nofilter}</div>
  <div id="manufacturer-description">{$manufacturer.description nofilter}</div>
{/block}

{block name='product_list'}
  {if empty($productGridClass)}
    {assign var=productGridClass value='col-xs-12 col-sm-6 col-xl-4'}
  {/if}
  {include file='catalog/_partials/products.tpl' listing=$listing productClass=$productGridClass}
{/block}
