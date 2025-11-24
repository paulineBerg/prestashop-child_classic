{extends file='parent:checkout/order-confirmation.tpl'}

{block name='page_content_container' prepend}
  {if $customer.is_logged}
    {assign var=groupId value=5}
    {assign var=orders value=Order::getCustomerOrders($customer.id)}
    {assign var=customerGroups value=$customer->getGroups()}
    {if $orders|@count >= 1 && !in_array($groupId, $customerGroups)}
      {assign var=_added value=$customer->addGroups([$groupId])}
    {/if}
  {/if}
{/block}
