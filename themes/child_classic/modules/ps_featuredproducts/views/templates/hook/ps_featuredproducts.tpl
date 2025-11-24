{**
 * Custom override: adjust the “all products” CTA on the home featured block so it
 * points to the Tous les bijoux listing instead of the default category.
 *}
<section class="featured-products clearfix">
  <h2 class="h2 products-section-title text-uppercase">
    {l s='Popular Products' d='Shop.Theme.Catalog'}
  </h2>
  {include file="catalog/_partials/productlist.tpl" products=$products cssClass="row" productClass="col-xs-12 col-sm-6 col-lg-4 col-xl-3"}
  <a
    class="all-product-link float-xs-left float-md-right h4"
    href="{$link->getCategoryLink(56)}"
  >
    {l s='All products' d='Shop.Theme.Catalog'}<i class="material-icons">&#xE315;</i>
  </a>
</section>
