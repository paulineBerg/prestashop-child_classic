{**
 * Override breadcrumb to keep "Accueil" (home) clickable even when it is the last item.
 *}
{assign var='homeUrl' value=$urls.pages.index|default:$urls.base_url|default:''}
{assign var='homeUrlNormalized' value=$homeUrl|trim:'/'}

<nav data-depth="{$breadcrumb.count|escape:'html':'UTF-8'}"
     class="breadcrumb"
     itemscope
     itemtype="https://schema.org/BreadcrumbList">
  <ol>
    {block name='breadcrumb'}
      {foreach from=$breadcrumb.links item=path name=breadcrumb}
        {block name='breadcrumb_item'}
          {assign var='pathUrl' value=$path.url|default:''}
          {assign var='pathUrlNormalized' value=$pathUrl|trim:'/'}
          {assign var='isHomeCrumb' value=$homeUrlNormalized && $pathUrlNormalized && $pathUrlNormalized == $homeUrlNormalized}
          <li itemprop="itemListElement"
              itemscope
              itemtype="https://schema.org/ListItem">
            {if not $smarty.foreach.breadcrumb.last || $isHomeCrumb}
              <a href="{$pathUrl|escape:'html':'UTF-8'}" itemprop="item">
                <span itemprop="name">{$path.title|escape:'html':'UTF-8'}</span>
              </a>
            {else}
              <span itemprop="name">{$path.title|escape:'html':'UTF-8'}</span>
            {/if}
            <meta itemprop="position" content="{$smarty.foreach.breadcrumb.iteration}" />
          </li>
        {/block}
      {/foreach}
    {/block}
  </ol>
</nav>
