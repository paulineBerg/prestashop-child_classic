{**
 * Theme override to insert a dedicated hook right after the custom text block.
 *}
<div id="custom-text">
  {$cms_infos.text nofilter}
</div>
{hook h='displayCustomTextAfter'}
