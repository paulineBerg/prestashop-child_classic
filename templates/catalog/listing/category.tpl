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
{extends file='catalog/listing/product-list.tpl'}

{block name='left_column'}{/block}
{block name='right_column'}{/block}

{capture assign='categoryHeaderContent'}
  {hook h="displayHeaderCategory"}
{/capture}

{capture assign='categoryTopColumnContent'}
  {hook h="displayTopColumn"}
{/capture}

{block name='content'}
  <section id="main">

    {block name='product_list_header'}
      {include file='catalog/_partials/category-header.tpl' listing=$listing category=$category}
    {/block}

    {block name='subcategory_list'}
      {if isset($subcategories) && $subcategories|@count > 0}
        {include file='catalog/_partials/subcategories.tpl' subcategories=$subcategories}
      {/if}
    {/block}

    <section id="products">
      {if $listing.products|count}

        {block name='product_list_top'}
          {include file='catalog/_partials/products-top.tpl' listing=$listing}
          {if $categoryHeaderContent|trim neq ''}
            {$categoryHeaderContent nofilter}
          {/if}
          {if $categoryTopColumnContent|trim neq '' || !empty($listing.rendered_facets)}
            <div class="category-top-filters">
              {if $categoryTopColumnContent|trim neq ''}
                {$categoryTopColumnContent nofilter}
              {/if}
              {if !empty($listing.rendered_facets)}
                <div class="category-inline-filters">
                  {$listing.rendered_facets nofilter}
                </div>
              {/if}
            </div>
          {/if}
        {/block}

        {block name='product_list_active_filters'}
          <div class="hidden-sm-down">
            {$listing.rendered_active_filters nofilter}
          </div>
        {/block}

        {block name='product_list'}
          {include file='catalog/_partials/products.tpl' listing=$listing productClass="col-xs-12 col-sm-6 col-xl-4"}
        {/block}

        {block name='product_list_bottom'}
          {include file='catalog/_partials/products-bottom.tpl' listing=$listing}
        {/block}

      {else}
        <div id="js-product-list-top"></div>

        <div id="js-product-list">
          {capture assign="errorContent"}
            <h4>{l s='No products available yet' d='Shop.Theme.Catalog'}</h4>
            <p>{l s='Stay tuned! More products will be shown here as they are added.' d='Shop.Theme.Catalog'}</p>
          {/capture}

          {include file='errors/not-found.tpl' errorContent=$errorContent}
        </div>

        <div id="js-product-list-bottom"></div>
      {/if}
    </section>

    {block name='product_list_footer'}
      {include file='catalog/_partials/category-footer.tpl' listing=$listing category=$category}
    {/block}

    {hook h="displayFooterCategory"}

  </section>
{/block}
