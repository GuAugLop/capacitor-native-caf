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
        let ident = Identity()
        ident.initialize()
        DispatchQueue.main.async {
            ident.verifyPolicy()
        }
    }
}
