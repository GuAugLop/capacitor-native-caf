package com.gs3.plugins.caf

import android.content.Context
import com.combateafraude.identity.input.Identity
import com.combateafraude.identity.input.VerifyPolicyListener
import com.combateafraude.identity.output.*
import com.combateafraude.identity.output.authenticatorfailure.LibraryReason
import com.combateafraude.identity.output.authenticatorfailure.PermissionReason
import com.combateafraude.identity.output.authenticatorfailure.StorageReason
import com.getcapacitor.JSObject
import com.getcapacitor.PluginCall


class IdentityPlugin(context: Context) {
    var context = context;
    private fun build(jwt: String): Identity {
        return Identity.Builder(jwt, this.context).build();
    }
    fun verifyPolicy(personId: String, jwt: String, policyId: String, call: PluginCall){
        var identity = this.build(jwt);

        return identity.verifyPolicy(personId, policyId, object : VerifyPolicyListener {
            override fun onSuccess(isAuthorized: Boolean, attestation: String?) {
                val ret = JSObject()
                ret.put("isAuthorized", isAuthorized)
                ret.put("attestation", attestation)
                call.resolve(ret);
            }

            override fun onPending(isAuthorized: Boolean, attestation: String?) {
                val ret = JSObject()
                ret.put("isAuthorized", isAuthorized)
                ret.put("attestation", attestation)
                call.resolve(ret);
            }

            override fun onError(failure: Failure?) {
                if (failure is PermissionReason) {
                    // permission must be granted by the user to start the SDK
                    call.reject("As permissões devem ser concedidas para prosseguir.")
                }else if (failure is NetworkReason) {
                    // internet connection failure
                    call.reject("Falha na conexão, verifique sua internet e tente novamente.")
                } else if (failure is ServerReason) {
                    // there was a problem in any communication with the CAF servers, let us know!
                    call.reject("Houve um problema interno de comunicação, tente novamente mais tarde!")
                } else if (failure is SecurityReason) {
                    // some security reason on the user's device prevents the use of the SDK
                    call.reject("Por algum motivo de segurança, seu dispositivo não permite prosseguir com a solicitação.")
                } else if (failure is StorageReason) {
                    // ask your user to free up internal storage space
                    call.reject("Armazenamento interno cheio. Libere espaço no seu dispositivo para prosseguir.")
                } else if (failure is LibraryReason) {
                    // some internal library encountered problems running
                    call.reject("Houve um problema interno, tente novamente mais tarde!");
                } else if (failure is PolicyReason) {
                    // you are using a policy that we do not yet support
                    call.reject("Política de segurança não suportada.");
                } else if (failure == null) {
                    call.reject("");
                } else {
                    call.reject(failure.message)
                }
            }

        })
    }
}