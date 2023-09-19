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
        
        self.identity = IdentitySDK.Builder(mobileToken: jwt!).setStage(.PROD)
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
                        switch error {
                        case .PermissionReason(let permission):
                            call.reject("As permissões devem ser concedidas para prosseguir (\(permission)).")
                            bridgeViewController.dismiss(animated: true, completion: nil)
                            return
                        case .AvailabilityReason(let message):
                            call.reject(message)
                            bridgeViewController.dismiss(animated: true, completion: nil)
                            return
                        case .NetworkReason:
                            call.reject("Falha na conexão, verifique sua internet e tente novamente.")
                            bridgeViewController.dismiss(animated: true, completion: nil)
                            return
                        case .ServerReason(_, let code):
                            if (code == 404) {
                                var ret = JSObject()
                                ret["isAuthorized"] = false
                                ret["registered"] = false
                                ret["attestation"] = nil
                                call.resolve(ret)
                                bridgeViewController.dismiss(animated: true, completion: nil)
                                return
                            } else {
                                call.reject("Houve um problema interno de comunicação, tente novamente mais tarde!")
                                bridgeViewController.dismiss(animated: true, completion: nil)
                                return
                            }
                        case .SecurityReason(_):
                            call.reject("Por algum motivo de segurança, seu dispositivo não permite prosseguir com a solicitação.")
                            bridgeViewController.dismiss(animated: true, completion: nil)
                            return
                        case .StorageReason(_):
                            call.reject("Armazenamento interno cheio. Libere espaço no seu dispositivo para prosseguir.")
                            bridgeViewController.dismiss(animated: true, completion: nil)
                            return
                        case .LibraryReason(let message):
                            call.reject(message)
                            bridgeViewController.dismiss(animated: true, completion: nil)
                            return
                        case .PolicyReason(_):
                            call.reject("Política de segurança não suportada.");
                            bridgeViewController.dismiss(animated: true, completion: nil)
                            return
                        @unknown default:
                            call.reject(error.errorDescription ?? "Houve um problema interno, tente novamente mais tarde!")
                            bridgeViewController.dismiss(animated: true, completion: nil)
                            return
                        }
                    } else {
                        call.reject(error.errorDescription ?? "Houve um problema interno, tente novamente mais tarde!")
                    }
                }
            }
        }
    }
}
