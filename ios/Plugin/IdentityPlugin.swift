//
//  IdentityPlugin.swift
//  CapacitorNativeCaf
//
//  Created by Vinícius Gonçalves de Andrade on 25/05/23.
//

import Foundation
import Identity
import Capacitor

public class IdentityPlugin {
    var identity: IdentitySDK!
    var call: CAPPluginCall!
    @objc func initialize(mobileToken: String, call: CAPPluginCall) {
        self.identity = IdentitySDK.Builder(mobileToken: mobileToken)
                    .build()
        self.call = call
    }

    @objc func verifyPolicy(personID: String, policyId: String) {
        self.identity.verifyPolicy(personID: personID, policyId: policyId) { result in
                    switch result {
                    case .onSuccess((let isAuthorized, let attestation)):
                        var ret = JSObject()
                        ret["isAuthorized"] = isAuthorized
                        ret["attestation"] = attestation
                        self.call.resolve(ret)
                    case .onPending((let isAuthorized, let attestation)):
                        var ret = JSObject()
                        ret["isAuthorized"] = isAuthorized
                        ret["attestation"] = attestation
                        self.call.resolve(ret)
                    case .onError(let error):
                        self.call.reject(error.errorDescription ?? "Houve um problema interno, tente novamente mais tarde!")
                    }
                }
    }
}
