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


<div id="js-product-list-header">
    {if $listing.pagination.items_shown_from == 1}
        <div class="block-category card card-block">

            <!-- Suppression du titre qui s'affiche en double -->
            <!-- <h1 class="h1">{$category.name}</h1> -->

            <div class="block-category-inner">

                {if !empty($category.image.large.url)}
                    <!-- Affichage de l'image par défaut ou d'une miniature uniquement si l'image par défaut est absente -->
                    {if empty($category.image.large.sources.avif) && empty($category.image.large.sources.webp)}
                        <!-- Si les versions AVIF et WebP n'existent pas, on affiche la miniature, j'enleve la dimension forcée de l'image-->
                        <img src="{$category.image.large.url}" alt="{$category.image.legend|default:$category.name}" class="img-thumbnail" loading="lazy">
                    {else}
                        <!-- Sinon, on affiche l'image optimisée avec <picture> -->
                        <div class="category-cover">
                            <picture>
                                {if !empty($category.image.large.sources.avif)}
                                    <source srcset="{$category.image.large.sources.avif}" type="image/avif">
                                {/if}
                                {if !empty($category.image.large.sources.webp)}
                                    <source srcset="{$category.image.large.sources.webp}" type="image/webp">
                                {/if}
                                <img src="{$category.image.large.url}" alt="{$category.image.legend|default:$category.name}" loading="lazy" width="300" height="800">
                            </picture>
                        </div>
                    {/if}
                {/if}

                {if $category.description}
                    <div id="category-description" class="text-muted">
                        {$category.description nofilter}
                    </div>
                {/if}

            </div>
        </div>
    {/if}
</div>
