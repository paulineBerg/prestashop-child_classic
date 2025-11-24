{if !empty($listing.rendered_facets)}
  <div
    id="filters-modal"
    class="filters-modal js-filters-modal"
    role="dialog"
    aria-modal="true"
    aria-hidden="true"
  >
    <div
      class="filters-modal__backdrop js-close-filter-modal"
      role="button"
      tabindex="0"
      aria-label="{l s='Close filters' d='Shop.Theme.Actions'}"
    ></div>
    <div class="filters-modal__dialog" role="document">
      <header class="filters-modal__header">
        <h3 class="filters-modal__title">
          {l s='Filters' d='Shop.Theme.Catalog'}
        </h3>
        <button
          type="button"
          class="filters-modal__close js-close-filter-modal"
          aria-label="{l s='Close filters' d='Shop.Theme.Actions'}"
        >
          <i class="material-icons" aria-hidden="true">&#xE5CD;</i>
        </button>
      </header>
      <div class="filters-modal__body">
        {$listing.rendered_facets nofilter}
      </div>
      <footer class="filters-modal__footer hidden-md-up">
        <button
          type="button"
          class="btn btn-primary btn-block js-close-filter-modal"
        >
          {l s='Show products' d='Shop.Theme.Actions'}
        </button>
      </footer>
    </div>
  </div>
{/if}
