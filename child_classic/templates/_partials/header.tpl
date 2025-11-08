{**
 * Custom child theme header with logo aligned left beside the primary nav, based on classic header.
 *}
{block name='header_banner'}
  <div class="header-banner">
    <div class="header-banner__marquee" aria-hidden="true">
      <span> * Frais de livraison offerts - en France métropolitaine, et en lettre suivie</span>
      <span> * Frais de livraison offerts - en France métropolitaine, et en lettre suivie</span>
      <span> * Frais de livraison offerts - en France métropolitaine, et en lettre suivie</span>
      <span> * Frais de livraison offerts - en France métropolitaine, et en lettre suivie</span>
    </div>
    <span class="sr-only"> * Frais de livraison offerts - en France métropolitaine, et en lettre suivie</span>
</span>
    {hook h='displayBanner'}
  </div>
{/block}

{block name='header_nav'}
  <nav class="header-nav">
    <div class="container header-nav__container">
      <div class="header-nav__logo" id="_desktop_logo">
        {if $shop.logo_details}
          {if $page.page_name == 'index'}
            <h1 class="m-0 p-0" style="display:flex;align-items:center;">
              {renderLogo}
            </h1>
          {else}
            {renderLogo}
          {/if}
        {/if}
      </div>

      <div class="header-nav__stack">
        <div class="header-nav__row header-nav__row--primary">
          {hook h='displayNav2'}
        </div>
        <div class="header-nav__row header-nav__row--secondary">
          {hook h='displayTop'}
        </div>
      </div>
      
    </div>
  </nav>
{/block}

{block name='header_top'}
  <div class="header-top header-top--mobile">
    <div class="container">
      <div class="row hidden-md-up text-sm-center mobile">
        <div class="float-xs-left" id="menu-icon">
          <i class="material-icons d-inline">&#xE5D2;</i>
        </div>
        <div class="top-logo" id="_mobile_logo"></div>
        <div class="float-xs-right" id="_mobile_cart"></div>
        <div class="float-xs-right" id="_mobile_user_info"></div>
        <div class="clearfix"></div>
      </div>
      <div id="mobile_top_menu_wrapper" class="row hidden-md-up" style="display:none;">
        <div class="js-top-menu mobile" id="_mobile_top_menu"></div>
        <div class="mobile-search" id="_mobile_search_widget"></div>
        <div class="mobile-contact" id="_mobile_contact_link_wrapper"></div>
        <div class="js-top-menu-bottom">
          <div id="_mobile_currency_selector"></div>
          <div id="_mobile_language_selector"></div>
        </div>
      </div>
    </div>
  </div>
  {literal}
  <script>
    document.addEventListener('DOMContentLoaded', function () {
      var searchWidget = document.getElementById('search_widget');
      var mobileTarget = document.getElementById('_mobile_search_widget');
      var mobileContactWrapper = document.getElementById('_mobile_contact_link_wrapper');
      var contactLinkSource = document.getElementById('_mobile_contact_link');

      if (!mobileTarget) {
        return;
      }

      var desktopSearchPlaceholder = null;
      var contactPlaceholder = null;

      if (searchWidget) {
        var desktopPlaceholderId = 'desktop-search-placeholder';
        desktopSearchPlaceholder = document.getElementById(desktopPlaceholderId);

        if (!desktopSearchPlaceholder) {
          desktopSearchPlaceholder = document.createElement('div');
          desktopSearchPlaceholder.id = desktopPlaceholderId;
          desktopSearchPlaceholder.style.display = 'none';
          var desktopParent = searchWidget.parentNode;

          if (desktopParent) {
            desktopParent.insertBefore(desktopSearchPlaceholder, searchWidget);
          }
        }
      }

      if (contactLinkSource) {
        var contactPlaceholderId = 'mobile-contact-placeholder';
        contactPlaceholder = document.getElementById(contactPlaceholderId);

        if (!contactPlaceholder) {
          contactPlaceholder = document.createElement('div');
          contactPlaceholder.id = contactPlaceholderId;
          contactPlaceholder.style.display = 'none';
          var contactParent = contactLinkSource.parentNode;

          if (contactParent) {
            contactParent.insertBefore(contactPlaceholder, contactLinkSource);
          }
        }
      }

      var moveHeaderWidgets = function () {
        if (window.innerWidth < 768) {
          if (searchWidget && searchWidget.parentNode !== mobileTarget) {
            mobileTarget.appendChild(searchWidget);
          }

          if (contactLinkSource && mobileContactWrapper && contactLinkSource.parentNode !== mobileContactWrapper) {
            mobileContactWrapper.appendChild(contactLinkSource);
          }
        } else {
          if (searchWidget && desktopSearchPlaceholder && desktopSearchPlaceholder.parentNode && searchWidget.parentNode !== desktopSearchPlaceholder.parentNode) {
            desktopSearchPlaceholder.parentNode.insertBefore(searchWidget, desktopSearchPlaceholder.nextSibling);
          }

          if (contactLinkSource && contactPlaceholder && contactPlaceholder.parentNode && contactLinkSource.parentNode !== contactPlaceholder.parentNode) {
            contactPlaceholder.parentNode.insertBefore(contactLinkSource, contactPlaceholder.nextSibling);
          }
        }
      };

      moveHeaderWidgets();
      window.addEventListener('resize', moveHeaderWidgets);
    });
  </script>
  {/literal}
  {hook h='displayNavFullWidth'}
{/block}
