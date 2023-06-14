//
//  IdentityPlugin.swift
//  CapacitorNativeCaf
//
//  Created by Vinícius Gonçalves de Andrade on 25/05/23.
//

import Foundation
import Identity

public class Identity {
    identify: IdentitySDK
    @objc func initialize(mobileToken) {
        self.identity = IdentitySDK.Builder(mobileToken: mobileToken)
                    .build()
    }

    @objc func verifyPolicy(personId) {
        self.identity = IdentitySDK.Builder(mobileToken: "mobileToken")
                    .build()
    }
}
