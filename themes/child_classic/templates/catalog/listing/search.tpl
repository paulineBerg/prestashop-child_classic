{*
 * Child theme override to align search results grid with homepage/category cards.
 *}
{extends file='catalog/listing/product-list.tpl'}

{block name="error_content"}
  <h4 id="product-search-no-matches">{l s='No matches were found for your search' d='Shop.Theme.Catalog'}</h4>
  <p>{l s='Please try other keywords to describe what you are looking for.' d='Shop.Theme.Catalog'}</p>
{/block}

{block name='product_list'}
  {if empty($productGridClass)}
    {assign var=productGridClass value='col-xs-12 col-sm-6 col-xl-4'}
  {/if}
  {include file='catalog/_partials/products.tpl' listing=$listing productClass=$productGridClass}
{/block}
