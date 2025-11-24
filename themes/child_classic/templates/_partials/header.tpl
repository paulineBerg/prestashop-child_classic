{**
 * Custom child theme header with logo aligned left beside the primary nav, based on classic header.
 *}
{block name='header_banner'}
  {capture name=pb_header_banner}{hook h='displayBanner'}{/capture}
{if $smarty.capture.pb_header_banner|trim}
    {$smarty.capture.pb_header_banner nofilter}
  {else}
    <div class="header-banner">
      <div class="header-banner__marquee" aria-hidden="true">
      </div>
      <span class="sr-only"> * Frais de livraison offerts - en France métropolitaine, et en lettre suivie</span>
    </div>
  {/if}
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
        <button
          class="float-xs-left header-top__menu-toggle"
          id="menu-icon"
          type="button"
          aria-controls="mobile_top_menu_wrapper"
          aria-expanded="false"
          aria-label="{l s='Open mobile menu' d='Shop.Theme.Global'}"
          data-open-label="{l s='Open mobile menu' d='Shop.Theme.Global'}"
          data-close-label="{l s='Close mobile menu' d='Shop.Theme.Global'}"
        >
          <i class="material-icons d-inline" aria-hidden="true">&#xE5D2;</i>
        </button>
        <div class="top-logo" id="_mobile_logo"></div>
        <div class="float-xs-right" id="_mobile_cart"></div>
        <div class="float-xs-right" id="_mobile_user_info"></div>
        <div class="clearfix"></div>
      </div>
      <div id="mobile_top_menu_wrapper" class="row hidden-md-up" style="display:none;">
        <div class="mobile-breadcrumb" id="_mobile_breadcrumb"></div>
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
      var menuToggle = document.getElementById('menu-icon');
      var mobileMenu = document.getElementById('mobile_top_menu_wrapper');
      var breadcrumbNav = document.querySelector('#wrapper nav.breadcrumb');
      var mobileBreadcrumbTarget = document.getElementById('_mobile_breadcrumb');

      var syncMenuToggleState = function () {
        if (!menuToggle || !mobileMenu) {
          return;
        }
        var isExpanded = window.getComputedStyle(mobileMenu).display !== 'none';
        menuToggle.setAttribute('aria-expanded', isExpanded ? 'true' : 'false');
        var label = isExpanded
          ? menuToggle.getAttribute('data-close-label')
          : menuToggle.getAttribute('data-open-label');
        if (label) {
          menuToggle.setAttribute('aria-label', label);
        }
      };

      if (menuToggle) {
        menuToggle.addEventListener('click', function () {
          requestAnimationFrame(syncMenuToggleState);
        });
      }

      var desktopSearchPlaceholder = null;
      var contactPlaceholder = null;
      var breadcrumbPlaceholder = null;

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

      if (breadcrumbNav) {
        var breadcrumbPlaceholderId = 'desktop-breadcrumb-placeholder';
        breadcrumbPlaceholder = document.getElementById(breadcrumbPlaceholderId);

        if (!breadcrumbPlaceholder) {
          breadcrumbPlaceholder = document.createElement('div');
          breadcrumbPlaceholder.id = breadcrumbPlaceholderId;
          breadcrumbPlaceholder.style.display = 'none';
          var breadcrumbParent = breadcrumbNav.parentNode;

          if (breadcrumbParent) {
            breadcrumbParent.insertBefore(breadcrumbPlaceholder, breadcrumbNav);
          }
        }
      }

      var moveHeaderWidgets = function () {
        if (window.innerWidth < 768) {
          if (searchWidget && mobileTarget && searchWidget.parentNode !== mobileTarget) {
            mobileTarget.appendChild(searchWidget);
          }

          if (contactLinkSource && mobileContactWrapper && contactLinkSource.parentNode !== mobileContactWrapper) {
            mobileContactWrapper.appendChild(contactLinkSource);
          }

          if (breadcrumbNav && mobileBreadcrumbTarget && breadcrumbNav.parentNode !== mobileBreadcrumbTarget) {
            mobileBreadcrumbTarget.appendChild(breadcrumbNav);
          }
        } else {
          if (searchWidget && desktopSearchPlaceholder && desktopSearchPlaceholder.parentNode && searchWidget.parentNode !== desktopSearchPlaceholder.parentNode) {
            desktopSearchPlaceholder.parentNode.insertBefore(searchWidget, desktopSearchPlaceholder.nextSibling);
          }

          if (contactLinkSource && contactPlaceholder && contactPlaceholder.parentNode && contactLinkSource.parentNode !== contactPlaceholder.parentNode) {
            contactPlaceholder.parentNode.insertBefore(contactLinkSource, contactPlaceholder.nextSibling);
          }

          if (breadcrumbNav && breadcrumbPlaceholder && breadcrumbPlaceholder.parentNode && breadcrumbNav.parentNode !== breadcrumbPlaceholder.parentNode) {
            breadcrumbPlaceholder.parentNode.insertBefore(breadcrumbNav, breadcrumbPlaceholder.nextSibling);
          }
        }
        syncMenuToggleState();
      };

      moveHeaderWidgets();
      window.addEventListener('resize', moveHeaderWidgets);
      syncMenuToggleState();
    });
  </script>
  {/literal}
  {hook h='displayNavFullWidth'}
{/block}
