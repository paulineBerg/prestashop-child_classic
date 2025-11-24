{**
 * Child theme override: replace contact text with phone icon in header
 *}
<div id="_desktop_contact_link">
  <div id="contact-link">
    {if $contact_infos.phone}
      <a class="contact-link-phone-inline" href="tel:{$contact_infos['phone']|replace:' ':''}" aria-label="{l s='Call us' d='Shop.Theme.Global'}">
        <i class="material-icons" aria-hidden="true">phone</i>
        <span class="contact-phone-number">{$contact_infos.phone}</span>
      </a>
    {else}
      <a class="contact-link-phone-inline" href="{$urls.pages.contact}" aria-label="{l s='Contact us' d='Shop.Theme.Global'}">
        <i class="material-icons" aria-hidden="true">phone</i>
        <span class="contact-phone-number">{l s='Contact us' d='Shop.Theme.Global'}</span>
      </a>
    {/if}
  </div>
  <div id="_mobile_contact_link"></div>
</div>
