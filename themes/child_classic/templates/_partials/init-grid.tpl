{*
  Init grid for product listings
  - Par défaut : 2 colonnes mobile / 4 colonnes dès md (iPad & desktop)
  - Pour surcharger sur une page : {assign var=productGridClass value='col-6 col-sm-4 col-md-3'} AVANT l’inclusion de product-list.tpl
*}
{if empty($productGridClass)}
  {assign var=productGridClass value='col-xs-12 col-sm-6 col-xl-4'}
{/if}
