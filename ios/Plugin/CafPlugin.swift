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
        let personId = call.getString("personId")
        let jwt = call.getString("jwt")
        let policyId = call.getString("policyId")
        if (personId == nil || jwt == nil || policyId == nil) {
            call.reject("missing params: jwt, personId or policyId ");
        }
        
        self.identity = IdentitySDK.Builder(mobileToken: jwt!).setStage(IdentityStage.DEV)
            .build()
        DispatchQueue.main.async {
            self.identity.verifyPolicy(personID: personId!, policyId: policyId!) { result in
                switch result {
                case .onSuccess((let isAuthorized, let attestation)):
                    var ret = JSObject()
                    print(isAuthorized)
                    print(attestation)
                    ret["isAuthorized"] = isAuthorized
                    ret["registered"] = true
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
                    ret["registered"] = true
                    ret["attestation"] = attestation
                    if let bridgeViewController = self.bridge?.viewController {
                        bridgeViewController.dismiss(animated: true, completion: nil)
                        call.resolve(ret)
                    } else {
                        call.resolve(ret)
                    }
                case .onError(let error):
                    if let bridgeViewController = self.bridge?.viewController {
                        var msg = "Houve um problema interno, tente novamente mais tarde!"
                        switch error {
                        case .PermissionReason(let permission):
                            msg = "\(permission) é necessária para iniciar o SDK. Por favor, requisite-a ao seu usuário"
                        case .AvailabilityReason(let message):
                            msg = message
                        case .NetworkReason:
                            msg = "Falha ao conectar-se ao servidor"
                        case .ServerReason(let message, let code):
                            msg = "message: \(message) \n with code: \(code ?? 00)"
                        case .SecurityReason(let message):
                            msg = message
                        case .StorageReason(let message):
                            msg = message
                        case .LibraryReason(let message):
                            msg = message
                        case .PolicyReason(let message):
                            msg = message
                        @unknown default:
                            msg = "Houve um problema interno, tente novamente mais tarde!"
                        }
                        bridgeViewController.dismiss(animated: true, completion: nil)
                        call.reject(msg)
                    } else {
                        call.reject(error.errorDescription ?? "Houve um problema interno, tente novamente mais tarde!")
                    }
                }
            }
        }
    }
}
