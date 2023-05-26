//
//  Identity.swift
//  CapacitorNativeCaf
//
//  Created by Vinícius Gonçalves de Andrade on 25/05/23.
//

import Foundation

public class Identity {
    identify: IdentitySDK!
    @objc func initialize(mobileToken) {
        self.identity = IdentitySDK.Builder(mobileToken: mobileToken)
                    .build()
    }

    @objc func verifyPolicy(personId) {
        self.identity.verifyPolicy(personID: personID, policyId: policyId) { result in
                    switch result {
                    case .onSuccess((let isAutorized, let attestation)):
                        CAPBridge.instance()?.getSavedCall().resolve();
                    case .onPending((let isAutorized, let attestation)):
                        CAPBridge.instance()?.getSavedCall().resolve();
                    case .onError(let error):
                        CAPBridge.instance()?.getSavedCall().reject("deu erro");
                    }
                }
    }
}
