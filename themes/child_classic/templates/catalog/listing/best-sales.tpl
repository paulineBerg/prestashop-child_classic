{*
 * Align best-sellers grid with homepage/category cards.
 *}
{extends file='catalog/listing/product-list.tpl'}

{block name='product_list'}
  {if empty($productGridClass)}
    {assign var=productGridClass value='col-xs-12 col-sm-6 col-xl-4'}
  {/if}
  {include file='catalog/_partials/products.tpl' listing=$listing productClass=$productGridClass}
{/block}
