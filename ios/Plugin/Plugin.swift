import Foundation
import Capacitor
import Braintree
import BraintreeDropIn

@objc(BraintreePlugin)
public class BraintreePlugin: CAPPlugin {
    var token: String!
    
    /**
     * Set Braintree API token
     * Set Braintree Switch URL
     */
    @objc func setToken(_ call: CAPPluginCall) {
        /**
         * Set App Switch
         */
        let bundleIdentifier = Bundle.main.bundleIdentifier!
        BTAppSwitch.setReturnURLScheme("\(bundleIdentifier).payments")
        
        /**
         * Assign API token
         */
        self.token = call.hasOption("token") ? call.getString("token") : ""
        if self.token.isEmpty {
            call.reject("A token is required.")
            return
        }
        call.resolve()
    }
    
    /**
     * Show DropIn UI
     */
    @objc func showDropIn(_ call: CAPPluginCall) {
        guard let amount = call.getString("amount") else {
            call.reject("An amount is required.")
            return;
        }
        
        /**
         * DropIn UI Request
         */
        let request = BTDropInRequest()
        //request.amount = amount // <---------------@@@ this cause error in IOS
        
        /**
         * Disabble Payment Methods
         */
        if call.hasOption("disabled") {
            let disabled = call.getArray("disabled", String.self)
            if disabled!.contains("paypal") {
                request.paypalDisabled = true;
            }
            if disabled!.contains("venmo") {
                request.venmoDisabled = true;
            }
            if disabled!.contains("applePay") {
                request.applePayDisabled = true;
            }
            if disabled!.contains("card") {
                request.cardDisabled = true;
            }
        }
        
        /**
         * Initialize DropIn UI
         */
        let dropIn = BTDropInController(authorization: self.token, request: request)
        { (controller, result, error) in
            if (error != nil) {
                call.reject("Something went wrong.")
            } else if (result?.isCancelled == true) {
                call.resolve(["cancelled": true])
            } else if let result = result {
                call.resolve(self.getPaymentMethodNonce(paymentMethodNonce: result.paymentMethod!))
            }
            controller.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.async {
            self.bridge.viewController.present(dropIn!, animated: true, completion: nil)
        }
    }
    
    @objc func getPaymentMethodNonce(paymentMethodNonce: BTPaymentMethodNonce) -> [String:Any] {
        var payPalAccountNonce: BTPayPalAccountNonce
        var cardNonce: BTCardNonce
        var venmoAccountNonce: BTVenmoAccountNonce
        
        var response: [String: Any] = ["cancelled": false]
        response["nonce"] = paymentMethodNonce.nonce
        response["type"] = paymentMethodNonce.type
        response["localizedDescription"] = paymentMethodNonce.localizedDescription
        
        /**
         * Handle Paypal Response
         */
        if(paymentMethodNonce is BTPayPalAccountNonce){
            payPalAccountNonce = paymentMethodNonce as! BTPayPalAccountNonce
            response["paypal"] = [
                "email": payPalAccountNonce.email,
                "firstName": payPalAccountNonce.firstName,
                "lastName": payPalAccountNonce.lastName,
                "phone": payPalAccountNonce.phone,
                "clientMetadataId": payPalAccountNonce.clientMetadataId,
                "payerId": payPalAccountNonce.payerId
            ]
        }
        
        /**
         * Handle Card Response
         */
        if(paymentMethodNonce is BTCardNonce){
            cardNonce = paymentMethodNonce as! BTCardNonce
            response["card"] = [
                "lastTwo": cardNonce.lastTwo!,
                //"network": cardNonce.cardNetwork // <---------------@@@ this cause error in IOS
            ]
        }
        
        /**
         * Handle Card Response
         */
        if(paymentMethodNonce is BTVenmoAccountNonce){
            venmoAccountNonce = paymentMethodNonce as! BTVenmoAccountNonce
            response["venmo"] = [
                "username": venmoAccountNonce.username
            ]
        }
        
        return response;
        
    }
}
