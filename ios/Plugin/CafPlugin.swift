import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CafPlugin)
public class CafPlugin: CAPPlugin {
    @objc func verifyPolicy(_ call: CAPPluginCall) {
        call.keepAlive = true
        let ident = IdentityPlugin()
        ident.initialize(mobileToken: call.getString("jwt", ""), call: call)
        DispatchQueue.main.async {
            ident.verifyPolicy(personID: call.getString("personId", ""), policyId: call.getString("policyId", ""));
        }
    }
}
