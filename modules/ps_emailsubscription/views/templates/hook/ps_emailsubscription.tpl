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
 <div class="block_newsletter col-lg-8 col-md-12 col-sm-12" id="blockEmailSubscription_{$hookName}">
 <div class="row">
   <div id="block-newsletter-label" class="col-md-5 col-xs-12">
     <p>
       {l s='Get our latest news and special sales' d='Shop.Theme.Global'}   
     </p>
     {* Webbax *}
     <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
     <p class="icon-newsletter">
       <i class="fa fa-envelope" aria-hidden="true"></i>
     </p>
   </div>
     {* Webbax *}   
   <div class="col-md-7 col-xs-12">
     <form action="{$urls.current_url}#blockEmailSubscription_{$hookName}" method="post">
       <div class="row">
         <div class="col-xs-12">
           <input
             class="btn btn-primary float-xs-right hidden-xs-down"
             name="submitNewsletter"
             type="submit"
             value="{l s='Subscribe' d='Shop.Theme.Actions'}"
           >
           <input
             class="btn btn-primary float-xs-right hidden-sm-up"
             name="submitNewsletter"
             type="submit"
             value="{l s='OK' d='Shop.Theme.Actions'}"
           >
           <div class="input-wrapper">
             <input
               name="email"
               type="email"
               value="{$value}"
               placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
               aria-labelledby="block-newsletter-label"
               required
             >
           </div>
           <input type="hidden" name="blockHookName" value="{$hookName}" />
           <input type="hidden" name="action" value="0">
           <!-- Champ caché pour le token reCAPTCHA -->
           <input type="hidden" name="recaptcha_token" id="recaptchaToken">
           <div class="clearfix"></div>
         </div>
         <div class="col-xs-12">
           {if $conditions}
             <p>{$conditions}</p>
           {/if}
           {if $msg}
             <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
               {$msg}
             </p>
           {/if}
           {hook h='displayNewsletterRegistration'}
           {if isset($id_module)}
             {hook h='displayGDPRConsent' id_module=$id_module}
           {/if}
         </div>
       </div>
      <input type="hidden" name="g-recaptcha-response" id="g-recaptcha-response">
      <script src="https://www.google.com/recaptcha/api.js?render=6LfD3ygkAAAAAJyBqeRsGKF9Bpna1cWmOH_XSvIm"></script>
      <script>
        grecaptcha.ready(function() {
        grecaptcha.execute('6LfD3ygkAAAAAJyBqeRsGKF9Bpna1cWmOH_XSvIm', { action: 'newsletter' }).then(function(token) {
        document.getElementById('g-recaptcha-response').value = token;
        });
        });
      </script>
     </form>
   </div>
 </div>
</div>
