import Foundation
import Capacitor
import Identity

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CafPlugin)
public class CafPlugin: CAPPlugin {
    var identity: IdentitySDK!
    @objc func verifyPolicy(_ call: CAPPluginCall) {
        call.keepAlive = true
        self.identity = IdentitySDK.Builder(mobileToken: call.getString("jwt", ""))
            .build()
        DispatchQueue.main.async {
            self.identity.verifyPolicy(personID: call.getString("personId", ""), policyId: call.getString("policyId", "")) { result in
                switch result {
                case .onSuccess((let isAuthorized, let attestation)):
                    var ret = JSObject()
                    ret["isAuthorized"] = isAuthorized
                    ret["attestation"] = attestation
                    if let bridgeViewController = self.bridge?.viewController {
                        bridgeViewController.dismiss(animated: true, completion: nil)
                        call.resolve(ret)
                    } else {
                        call.resolve(ret)
                    }
                case .onPending((let isAuthorized, let attestation)):
                    var ret = JSObject()
                    ret["isAuthorized"] = isAuthorized
                    ret["attestation"] = attestation
                    if let bridgeViewController = self.bridge?.viewController {
                        bridgeViewController.dismiss(animated: true, completion: nil)
                        call.resolve(ret)
                    } else {
                        call.resolve(ret)
                    }
                case .onError(let error):
                    if let bridgeViewController = self.bridge?.viewController {
                        bridgeViewController.dismiss(animated: true, completion: nil)
                        call.reject(error.errorDescription ?? "Houve um problema interno, tente novamente mais tarde!")
                    } else {
                        call.reject(error.errorDescription ?? "Houve um problema interno, tente novamente mais tarde!")
                    }
                }
            }
        }
    }
}
