<?php
/**
 * 2007-2020 PrestaShop.
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
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
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */

/**
 * @since 1.5.0
 *
 * @property Ps_Emailsubscription $module
 */
class Ps_EmailsubscriptionVerificationModuleFrontController extends ModuleFrontController
{
    private $message = '';

    /**
     * @see FrontController::postProcess()
     */
    public function postProcess()
    {
        // Récupérer le token reCAPTCHA envoyé par le formulaire
        $recaptchaToken = Tools::getValue('recaptcha_token');
        
        // Clé secrète reCAPTCHA (à remplacer par votre clé secrète réelle)
        $recaptchaSecret = '6LfD3ygkAAAAAJWH91VnrbT8utZYWB1E6exjeoZd';

        // Validation du token via l'API reCAPTCHA
        $response = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret=' . $recaptchaSecret . '&response=' . $recaptchaToken);
        $responseKeys = json_decode($response, true);

        if (!empty($responseKeys["success"]) && $responseKeys["success"] == true && $responseKeys["score"] > 0.5) {
            // Succès : procéder avec la validation email
            $this->message = $this->module->confirmEmail(Tools::getValue('token'));
        } else {
            // Échec de la vérification reCAPTCHA
            $this->message = $this->trans(
                'reCAPTCHA verification failed. Please try again.',
                [],
                'Modules.PsEmailSubscription.Errors'
            );
        }
    }

    /**
     * @see FrontController::initContent()
     */
    public function initContent()
    {
        parent::initContent();

        // Assignation du message à Smarty
        $this->context->smarty->assign('message', $this->message);

        // Charger le template
        $this->setTemplate('module:ps_emailsubscription/views/templates/front/verification_execution.tpl');
    }
}
